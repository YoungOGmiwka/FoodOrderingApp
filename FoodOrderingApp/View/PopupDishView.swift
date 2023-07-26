//
//  PopupDishView.swift
//  FoodOrderingApp
//
//  Created by Михаил on 13.07.2023.
//

import SwiftUI
import URLImage

struct PopupDishView: View {
    
    var animation: Namespace.ID

    @EnvironmentObject var popupDishData: PopupDishModel

    @EnvironmentObject var cartData: CartViewModel

    @State private var isLiked = false
    
    var body: some View {
        
        ZStack {
            HStack {
                if let imagUrl = popupDishData.selectedDish.imageURL,
                   let url = URL(string: imagUrl){
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 198, height: 204, alignment: .center)
                            .clipped()
                            .padding(.top, 25)
                            .background(
                                Color.black.opacity(0.07)
                            .frame(width: 311, height: 232)
                            .cornerRadius(10))
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
            .padding(.top, 16)
                    
            VStack (alignment: .leading, spacing: 8) {
                Text(popupDishData.selectedDish.name)
                    .font(
                        Font.custom("SF Pro Display", size: 16)
                            .weight(.medium))
                    .kerning(0.16)
                    .foregroundColor(.black)
                    
                HStack(spacing: 2) {
                    Text("\(popupDishData.selectedDish.price)")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .kerning(0.14)
                        .foregroundColor(.black)
                    Text("₽")
                        .font(.system(size: 14))
                
                    Text(" · \(popupDishData.selectedDish.weight)г")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .kerning(0.14)
                        .foregroundColor(.black.opacity(0.5))
                }
                
                Text(popupDishData.selectedDish.description)
                    .font(Font.custom("SF Pro Display", size: 14))
                    .kerning(0.14)
                    .foregroundColor(.black.opacity(0.65))
                
                Button(action: {
                    cartData.add(item: popupDishData.selectedDish)
                }, label: {
                    Text("\(isAddedToCart() ? "Добавлено" : "Добавить в корзину")")
                        .font(Font.custom("SF Pro Display", size: 16)
                            .weight(.medium))
                        .kerning(0.1)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 82)
                        .padding(.vertical, 15)
                        .background(
                            Color("primary"))
                        .cornerRadius(10)
                        .frame(width: 317, height: 48)
                })
                .frame(alignment: .bottom)
                .padding(.top, 8)
                .padding(.bottom, 16)
            }
            .padding(.top, 255)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .frame(width: 343, height: 476)
        .background(.white)
        .cornerRadius(15)
        .overlay {
            HStack(spacing: 8) {
                Button(action: {
                    self.isLiked.toggle()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color.white)
                            .frame(width: 40, height: 40)
                        image(Image(systemName: "heart.fill"), show: isLiked)
                        image(Image(systemName: "heart"), show: !isLiked)
                    }
                })
                
                Button(action: {
                    popupDishData.showPopup.toggle()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color.white)
                            .frame(width: 40, height: 40)

                        Image(systemName: "xmark")
                            .font(.system(size: 14)).fontWeight(.medium)
                            .tint(.black)
                    }
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .topTrailing)
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
    
    func isAddedToCart() -> Bool {
        return cartData.selectedItems.contains { item in
            return self.popupDishData.selectedDish.id == item.id
        }
    }
    
    private func image(_ image: Image, show: Bool) -> some View {
        image

            .tint(isLiked ? .red : .black)
            .font(.system(size: 24))
            .scaleEffect(show ? 1 : 0)
            .opacity(show ? 1 : 0)
            .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: show)
    }
}

struct PopupDishView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CartViewModel())
            
    }
}
