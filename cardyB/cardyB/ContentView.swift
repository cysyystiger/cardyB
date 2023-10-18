//
//  ContentView.swift
//  cardyB
//
//  Created by bernieteng on 2023/10/17.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""

    var body: some View {
        VStack {
            Text(message)
                .padding()

            Button(action: {
                fetchData()
            }) {
                Text("Fetch Data")
            }
        }
    }

    func fetchData() {
        guard let url =  URL(string:"http://localhost:3000/api/data")
        else{
            return
        }

        //### This is a little bit simplified. You may need to escape `username` and `password` when they can contain some special characters...
        let body = "hello"
        let finalBody = body.data(using: .utf8)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request){
            (data, response, error) in
            print(response as Any)
            if let error = error {
                print(error)
                return
            }
            guard let data = data else{
                return
            }
            print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")

        }.resume()
    }
}

//struct ContentView: View {
//    @State private var message = ""
//    @State private var selectedOption: String? = nil
//    @State private var showResult = false
//    @State private var isDropdownVisible = false
//
//    var body: some View {
//        VStack {
//            Text("Card")
//                .font(.largeTitle)
//                .padding()
//
//            TextField("Select an Option", text: .constant(selectedOption ?? "")) // Display selected option
//                .onTapGesture {
//                    isDropdownVisible.toggle()
//                }
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button(action: {
//                isDropdownVisible.toggle()
//            }) {
//                Text("▼")
//            }
//            .padding(.trailing)
//
//            if isDropdownVisible {
//                List {
//                    Button(action: {
//                        selectedOption = "Option 1"
//                        isDropdownVisible.toggle()
//                    }) {
//                        Text("Option 1")
//                    }
//                    Button(action: {
//                        selectedOption = "Option 2"
//                        isDropdownVisible.toggle()
//                    }) {
//                        Text("Option 2")
//                    }
//                    Button(action: {
//                        selectedOption = "Option 3"
//                        isDropdownVisible.toggle()
//                    }) {
//                        Text("Option 3")
//                    }
//                }
//                .frame(height: 150) // Adjust the height as needed
//                .border(Color.primary)
//            }
//
//            Button(action: {
//                sendDataToServer()
//            }) {
//                Text("Submit")
//            }
//            .padding()
//
//            if showResult {
//                Text(message)
//                    .padding()
//            }
//        }
//    }
//
//    func sendDataToServer() {
//        // Simulate sending selectedOption to the server (you can replace this with your server code)
//        if let option = selectedOption {
//            message = "Selected Option: \(option)"
//        } else {
//            message = "No option selected."
//        }
//        showResult = true
//    }
//}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

