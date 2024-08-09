import OSLog
import Foundation

func parseCountry(_ data: Data) -> String {
    // Log the raw string representation of the data for debugging purposes
    if let string = String(data: data, encoding: .utf8) {
        os_log("%@", string)
    }

    do {
        // Attempt to deserialize the JSON into an array of dictionaries
        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
           let country = jsonArray.first { // Access the first dictionary in the array
            
            // Extract the necessary fields from the country dictionary
            let capital = (country["capital"] as? [String])?.first ?? "Unknown"
            let region = country["region"] as? String ?? "Unknown"
            let subregion = country["subregion"] as? String ?? "Unknown"
            let population = country["population"] as? Int ?? 0
            
            // Construct the result string
            let result = """
            Capital: \(capital)
            Region: \(region)
            Subregion: \(subregion)
            Population: \(population)
            """
            
            return result
        } else {
            // Handle cases where JSON data structure is unexpected
            return "Invalid JSON data"
        }
    } catch {
        // Return an error message if JSON parsing fails
        return "JSON parsing error: \(error.localizedDescription)"
    }
}
