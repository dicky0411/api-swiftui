import SwiftUI

struct DetailView: View {
    @State private var urlText: String = ""
    @State private var jsonResponse: String = ""
    let product: Product

    var body: some View {
        VStack(spacing: 20) {
            Text("Detail view for \(product.name)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(product.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Image(systemName: product.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.accentColor)
            
            TextField("Enter URL...", text: $urlText, onCommit: {
                fetchData(from: urlText)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .background(Color(.windowBackgroundColor))
            .cornerRadius(10)
            .padding(.horizontal)
            
            ScrollView {
                Text(jsonResponse)
                    .padding()
                    .background(Color(.windowBackgroundColor))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 600)
        .background(Color(.windowBackgroundColor))
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    fetchData(from: urlText)
                }) {
                    Text("Fetch Data")
                }
            }
        }
    }

    private func fetchData(from urlString: String) {
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let jsonString = String(data: jsonData, encoding: .utf8) ?? "Unable to convert JSON to string"
                DispatchQueue.main.async {
                    jsonResponse = jsonString
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
