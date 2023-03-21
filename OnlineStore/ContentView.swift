//
//  ContentView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 09.03.23.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var cartManager: CartManager
    
    init() {
           UITabBar.appearance().barTintColor = UIColor(Color.theme.background)
       }

    var body: some View {
            TabView() {
                HomeView()
                    .tabItem {
                        Label("", systemImage: "text.justify")
                    }
                    .tag("Home")
                
                ShoppingCartView()
                    .tabItem {
                        Label("", systemImage: "bag")
                            .environment(\.symbolVariants, .none)
                    }
                    .badge(cartManager.totalAmount > 0 ? String(cartManager.totalAmount) : nil)
            }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CartManager())
    }
}
