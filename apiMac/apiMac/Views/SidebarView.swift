import SwiftUI

struct SidebarView: View {
    @Binding var selection: Product
    
    static var products: [Product] = [
        Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location",textbox: "Enter the IP:",baseurl:"https://ipwho.is/",endurl:""),
        Product(name: "FruitNutrition", description: "Get nutirition information from fruits", icon: "applelogo",textbox: "Enter the Fruit:",baseurl:"https://www.fruityvice.com/api/fruit/",endurl:""),
        Product(name: "AirPollution", description: "Detailed information about AirPollution", icon: "cloud.sun",textbox: "Enter the City:",baseurl:"https://api.waqi.info/feed/",endurl:"/?token=6ed027a8994d9f8d76d5ec37bd4293e257f69926"),
        Product(name:"CountryInfo",description:"Detailed information about world class countries", icon:"flag",textbox:"Enter the Country Name",baseurl:"https://restcountries.com/v3.1/name/",endurl:"")
    ]
    
    var body: some View {
        List(SidebarView.products, id: \.id, selection: $selection) { product in
            HStack {
                Image(systemName: product.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                }
                .padding(.vertical, 8)
                .cornerRadius(8)
            }
            .tag(product)
            .contentShape(Rectangle())
        }
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    SidebarView(selection: .constant(Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location",textbox: "Enter the IP:",baseurl:"https://ipwho.is/",endurl:"")))
}
