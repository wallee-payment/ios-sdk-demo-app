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
    @State private var selection = 0
    @State var homeNavPath = NavigationPath()
    @State var settingsNavPath = NavigationPath()
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.theme.background)
       }

    var handler: Binding<Int> { Binding(
            get: { self.selection },
            set: {
                if ($0 == self.selection) {
                    if($0 == 0) {
                        homeNavPath = NavigationPath()
                    }
                    if($0 == 2) {
                        settingsNavPath = NavigationPath()
                    }
                    }
                self.selection = $0
            }
        )}

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
                TabView(selection: handler) {
                    NavigationView {
                        HomeView(path: $homeNavPath)
                    }
                    .tabItem {
                        Label("", systemImage: "text.justify")
                    }
                    .tag(0)
                    
                    NavigationView {
                        ShoppingCartView()
                    }
                    .tabItem {
                        Label("", systemImage: "bag").environment(\.symbolVariants, .none)
                    }
                    .badge(cartManager.totalAmount > 0 ? String(cartManager.totalAmount) : nil)
                    .tag(1)
                    
                    NavigationView {
                        SettingsView(path: $settingsNavPath)
                    }
                    .tabItem {
                        Label("", systemImage: "gearshape")
                    }
                    .tag(2)
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
