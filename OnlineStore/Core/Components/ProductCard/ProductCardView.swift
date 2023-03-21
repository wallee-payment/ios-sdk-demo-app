//
//  ProductDetailView.swift
//  OnlineStore
//
//  Created by Ira Paliy on 01.03.23.
//


import SwiftUI

struct ProductCardView: View {
    var product: Product
    
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                Image(product.images[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack{
                    Text(product.name)
                        .font(.headline)
                        .lineLimit(2)
                    Text(product.brand)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                Spacer()
            }
            .frame(height: 300)
        }
        
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProductCardView(product: productList[4])
                .previewLayout(.fixed(width: 300, height: 510))
            ProductCardView(product: productList[1])
        }
    }
}
