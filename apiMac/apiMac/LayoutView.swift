import SwiftUI

struct LayoutView: View {
    @State private var selectedProduct = Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location",textbox: "Enter the IP:",baseurl:"https://ipwho.is/",endurl:"")

    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selectedProduct)
        } detail: {
            DetailView(product: selectedProduct)
        }
    }
}

struct LayoutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView()
    }
}
