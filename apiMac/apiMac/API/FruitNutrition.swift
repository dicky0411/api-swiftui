//
//  FruitNutrition.swift
//  apiMac
//
//  Created by Richard Li on 2024-08-09.
//
import OSLog
import Foundation
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
            let protein = nutritions["protein"] as? Double
            
            let result = """
            Calories: \(calories == nil ? "nil" : "\(calories!)g")
            Fat: \(fat == nil ? "nil" : "\(fat!)g")
            Sugar: \(sugar == nil ? "nil" : "\(sugar!)g")
            Carbs: \(carbs == nil ? "nil" : "\(carbs!)g")
            Protein: \(protein == nil ? "nil" : "\(protein!)g")
            """
            return result
        } else {
            return "Invalid JSON data"
        }
    } catch {
        return "JSON parsing error: \(error.localizedDescription)"
    }
}
