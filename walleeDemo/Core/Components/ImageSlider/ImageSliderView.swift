//
//  ImageSliderView.swift
//  walleeDemo
//
//  Created by Ira Paliy on 03.03.23.
//

import SwiftUI

struct ImageCarouselView: View {
    private var imgArray: [String]
    @State var slideGesture: CGSize = CGSize.zero
    @State private var currentIndex: Int = 0

    init(imgArray: [String]) {
        self.imgArray = imgArray
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                            ForEach(imgArray, id: \.self) {item in
                                Image(item)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                    }
                }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                    .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                    .animation(.spring())
                    .gesture(DragGesture().onChanged{ value in
                        self.slideGesture = value.translation
                    }
                                .onEnded{ value in
                        if self.slideGesture.width < -50 {
                            if self.currentIndex < imgArray.count - 1 {
                                withAnimation {
                                    self.currentIndex += 1
                                }
                            }
                        }
                        if self.slideGesture.width > 50 {
                            if self.currentIndex > 0 {
                                withAnimation {
                                    self.currentIndex -= 1
                                }
                            }
                        }
                        self.slideGesture = .zero
                    })
                
                if (imgArray.count > 1) {
                    HStack(spacing: 3) {
                        ForEach(0..<imgArray.count, id: \.self) { index in
                            Circle()
                                .frame(width: index == self.currentIndex ? 10 : 8,
                                       height: index == self.currentIndex ? 10 : 8)
                                .foregroundColor(index == self.currentIndex ? Color.blue : .white)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .padding(.bottom, 8)
                                .animation(.spring())
                        }
                    }
                }
            }
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ImageCarouselView(imgArray: productList[1].images)
        }.frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
    }
}
