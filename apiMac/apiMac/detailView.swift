import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Detail View")
                .font(.largeTitle)
                .padding()
            
            Text("This is the detail view content.")
                .padding()
            
            Spacer()
        }
        .frame(width: 400, height: 300)
        .background(Color(NSColor.windowBackgroundColor).edgesIgnoringSafeArea(.all))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
