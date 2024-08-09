//
//  IPAddress.swift
//  apiMac
//
//  Created by Richard Li on 2024-08-09.
//
import OSLog
import Foundation
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
