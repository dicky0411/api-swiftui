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

func parseIP(_ data: Data) -> String {
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
            return result
        } else {
            return "Invalid JSON data"
        }
    } catch {
        return "JSON parsing error: \(error.localizedDescription)"
    }
}

func parseFruits(_ data: Data) -> String {
    if let string = String(data: data, encoding: .utf8) {
        os_log("\(string)")
    }

    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let nutritions = json["nutritions"] as? [String: Any] {
            let calories = nutritions["calories"] as? Int
            let fat = nutritions["fat"] as? Double
            let sugar = nutritions["sugar"] as? Double
            let carbs = nutritions["carbohydrates"] as? Double
            let protein = nutritions["protein"] as? Int
            
            let result = """
            Calories: \(calories == nil ? "nil" : "\(calories!)")g
            Fat: \(fat == nil ? "nil" : "\(fat!)")g
            Sugar: \(sugar == nil ? "nil" : "\(sugar!)")g
            Carbs: \(carbs == nil ? "nil" : "\(carbs!)")g
            Protein: \(protein == nil ? "nil" : "\(protein!)")g
            """
            return result
        } else {
            return "Invalid JSON data"
        }
    } catch {
        return "JSON parsing error: \(error.localizedDescription)"
    }
}

func parseAir(_ data: Data) -> String {
    if let string = String(data: data, encoding: .utf8) {
        os_log("\(string)")
    }

    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
        let data = json["data"] as? [String: Any],
        let forecast = json["data"] as? [String: Any],
        let daily = forecast["forecast"] as? [String: Any],
        let dailyForecasts = daily["daily"] as? [String: Any]
        {
            let aqi = data["aqi"] as? Double
            let o3 = (dailyForecasts["o3"] as? [[String: Any]])?[2]["avg"] as? Double
            let pm10 = (dailyForecasts["pm10"] as? [[String: Any]])?[2]["avg"] as? Double
            let pm25 = (dailyForecasts["pm25"] as? [[String: Any]])?[2]["avg"] as? Double
            let uvi = (dailyForecasts["uvi"] as? [[String: Any]])?[2]["avg"] as? Double
            
        
            let result = """
            Air Quality Index: \(aqi == nil ? "nil" : "\(aqi!)")
            O3: \(o3 == nil ? "nil" : "\(o3!)")
            Pm10: \(pm10 == nil ? "nil" : "\(pm10!)")
            Pm25: \(pm25 == nil ? "nil" : "\(pm25!)")
            UV Index: \(uvi == nil ? "nil" : "\(uvi!)")
            """
            return result
        } else {
            return "Invalid JSON data"
        }
    } catch {
        return "JSON parsing error: \(error.localizedDescription)"
    }
}
