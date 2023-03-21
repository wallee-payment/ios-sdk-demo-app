//
//  OnlineStoreApp.swift
//  OnlineStore
//
//  Created by Ira Paliy on 01.03.23.
//

import SwiftUI

@main
struct OnlineStoreApp: App {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(CartManager())
        }
    }
}

