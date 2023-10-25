import SwiftUI

struct CardListView: View {
    @Binding var isShowingCardList: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text("Card List")
                    .font(.title)
                    .padding()

                List(0..<10, id: \.self) { index in
                    Text("Row \(index)")
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    isShowingCardList.toggle()
                }) {
                    Image(systemName: "house.fill")
                }
            )
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(isShowingCardList: .constant(true))
    }
}
