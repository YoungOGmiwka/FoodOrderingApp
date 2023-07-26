//
//  ItemCartView.swift
//  FoodOrderingApp
//
//  Created by Михаил on 18.07.2023.
//

import SwiftUI
import URLImage

struct ItemCartView: View {
    
    @EnvironmentObject var cartData: CartViewModel
    var dish: Dishes
    var numberOfDishes: Int
    
    var body: some View {
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color.black.opacity(0.07))
                    .frame(width: 62, height: 62)
                ZStack {
                    if let imagUrl = dish.imageURL,
                       let url = URL(string: imagUrl){
                        URLImage(url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48.3, height: 52.8, alignment: .center)
                                .clipped()
                        }
                    }
                }
                .padding(.leading, 4)
                .padding(.top, 7)
            }
            .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(dish.name)
                    .font(
                        Font.custom("SF Pro Display", size: 14)
                            .weight(.medium))
                    .kerning(0.16)
                    .foregroundColor(.black)
                
                HStack(spacing: 2) {
                    Text("\(dish.price)")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .kerning(0.14)
                        .foregroundColor(.black)
                    Text("₽")
                        .font(.system(size: 14))
                    
                    Text(" · \(dish.weight)г")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .kerning(0.14)
                        .foregroundColor(.black.opacity(0.5))
                }
            }
            
            Spacer(minLength: 0)
            
            HStack(alignment: .center, spacing: 16) {
                Button {
                    cartData.decrease(item: dish)
                    
                } label: {
                    Image("minus")
                        .frame(width: 24, height: 24)
                }
                .padding(.vertical, 4)
                .padding(.leading, 6)
                
                Text("\(numberOfDishes)")
                    .font(
                        Font.custom("SF Pro Display", size: 14)
                                            .weight(.medium))
                        .kerning(0.14)
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                
                Button {
                    cartData.add(item: dish)
                    
                } label: {
                    Image("plus")
                        .frame(width: 24, height: 24)
                }
                .padding(.vertical, 4)
                .padding(.trailing, 6)
            }
            .background(Color.black.opacity(0.07))
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ItemCartView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCartView(dish: Dishes.simpleData, numberOfDishes: 1)
            .environmentObject(CartViewModel())
    }
}
