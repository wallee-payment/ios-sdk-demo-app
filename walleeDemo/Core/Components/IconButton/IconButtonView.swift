//
//  IconButtonView.swift
//  walleeDemo
//
//  Created by Ira Paliy on 07.03.23.
//

import SwiftUI

struct IconButtonView: View {
    var iconName: String
    var iconSize: CGFloat
    
    var body: some View {
        Image(iconName).resizable().frame(width: iconSize, height: iconSize)
    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconButtonView(iconName: "shopping-bag", iconSize: 30.0).previewLayout(.sizeThatFits)
    }
}
