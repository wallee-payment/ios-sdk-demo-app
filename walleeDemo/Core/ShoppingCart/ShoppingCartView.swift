//
//  ShoppingCartView.swift
//  walleeDemo
//
//  Created by Ira Paliy on 07.03.23.
//

import SwiftUI
import WalleePaymentSdk
import AlertToast

struct ShoppingCartView: View {
    @EnvironmentObject var cartManager: CartManager
    @StateObject private var paymentManager: PaymentManager = PaymentManager(onPaymentComplete: {
        print(">>paymentResult")
        //TO DO: cartManager.removeAllProducts()
    })

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
                        Text("CHF \(String(format: "%.2f", cartManager.totalPrice))")
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
                    paymentManager.onOpenSdkPress(cartProducts: cartManager.products)
                } label: {
                    Text("Checkout")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding([.top, .bottom], 5)
                        .foregroundColor(Color.theme.background)
                }
                .presentModalView(isPresented: $paymentManager.presentedModal, token: $paymentManager.token)
                .buttonStyle(.borderedProminent)
                .disabled(cartManager.products.count <= 0)
                .buttonBorderShape(.roundedRectangle(radius: 0.0))
                .padding()
            }
            
        }
        .toast(isPresenting: $paymentManager.toast.shouldShow){
            AlertToast(type: $paymentManager.toast.type.wrappedValue, subTitle: $paymentManager.toast.title.wrappedValue, style: .style(backgroundColor: Color.theme.shadow)
            )}
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
