//
//  walleeDemoApp.swift
//  walleeDemo
//
//  Created by Ira Paliy on 01.03.23.
//

import SwiftUI
import FirebaseCore

enum ColorSchemeSetting: String, CaseIterable {
    case light, dark, system
}



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct walleeDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var launchViewManager: LaunchViewManager
    @State private var chosenColorScheme = ColorSchemeSetting.system

        var selectedColorScheme: ColorScheme? {
            switch chosenColorScheme {
            case .light:
                return .light
            case .dark:
                return .dark
            case .system:
                return nil
            }
        }
    
    var body: some Scene {
        WindowGroup {
                ContentView().environmentObject(CartManager()).environmentObject(LaunchViewManager())
                .preferredColorScheme(selectedColorScheme)
        }
    }
}

