import SwiftUI

struct ContentView: View {
    var body: some View {
        PageView()
            .frame(minWidth: 1200, minHeight: 800) // Set minimum width and height
            .background(Color(NSColor.windowBackgroundColor).edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
