import SwiftUI

struct SelectCategoryView: View {
    @State private var message = ""
    @State private var selectedCategory = 0
    @State private var moneyAmount = ""
    @State private var isNavigationActive = false
    @State private var showResult = false

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
                        // sendDataToServer()
                        fetchData()
                        // Handle "Add card" button tap and navigate to the main page
                        isNavigationActive = true
                    }) {
                        Text("Submit")
                    }
                }
                
                
            }
            .padding()
            .background(NavigationLink("", destination: RecommendedCardView(), isActive: $isNavigationActive).opacity(0))
            
            if showResult {
                Text(message)
                    .padding()
            }
        }
    }
    
    func fetchData() {
        // Define a struct for your request data
        struct RequestData: Codable {
            var category_id: Int
            var amount: Double
            var user_id: Int
        }

        // Define a struct for your response data
        struct ResponseData: Codable {
            var cards: [Int]
            var amounts: [Double]
        }

        let requestData = RequestData(category_id: 8888, amount: 240.8, user_id: 3837) // Replace with actual data

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(requestData)
            print("Bernie", data)
            
            guard let url = URL(string: "http://localhost:3000/fetchAmount") else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("yufan Error: \(error)")
                    message = "Error!"
                    return
                }
                guard let data = data else {
                    print("yufan No data received")
                    message = "No data!"
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(ResponseData.self, from: data)
                    print("Response data: \(responseData.cards)")
                    message = "Data received: \(responseData.cards)"
                } catch {
                    print("Error decoding data: \(error)")
                    print("Raw data received: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
                    message = "Error decoding data!"
                }
            }.resume()
            showResult = true
        } catch {
            print("Error encoding data: \(error)")
            message = "Error encoding data!"
        }
    }
}
