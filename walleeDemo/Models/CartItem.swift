//
//  CartItem.swift
//  walleeDemo
//
//  Created by Ira Paliy on 16.03.23.
//

import Foundation


struct CartItem: Identifiable, Codable, Hashable {
    var id = UUID()
    var product: Product
    var count: Int
}


let cartList: [CartItem] = [
    .init(product: productList[0], count: 2),
]
