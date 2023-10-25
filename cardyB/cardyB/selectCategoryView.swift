import SwiftUI

struct SelectCategoryView: View {
    @State private var selectedCategory = 0
    @State private var moneyAmount = ""
    @State private var isNavigationActive = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        Text("Category 1").tag(0)
                        Text("Category 2").tag(1)
                        // Add more categories as needed
                    }
                }

                Section(header: Text("Money$")) {
                    TextField("Enter amount", text: $moneyAmount)
                }
                
                Section {
                    Button(action: {
                        // Handle "Add card" button tap and navigate to the main page
                        isNavigationActive = true
                    }) {
                        Text("Submit")
                    }
                }
                
                
            }

//            Button("Submit") {
//                // Handle submission and navigation here
//                isNavigationActive = true
//            }
            .padding()
            .background(NavigationLink("", destination: RecommendedCardView(), isActive: $isNavigationActive).opacity(0))
//            .background(NavigationLink("", destination: ContentView(), isActive: $isNavigationActive).opacity(0))
        }
    }
}
