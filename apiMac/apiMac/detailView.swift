import SwiftUI

struct DetailView: View {
    @State private var searchText: String = ""
    @State private var displayText: String = ""
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

            // Search Bar with Visible Background
            TextField("Search...", text: $searchText, onCommit: {
                displayText = searchText
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .background(Color.black.opacity(0.8)) // Light background for better visibility
            .cornerRadius(8) // Rounded corners for aesthetics
            .padding(.horizontal) // Horizontal padding for layout

            // Display the entered text below the search bar
            if !displayText.isEmpty {
                Text("You searched for: \(displayText)")
                    .padding()
            }
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(product: Product(name: "MyLocation", description: "Track your location with high accuracy", icon: "location"))
    }
}
