//
//  Product.swift
//  apiMac
//
//  Created by Richard Li on 2024-08-07.
//

import Foundation
struct Product: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let textbox: String
    let baseurl: String
    
    static let sampleProduct = Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location", textbox: "Enter the IP:",baseurl:"https://ipwho.is/")
}
