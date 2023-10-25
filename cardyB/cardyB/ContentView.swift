//
//  ContentView.swift
//  cardyB
//
//  Created by bernieteng on 2023/10/17.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    @State private var selectedOption: String? = nil
    @State private var showResult = false
    @State private var isDropdownVisible = false
    @State private var isShowingCardList = false // State for navigation link

    var body: some View {
        NavigationView {
            VStack {
                Text("Card")
                    .font(.largeTitle)
                    .padding()

                TextField("Select an Option", text: .constant(selectedOption ?? "")) // Display selected option
                    .onTapGesture {
                        isDropdownVisible.toggle()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    isDropdownVisible.toggle()
                }) {
                    Text("▼")
                }
                .padding(.trailing)

                if isDropdownVisible {
                    List {
                        Button(action: {
                            selectedOption = "Amex Gold"
                            isDropdownVisible.toggle()
                        }) {
                            Text("Amex Gold")
                        }
                        Button(action: {
                            selectedOption = "Discover"
                            isDropdownVisible.toggle()
                        }) {
                            Text("Discover")
                        }
                        Button(action: {
                            selectedOption = "Deserve"
                            isDropdownVisible.toggle()
                        }) {
                            Text("Deserve")
                        }
                    }
                    .frame(height: 150) // Adjust the height as needed
                    .border(Color.primary)
                }

                NavigationLink(destination: CardListView(isShowingCardList: $isShowingCardList), isActive: $isShowingCardList) {
                    EmptyView()
                }

                Button(action: {
                    // sendDataToServer()
                    fetchData()
                    isShowingCardList = true // Navigate to the second page when submitting
                }) {
                    Text("Submit")
                }
                .padding()

                if showResult {
                    Text(message)
                        .padding()
                }
            }
        }
    }

//    func fetchData() {
//        guard let url = URL(string: "http://localhost:3000/api/data") else {
//            return
//        }
//
//        //### This is a little bit simplified. You may need to escape `username` and `password` when they can contain some special characters...
//        let body = "hello"
//        let finalBody = body.data(using: .utf8)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = finalBody
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            print(response as Any)
//            if let error = error {
//                print("Bernie error")
//                print(error)
//                message = "error!"
//                return
//            }
//            guard let data = data else {
//                print("Bernie no data")
//                message = "No data!"
//                return
//            }
//            print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
//            print("Bernie got data")
//            message = "Got data!"
//        }.resume()
//        showResult = true
//    }
    func fetchData() {
        // Define a struct for your request data
        struct RequestData: Codable {
            var user_id: Int
            var cards: [String]
            var isAdd: Bool
        }

        // Define a struct for your response data
        struct ResponseData: Codable {
            var cards: [Int]
        }

        let requestData = RequestData(user_id: 3837, cards: ["amex", "visa"], isAdd: true) // Replace with actual data

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(requestData)
            print("Bernie", data)

//            guard let url = URL(string: "http://localhost:3000/api/data") else {
//                return
//            }
            guard let url = URL(string: "http://localhost:3000/updateCard") else {
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

//@main
//struct MyApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

