//
//  ContentView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 09.03.23.
//

import SwiftUI
import AlertToast

struct ContentView: View {

    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var launchViewManager: LaunchViewManager
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.theme.background)
       }

    var body: some View {
        if launchViewManager.isLaunchViewActive {
            LaunchView()
        } else {
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
                    
                    SettingsView()
                        .tabItem {
                            Label("", systemImage: "gearshape")
                        }
                }
                .onAppear{
                    // MOVE ME TO DIFFERENT PLACE!!!
                    UserDefaults.standard.set("36329", forKey: "spaceId")
                    UserDefaults.standard.set("71232", forKey: "userId")
                    UserDefaults.standard.set("MDc1ptkXkDGybujbSRSIUUHJ75jgoEjo4uUqrl05vyA=", forKey: "userToken")
                }
        }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CartManager())
    }
}
