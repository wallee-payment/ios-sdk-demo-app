//
//  ProductDetailView1.swift
//  OnlineStore
//
//  Created by Ira Paliy on 01.03.23.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack {
                        GeometryReader { image in
                            ImageCarouselView(imgArray: product.images)
                        }.frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
    
                        HStack {
                            Text("Brand: ")
                                .bold()
                                .foregroundColor(Color.theme.accent)
                            Text("\(product.brand)")
                                .foregroundColor(Color.theme.accent)
                            Spacer()
                        }.padding(.horizontal)
                        
                        HStack {
                            Text("Model: ")
                                .bold()
                                .foregroundColor(Color.theme.accent)
                            Text("\(product.name)")
                                .foregroundColor(Color.theme.accent)
                            Spacer()
                        }.padding(.horizontal)
                        
                        HStack {
                            Text("Price:   ")
                                .bold()
                                .foregroundColor(Color.theme.accent)
                            Text("\(product.currency) \(product.price)")
                                .foregroundColor(Color.theme.accent)
                            Spacer()
                        }.padding(.horizontal)
                        
                        HStack {
                            Text("Summary:")
                                .foregroundColor(Color.theme.accent)
                                .bold()
                            Spacer()
                        }.padding([.top, .leading])
                        Text(product.description)
                            .foregroundColor(Color.theme.accent)
                            .padding([.leading, .trailing])
                        
                        Spacer()
                    }.background(Color.theme.background)
                }.accentColor(Color.theme.accent)
                
                Button {
                    cartManager.addProduct(product: product)
                } label: {
                    Text("ADD TO CART")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        
                }
                .buttonBorderShape(.roundedRectangle(radius: 0.0))
                .border(Color.theme.accent, width: 2)
                .padding()
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailView(product: productList[0])
        }
    }
}
