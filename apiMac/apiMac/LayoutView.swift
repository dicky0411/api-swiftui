import SwiftUI

struct LayoutView: View {
    @State private var selectedProduct = Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location")
    
    var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView(selection: $selectedProduct)
        }, detail: {
            DetailView(product: selectedProduct)
        })
    }
}

#Preview {
    LayoutView()
}
