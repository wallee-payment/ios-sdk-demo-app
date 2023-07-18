//
//  ContentView.swift
//  walleeDemo
//
//  Created by Ira Paliy on 09.03.23.
//

import SwiftUI
import AlertToast

struct ContentView: View {

    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var launchViewManager: LaunchViewManager
    
    var spaceId: String = Foundation.UserDefaults.standard.string(forKey: "spaceId") ?? ""
    var userId: String = Foundation.UserDefaults.standard.string(forKey: "userId") ?? ""
    var userToken: String = Foundation.UserDefaults.standard.string(forKey: "userToken") ?? ""
    
    @State var merchantDataSaved: Bool = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.theme.background)
       }

    var body: some View {
        if launchViewManager.isLaunchViewActive {
            LaunchView().onAppear {
                merchantDataSaved = !spaceId.isEmpty && !userId.isEmpty && !userToken.isEmpty
            }
        } else {
            if (!merchantDataSaved) {
                UserDetailsView(onDataSaved: {
                    withAnimation {
                        merchantDataSaved.toggle()
                    }
                })
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
                
            }
        }
    }
    
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CartManager())
    }
}
