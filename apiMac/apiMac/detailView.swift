import SwiftUI

struct DetailView: View {
    @State private var ipAddress: String = ""
    @State private var jsonResponse: String = ""
    let product: Product
    let baseURL = "https://ipwho.is/"

    var body: some View {
        VStack(spacing: 20) {
            Text("UI Screen: \(product.name)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.top, 20)
            
            Text(product.description)
                .font(.title2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Image(systemName: product.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.accentColor)
            
            TextField("Enter IP address...", text: $ipAddress, onCommit: { fetchData(for: ipAddress)})
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(nsColor: .windowBackgroundColor))
                .cornerRadius(10)
                .frame(width: 300, height: 50) // Adjusted width and height
                .padding(.horizontal, 20)
            
            ScrollView {
                Text(jsonResponse)
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color(nsColor: .windowBackgroundColor))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 600)
        .background(Color(nsColor: .windowBackgroundColor))
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    fetchData(for: ipAddress)
                }) {
                    Text("Fetch Data")
                }
            }
        }
    }

    private func fetchData(for ipAddress: String) {
        let urlString = "\(baseURL)\(ipAddress)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                jsonResponse = "Invalid URL: \(urlString)"
            }
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    jsonResponse = "Error fetching data: \(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    jsonResponse = "Server error. Status code: \(statusCode)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    jsonResponse = "No data received"
                }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let country = json["country"] as? String,
                   let city = json["city"] as? String,
                   let continent = json["continent"] as? String,
                   let latitude = json["latitude"] as? Double,
                   let longitude = json["longitude"] as? Double {
                    let result = """
                    Country: \(country)
                    City: \(city)
                    Continent: \(continent)
                    Latitude: \(latitude)
                    Longitude: \(longitude)
                    """
                    DispatchQueue.main.async {
                        jsonResponse = result
                    }
                } else {
                    DispatchQueue.main.async {
                        jsonResponse = "Invalid JSON data"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    jsonResponse = "JSON parsing error: \(error.localizedDescription)"
                }
            }
        }

        task.resume()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(product: Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location"))
    }
}
