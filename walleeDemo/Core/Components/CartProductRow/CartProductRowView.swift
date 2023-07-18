//
//  CartProductRowView.swift
//  walleeDemo
//
//  Created by Ira Paliy on 15.03.23.
//

import SwiftUI

struct CartProductRowView: View {
    var cartItem: CartItem
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack {
            HStack {
                Image(cartItem.product.images[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                VStack {
                    HStack {
                        Text(cartItem.product.name)
                        Spacer()
                        Button {
                            cartManager.removeProduct(product: cartItem.product, amount: cartItem.count)
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    .padding([.horizontal, .top])
                    
                    Spacer()
                    
                    HStack {
                        HStack {
                            Button {
                                cartManager.removeProduct(product: cartItem.product)
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            Text(String(cartItem.count))
                            Button {
                                    cartManager.addProduct(product: cartItem.product)
                            }
                            label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                        Spacer()
                        Text("CHF \(String(format: "%.2f", cartItem.product.price))")
                    }
                    .padding([.horizontal, .bottom])
                }
            }.frame(height: 120)
             .padding([.horizontal])
        }
    }
}

struct CartProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductRowView(cartItem: cartList[0])
            .environmentObject(CartManager())
            .previewLayout(.sizeThatFits)
   }
}
