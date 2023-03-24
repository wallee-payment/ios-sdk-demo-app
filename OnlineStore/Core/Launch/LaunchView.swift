//
//  SplashView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 24.03.23.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var launchViewManager: LaunchViewManager
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            Image("wallee-logo")
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
        }
        .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            launchViewManager.toggleLaunchView()
                        }
                    }
                }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(LaunchViewManager())
    }
}
