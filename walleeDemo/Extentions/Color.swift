//
//  Color.swift
//  walleeDemo
//
//  Created by Ira Paliy on 07.03.23.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let background = Color("BackgroundColor")
    let accent = Color("AccentColor")
    let border = Color("BorderColor")
    let shadow = Color("ShadowColor")
}
