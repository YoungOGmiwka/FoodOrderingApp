//
//  CartView.swift
//  FoodOrderingApp
//
//  Created by Михаил on 18.07.2023.
//

import SwiftUI
import URLImage

struct CartView: View {
    
    @Environment(\.presentationMode) var present

    @EnvironmentObject var cartData: CartViewModel
    
    var body: some View {
        ZStack {
            HStack {
                Image("location")
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Санкт-Петербург")
                        .font(Font.custom("SF Pro Display", size: 18)
                            .weight(.medium))
                    Text("12 Августа, 2023")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .kerning(0.14)
                        .foregroundColor(.black.opacity(0.5))
                }

                Spacer()
                Image("photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipped()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            if cartData.selectedItems.isEmpty {
                Text("Корзина пуста")
                    .font(
                        Font.custom("SF Pro Display", size: 26)
                            .weight(.medium))

            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        var alreadyAdded = Set<Dishes>()
                        let uniqDishes = cartData.selectedItems.filter {
                            alreadyAdded.insert($0).inserted
                        }
                        
                        ForEach(uniqDishes) { item in
                            ItemCartView(dish: item, numberOfDishes: dishesCount(item: item))
                        }
                    }
                    .padding(.bottom, 86)
                }
                .padding(.top, 70)
                
                VStack {
                    HStack {
                        Button {
                            //
                        } label: {
                            HStack {
                                Text("Оплатить \(cartData.calculateTotalPrice())")
                                    .font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                                    .kerning(0.1)
                                Text("₽")
                                    .font(.system(size: 16))
                            }
                            .frame(width: 367, height: 48)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .background(
                                Color("primary"))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 22)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.black.opacity(0.03).ignoresSafeArea())
    }
    
    private func dishesCount(item: Dishes) -> Int {
        var count = 0
        cartData.selectedItems.forEach {
            if $0 == item {
                count += 1
            }
        }
        return count
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartViewModel())
    }
}
