//
//  walleeDemoApp.swift
//  walleeDemo
//
//  Created by Ira Paliy on 01.03.23.
//

import SwiftUI
import WalleePaymentSdk

enum ColorSchemeSetting: String, CaseIterable {
    case light, dark, system
}

@main
struct walleeDemoApp: App {
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
                .preferredColorScheme(selectedColorScheme).onOpenURL(perform: { url in
                    let _ = WalleePaymentSdk.onHandleOpenURL(url: url)
                })
        }
    }
}

