//
//  apiMacApp.swift
//  apiMac
//
//  Created by Richard Li on 2024-08-06.
//

import SwiftUI

@main
struct apiMacApp: App {
    var body: some Scene {
        WindowGroup {
            LayoutView()
        }
        .windowStyle(DefaultWindowStyle())
    }
}

#Preview {
    LayoutView()
        .frame(width: 100)
        .frame(height: 100)
}
