//
//  SettingsView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 25.05.23.
//

import SwiftUI

struct SettingsView: View {
    @State private var isShowingDetailView = true
    @State private var isDarkMode = false
    
    @State private var spaceId: String? = Foundation.UserDefaults.standard.string(forKey: "spaceId")
    @State private var userId: String? = Foundation.UserDefaults.standard.string(forKey: "userId")
    @State private var userToken: String? = Foundation.UserDefaults.standard.string(forKey: "userToken")
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Settings")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.theme.accent)
                        Spacer()
                        
                    }
                    VStack {
                        Text("User authentication Data").bold().padding()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Space ID").bold()
                                    Spacer()
                                    Text(spaceId ?? "")
                                }
                                HStack {
                                    Text("Application ID").bold()
                                    Spacer()
                                    Text(userId ?? "")
                                }
                                HStack {
                                    Text("Token").bold()
                                    Spacer()
                                    Text(userToken ?? "")
                                }
                            }
                            Spacer()
                        }
                        
                        
                    }
                    
                    HStack {
                        Spacer()
                            NavigationLink(destination: UserDetailsView(onDataSaved: {
                                spaceId = Foundation.UserDefaults.standard.string(forKey: "spaceId")
                                userId = Foundation.UserDefaults.standard.string(forKey: "userId")
                                userToken = Foundation.UserDefaults.standard.string(forKey: "userToken")
                            })
                            ) {
                                Text("Change")
                            }
                        }
                   
                    Spacer()
                    // Activate feature with relevant ticket
                    // Toggle("Dark Mode", isOn: $isDarkMode)
                    //     .padding().bold()
                }.padding()
            }
        }.navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
