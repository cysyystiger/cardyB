//import SwiftUI
//
//@main
//struct cardyBApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//
//struct cardyBApp_Tab: App {
//    var body: some Scene {
//        WindowGroup {
//            TabView {
//                NavigationView {
//                    SelectCategoryView()
//                }
//                .tabItem {
//                    Text("Payment")
//                }
//
//                NavigationView {
//                    ContentView()
//                }
//                .tabItem {
//                    Text("Card setup")
//                }
//            }
//        }
//    }
//}


import SwiftUI

@main
struct cardyBApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    SelectCategoryView()
                }
                .tabItem {
                    Text("Payment")
                }
                
                NavigationView {
                    ContentView()
                }
                .tabItem {
                    Text("Card setup")
                }
            }
        }
    }
}
