import SwiftUI

struct LayoutView: View {
    @State var product = "MyLocation"
    
    var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView(selection: $product)
        }, detail: {
            DetailView(product: product)
        })
    }
}

#Preview {
    LayoutView()
}
