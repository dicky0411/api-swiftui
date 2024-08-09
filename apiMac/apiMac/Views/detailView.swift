import SwiftUI
import OSLog
struct DetailView: View {
    @State private var userInput: String = ""
    @State private var jsonResponse: String = ""
    let product: Product

    var body: some View {
        VStack(spacing: 20) {
            Text("UI Screen: \(product.name)")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.top, 20)
                .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0)
             
            Text(product.description)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .background(Color(nsColor: .controlBackgroundColor).opacity(0.7))
                .cornerRadius(15)
                .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
            Image(systemName: product.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.cyan)
                .shadow(color: Color.white.opacity(0.6), radius: 15, x: 0, y: 0)
   // TextField
            TextField(product.textbox, text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(nsColor: .controlBackgroundColor).opacity(0.8))
                .cornerRadius(12)
               .foregroundColor(.white)
               .frame(width: 300, height: 50)
                .padding(.horizontal, 20)
                .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
            Button(action: {
                    fetchData(for: userInput)
                    }) {
                Text("Fetch Data")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding()
                    .frame(width: 300)
                    .background(Color.cyan)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(color: Color.white.opacity(0.5), radius: 10, x: 0, y: 0)
                    .scaleEffect(1.05)
                            }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.top, 10)

            ScrollView {
                Text(jsonResponse)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .background(Color(nsColor:
                        .controlBackgroundColor).opacity(0.8))
                .cornerRadius(12)
                .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                            }
            Spacer()
            .onChange(of: product, {
                            os_log("product changed to \(product.name)")
                            self.jsonResponse = ""
                            self.userInput = ""
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





