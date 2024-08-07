import SwiftUI

struct SidebarView: View {
    @Binding var selection: String
    
    var products: [String] = [
        "MyLocation",
        "IP2Region",
        "CountryInfo"
    ]
    
    var body: some View {
        List(products, id: \.self, selection: $selection) { product in
            Text(product)
        }
    }
}

#Preview {
    SidebarView(selection: .constant("MyLocation"))
}
