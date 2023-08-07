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
    let tabIndexes = ["home": 0, "cart": 1, "settings": 2]
    @State var homeNavPath = NavigationPath()
    @State var settingsNavPath = NavigationPath()
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.theme.background)
       }

    var handler: Binding<Int> { Binding(
            get: { self.selection },
            set: {
                if ($0 == self.selection) {
                    print("++++++++++++++++++", $0, settingsNavPath.isEmpty, homeNavPath.isEmpty)
                    if($0 == tabIndexes["home"] && !homeNavPath.isEmpty) {
                        homeNavPath.removeLast()
                    }
                    if($0 == tabIndexes["settings"] && !settingsNavPath.isEmpty) {
                        settingsNavPath.removeLast()
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
                    HomeView(path: $homeNavPath)
                        .tabItem {
                            Label("", systemImage: "text.justify")
                        }
                        .tag(tabIndexes["home"])
                    
                    ShoppingCartView()
                        .tabItem {
                            Label("", systemImage: "bag")
                                .environment(\.symbolVariants, .none)
                        }
                        .badge(cartManager.totalAmount > 0 ? String(cartManager.totalAmount) : nil)
                        .tag(tabIndexes["cart"])
                    
                    SettingsView(path: $settingsNavPath)
                        .tabItem {
                            Label("", systemImage: "gearshape")
                        }
                        .tag(tabIndexes["settings"])
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
