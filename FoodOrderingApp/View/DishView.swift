//
//  DishesView.swift
//  FoodOrderingApp
//
//  Created by Михаил on 07.07.2023.
//

import SwiftUI
import URLImage

struct DishView: View {
    
    let dish: Dishes
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.black.opacity(0.07))
                .frame(width: 109, height: 110)
            
            HStack(alignment: .center, spacing: 0) {
                if let imagUrl = dish.imageURL,
                   let url = URL(string: imagUrl){
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 87, height: 98, alignment: .center)
                            .clipped()
                    }
                }
            }
            .padding(.leading, 10)
            .padding(.top, 17)

            VStack {
                Text(dish.name)
                    .font(
                        Font.custom("SF Pro Display", size: 13))
                    .kerning(0.14)
                    .foregroundColor(.black)
                    .frame(width: 109, height: 15, alignment: .center)
                    .lineLimit(2, reservesSpace: true)
            }
            .offset(y: 78)
        }
    }
}

struct DishView_Previews: PreviewProvider {
    static var previews: some View {
        DishView(dish: Dishes.simpleData)
    }
}
