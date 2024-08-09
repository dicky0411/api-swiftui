import SwiftUI
import OSLog
struct DetailView: View {
    @State private var ipAddress: String = ""
    @State private var jsonResponse: String = ""
    let product: Product

    var body: some View {
        VStack(spacing: 20) {
                    Text("UI Screen: \(product.name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Image(systemName: product.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.cyan)
                    
                    TextField(product.textbox, text: $ipAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(nsColor: .darkGray))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .padding(.horizontal, 20)

                    Button(action: {
                        fetchData(for: ipAddress)
                    }) {
                        Text("Fetch Data")
                            .font(.body)
                            .padding()
                            .frame(width: 300)
                            .background(Color.cyan)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.top, 10)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal, 20)

                    ScrollView {
                        Text(jsonResponse)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(nsColor: .darkGray))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity)
                    }
            .onChange(of: product, {
                            os_log("product changed to \(product.name)")
                            self.jsonResponse = ""
                            self.ipAddress = ""
                        })
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 600)
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private func fetchData(for ipAddress: String) {
        os_log("fetchData for \(ipAddress)")
        let urlString = "\(product.baseurl)\(ipAddress)\(product.endurl)"
        os_log("\(urlString)")
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
            DispatchQueue.main.async {
                if product.name == "FruitNutrition" {
                    jsonResponse = parseFruits(data)
                } else if product.name == "MyLocation" {
                    jsonResponse = parseIP(data)
                } else if product.name == "AirPollution" {
                    jsonResponse = parseAir(data)
                }
            }
        }

        task.resume()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(product: Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location", textbox: "Enter the IP:", baseurl: "https://ipwho.is/",endurl:""))
    }
}





