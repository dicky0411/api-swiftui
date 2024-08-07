import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Detail View")
                .font(.largeTitle)
                .padding()

            Text("More details about the API Store...")
                .font(.body)
                .padding()

            Spacer()
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
