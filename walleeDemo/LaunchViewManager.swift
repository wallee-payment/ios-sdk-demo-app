//
//  LaunchViewManager.swift
//  walleeDemo
//
//  Created by Ira Paliy on 24.03.23.
//

import Foundation

class LaunchViewManager: ObservableObject {
    @Published var isLaunchViewActive: Bool = true
    
    func toggleLaunchView(){
        isLaunchViewActive.toggle()
    }
}
