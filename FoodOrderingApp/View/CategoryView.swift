//
//  CategoryView.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import SwiftUI
import URLImage

struct CategoryView: View {
    
    let category: Сategory
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)

            HStack {
                if let imgUrl = category.imageURL,
                   let url = URL(string: imgUrl) {
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(category.name)
                            .font(
                                Font.custom("SF Pro Display", size: 20)
                                    .weight(.medium))
                            .frame(width: 191, height: 50, alignment: .leading)
                            .padding(.trailing, 136)
                            .padding(.bottom, 86)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category.dummyData)
    }
}
