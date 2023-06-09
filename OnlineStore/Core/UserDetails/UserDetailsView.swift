//
//  UserDetailsView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 25.05.23.
//

import SwiftUI
import AlertToast

struct UserDetailsView: View {
    var onDataSaved: () -> Void
    @State private var spaceId: String = ""
    @State private var userId: String = ""
    @State private var userToken: String = ""
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("User details")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    
                }
                VStack {
                    TextField("Space ID", text: $spaceId).padding().overlay(VStack{Divider().offset(x: 0, y: 15)})
                    TextField("Application ID", text: $userId).padding().overlay(VStack{Divider().offset(x: 0, y: 15)})
                    TextField("Token", text: $userToken).padding().overlay(VStack{Divider().offset(x: 0, y: 15)})
                }.padding()
                Spacer()
                Button {
                    UserDefaults.standard.set(spaceId, forKey: "spaceId")
                    UserDefaults.standard.set(userId, forKey: "userId")
                    UserDefaults.standard.set(userToken, forKey: "userToken")
                    showToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.showToast = false
                        onDataSaved()
                    }
                } label: {
                    Text("Save")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding([.top, .bottom], 5)
                }
                .disabled(spaceId.count <= 0 || userId.count <= 0 || userToken.count <= 0)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 0.0))
                .padding()
            }.padding()
        }
        .toast(isPresenting: $showToast){
            AlertToast(type: .complete(Color.green), title: "Saved", style: .style(backgroundColor: Color.theme.shadow)
            )}
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(onDataSaved: {
            print("Saved user data to storage")
        })
    }
}
