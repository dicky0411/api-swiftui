//
//  ContentView.swift
//  apiMac
//
//  Created by Richard Li on 2024-08-06.
//

import SwiftUI



struct ContentView : View {
    var body: some View {
        NavigationView {
            HStack {
                // Icon
                Image(systemName: "globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.accentColor)
                    .padding()

                VStack(alignment: .leading, spacing: 20) {
                    // App Title
                    Text("API Store")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)

                    // Welcome Message
                    Text("Welcome to the API Store")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.secondary)

                    // Navigation Link to DetailView
                    Button(action: {
                        openDetailWindow()
                    }) {
                        Text("Explore Details")
                            .font(.system(size: 18, weight: .semibold))
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                }
                .padding()

                Spacer()
            }
            .padding()
            .background(Color(NSColor.windowBackgroundColor).edgesIgnoringSafeArea(.all))
        }
    }

    private func openDetailWindow() {
        let detailWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 400),
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered, defer: false)
        detailWindow.center()
        detailWindow.setFrameAutosaveName("Detail Window")
        detailWindow.contentView = NSHostingView(rootView: DetailView())
        detailWindow.makeKeyAndOrderFront(nil)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
