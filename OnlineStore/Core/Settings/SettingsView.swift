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
                                    Text(" ")
                                }
                                HStack {
                                    Text("Application ID").bold()
                                    Spacer()
                                    Text(" ")
                                }
                                HStack {
                                    Text("Token").bold()
                                    Spacer()
                                    Text(" ")
                                }
                            }
                            Spacer()
                        }
                        
                        
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: UserDetailsView()) {
                            Text("Change")
                        }
                    }
                   
                    Spacer()
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .padding().bold()
                }.padding()
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
