//
//  AppDelegate.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 14/07/2025.
//

import UIKit
import TrackerSDK


class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
            #if DEBUG
                TimerTrackerSDK.shared.isEnabled = true
            #else
                TimerTrackerSDK.shared.isEnabled = false
            #endif
        
            TimerTrackerSDK.shared.logger = { (tag, msg) in print("\(tag), \(msg)") }
                    
        return true
    }
}
