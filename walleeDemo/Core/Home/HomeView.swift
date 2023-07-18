//
//  HomeView.swift
//  walleeDemo
//
//  Created by Ira Paliy on 07.03.23.
//

import SwiftUI

struct HomeView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {

        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Text("New arrivals")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                }.padding()
                ScrollView (.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(productList, id: \.self) {
                            item in
                            ZStack {
                                NavigationLink(value: item) {
                                    ProductCardView(product: item)
                                }
                            }
                        }
                    }.navigationDestination(for: Product.self) {
                        item in ProductDetailView(product: item)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView().environmentObject(CartManager())
        }
    }
}
