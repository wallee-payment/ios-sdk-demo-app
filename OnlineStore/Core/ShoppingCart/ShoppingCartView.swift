//
//  ShoppingCartView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 07.03.23.
//

import SwiftUI
import WalleePaymentSdk

struct ShoppingCartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack{
                VStack{
                    HStack {
                        Text("Shopping Cart")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.theme.accent)
                        Spacer()
                        
                    }
                    
                    HStack {
                        Text("Your cart total is: ")
                        Spacer()
                        Text("CHF \(cartManager.totalPrice).00")
                    }
                    .padding()
                    .border(Color.theme.accent, width: 2)
                }.padding()
                
                ScrollView {
                    VStack {
                        if cartManager.products.count > 0 {
                            VStack {
                                ForEach (cartManager.products) {
                                    item in
                                    CartProductRowView(cartItem: item)
                                }
                            }
                            
                        } else {
                            Text("Your cart is empty")
                        }
                    }
                }
                    Button {
                            //let wallee = WalleePaymentSdk(eventObserver: self as! WalleePaymentResultObserver)
                            //  changeWalleeColorSchema(wallee: wallee)
                            //wallee.launchPayment(token: "", rootController: self as! UIViewController)
                    } label: {
                        Text("Checkout")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding([.top, .bottom], 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 0.0))
                    .padding()
            }
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShoppingCartView()
                .environmentObject(CartManager())
        }
    }
}
