//
//  UserDetailsView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 25.05.23.
//

import SwiftUI

struct UserDetailsView: View {
    @State private var spaceId: String = ""
    @State private var applicationId: String = ""
    @State private var token: String = ""
    
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
                    TextField("Application ID", text: $applicationId).padding().overlay(VStack{Divider().offset(x: 0, y: 15)})
                    TextField("Token", text: $token).padding().overlay(VStack{Divider().offset(x: 0, y: 15)})
                }.padding()
                Spacer()
                Button {
                } label: {
                    Text("Save")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding([.top, .bottom], 5)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 0.0))
                .padding()
            }.padding()
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}
