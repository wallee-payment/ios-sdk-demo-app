//
//  Cart.swift
//  OnlineStore
//
//  Created by Ira Paliy on 09.03.23.
//

import Foundation

class CartManager: ObservableObject {
    @Published var products: [CartItem] = []
    @Published var totalPrice: Float = 0
    @Published var totalAmount: Int = 0
    
    func addProduct(product: Product, amount: Int = 1){
        var addNewProduct = true
        
        for (index, item) in products.enumerated() {
            if item.product.id == product.id {
                products[index].count = products[index].count + amount
                addNewProduct = false
            }
            }
        
       if addNewProduct {
           products.append(CartItem(product: product, count: amount))
        }
        totalPrice += product.price
        totalAmount += amount
    }
    
    func removeProduct(product: Product, amount: Int = 1) {
        for (index, item) in products.enumerated() {
            if item.product.id == product.id {
                if products[index].count > amount {
                    products[index].count = products[index].count - amount
                    totalPrice -= product.price * Float(amount)
                    totalAmount -= amount
                } else if products[index].count == amount {
                    products = products.filter { $0.product.id != product.id }
                    totalAmount -= amount
                    totalPrice -= product.price * Float(amount)
                }
            }
        }
       
    }
    
    func removeAllProducts() {
        products = []
        totalAmount = 0
        totalPrice = 0
    }
}


