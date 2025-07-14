//
//  AppDemoSwiftUIApp.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 11/05/2025.
//

import SwiftUI

@main
struct AppDemoSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}
