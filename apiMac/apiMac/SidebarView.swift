import SwiftUI

struct SidebarView: View {
    @Binding var selection: Product
    
    var products: [Product] = [
        Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location"),
        Product(name: "IP2Region", description: "Get region information from IP addresses", icon: "globe"),
        Product(name: "CountryInfo", description: "Detailed information about countries", icon: "flag")
    ]
    
    var body: some View {
        List(products, id: \.id, selection: $selection) { product in
            HStack {
                Image(systemName: product.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                        .foregroundColor(selection == product ? .accentColor : .primary)
                    Text(product.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)
                .background(selection == product ? Color.accentColor.opacity(0.2) : Color.clear)
                .cornerRadius(8)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                selection = product
            }
        }
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    SidebarView(selection: .constant(Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location")))
}
