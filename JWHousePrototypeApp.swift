//
//  JWHousePrototypeApp.swift
//  JWHousePrototype
//
//  Created by Swathika Ganesh on 2/23/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct JWHousePrototypeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var networkManager = NetworkManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(networkManager)
        }
    }
}
