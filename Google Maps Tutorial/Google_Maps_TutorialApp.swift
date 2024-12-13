//
//  Google_Maps_TutorialApp.swift
//  Google Maps Tutorial
//
//  Created by Fatih Durmaz on 5.11.2024.
//

import SwiftUI
import GoogleMaps


@main
struct Google_Maps_TutorialApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("YourApiKey")
        return true
    }
}
