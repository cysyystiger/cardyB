import SwiftUI

struct RecommendedCardView: View {
    var body: some View {
        Form {
            Section(header: Text("Recommended Card")) {
                Text("Amex Gold") // Display the recommended card
            }

            Section(header: Text("Amount Saving")) {
                ForEach(0..<10) { index in
                    HStack {
                        Text("Card")
                        Spacer()
                        Text("USD")
                    }
                }
            }
        }
    }
}
