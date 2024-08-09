import SwiftUI

struct SidebarView: View {
    @Binding var selection: Product
    
    var products: [Product] = [
        Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location",textbox: "Enter the IP:",baseurl:"https://ipwho.is/"),
        Product(name: "FruitNutrition", description: "Get nutirition information from fruits", icon: "globe",textbox: "Enter the Fruit:",baseurl:"https://www.fruityvice.com/api/fruit/"),
        Product(name: "CountryInfo", description: "Detailed information about countries", icon: "flag",textbox: "Enter the Country:",baseurl:"")
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
                }
                .padding(.vertical, 8)
                .background(selection == product ? Color.accentColor.opacity(0.5) : Color.clear)
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
    SidebarView(selection: .constant(Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location",textbox: "IP?",baseurl:"https://ipwho.is/")))
}
