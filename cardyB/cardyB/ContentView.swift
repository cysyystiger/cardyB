//
//  ContentView.swift
//  cardyB
//
//  Created by bernieteng on 2023/10/17.
//

//import SwiftUI
//
//struct ContentView: View {
//    @State private var message = ""
//    @State private var optionalInput: String? = nil
//
//    var body: some View {
//        VStack {
//            Text(message)
//                .padding()
//
//            TextField("Optional Input", text: Binding(
//                get: {
//                    self.optionalInput ?? ""
//                },
//                set: {
//                    self.optionalInput = $0
//                }
//            ))
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding()
//
//            Button(action: {
//                sendDataToServer()
//            }) {
//                Text("Send Data")
//            }
//        }
//    }
//
//    func sendDataToServer() {
//        let url = URL(string: "http://localhost:3000/api/data")! // Replace with your server's address
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        if let input = optionalInput {
//            let parameters: [String: String] = ["optionalInput": input]
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
//            } catch {
//                print("Error encoding data: \(error)")
//                return
//            }
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let decodedData = try? JSONDecoder().decode([String: String].self, from: data) {
//                    message = decodedData["message"] ?? "Data not found"
//                }
//            }
//        }.resume()
//    }
//}

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    @State private var selectedOption: String? = nil
    @State private var showResult = false
    @State private var isDropdownVisible = false

    var body: some View {
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
                        selectedOption = "Option 1"
                        isDropdownVisible.toggle()
                    }) {
                        Text("Option 1")
                    }
                    Button(action: {
                        selectedOption = "Option 2"
                        isDropdownVisible.toggle()
                    }) {
                        Text("Option 2")
                    }
                    Button(action: {
                        selectedOption = "Option 3"
                        isDropdownVisible.toggle()
                    }) {
                        Text("Option 3")
                    }
                }
                .frame(height: 150) // Adjust the height as needed
                .border(Color.primary)
            }

            Button(action: {
                sendDataToServer()
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

    func sendDataToServer() {
        // Simulate sending selectedOption to the server (you can replace this with your server code)
        if let option = selectedOption {
            message = "Selected Option: \(option)"
        } else {
            message = "No option selected."
        }
        showResult = true
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

