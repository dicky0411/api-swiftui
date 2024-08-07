import SwiftUI

struct DetailView: View {
    let product: Product
    
    var body: some View {
        VStack {
            Text("Detail view for \(product.name)")
                .font(.largeTitle)
            Text(product.description)
                .font(.body)
            Image(systemName: product.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
        .padding()
    }
}

#Preview {
    DetailView(product: Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location"))
}
