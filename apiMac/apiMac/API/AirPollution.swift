//
//  AirPollution.swift
//  apiMac
//
//  Created by Richard Li on 2024-08-09.
//
import OSLog
import Foundation
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
