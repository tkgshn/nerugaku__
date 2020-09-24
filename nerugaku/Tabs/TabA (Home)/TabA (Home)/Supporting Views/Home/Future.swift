//
//  CategorySell.swift
//  nerugaku1
//
//  Created by Shunsuke Takagi on 9/11/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// MARK: - CategorySell
struct CategorySell: View {
    
    var categoryName: String
    var items: [AudioContent]
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: SearchCategoryItem(categoryName: categoryName, items: self.items
                )
            ) {
                Image("Airplane")
                    .resizable()
                    .frame(width: 60.0, height: 60.0)
                
                Text(self.categoryName)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.leading, 10.0)
                Spacer()
            }
        }
        .frame(width: 190, height: 60)
        .background(Color(UIColor.systemGray6))
    }
}



// MARK: - CategoryObjectLinkPreview
struct CategorySell_Previews: PreviewProvider {
    static var previews: some View {
        CategorySell(categoryName: audioContentData[0].category.rawValue,
                       items: Array(audioContentData.prefix(4)))
            .previewLayout(.fixed(width: 190, height: 60))
            .environmentObject(UserData())
        
    }
}


// MARK: - FavoritedSell
struct FavoritedSell: View {
    var body: some View {
        NavigationLink(destination: FavoritedList()) {
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color(UIColor.systemGray5))
                        .frame(width: 60.0, height: 60.0)
                    Image(systemName: "heart")
                    .font(.system(size: 30.0, weight: .thin))
                    .foregroundColor(Color.red)
                
                }
                Text("お気に入り")
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.leading, 10.0)
                Spacer()
            }
            .frame(width: 190, height: 60)
            .background(Color(UIColor.systemGray6))
        }
    }
}

// MARK: - FavoritedObjectLinkPreView
struct FavoritedSell_Previews: PreviewProvider {
    static var previews: some View {
        FavoritedSell()
            .previewLayout(.fixed(width: 190, height: 60))
            .environmentObject(UserData())
    }
}

// MARK: - Future
@available(iOS 14.0, *)
struct Future: View {
    
    @EnvironmentObject private var userData: UserData
    var categories: [String: [AudioContent]] {
        Dictionary(
            grouping: audioContentData,
            by: { $0.category.rawValue }
        )
    }
    //    var items: [AudioContent]
    
    var body: some View {
            
            
        if #available(iOS 14.0, *) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) { // カラム数の指定
                FavoritedSell()
//                    .padding(.horizontal)
                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategorySell(categoryName: key, items: self.categories[key]!)
//                        .padding(.horizontal,)
                        .padding(.vertical, -1)
//
                    
                }
            }
//            .padding(.vertical, 10)
//            .padding(.horizontal)
            
            .environmentObject(UserData())
        } else {
//            iOS14以上ではなかった場合のハンドリングをやらなきゃいけない
            VStack {
                            ForEach(categories.keys.sorted(), id: \.self) { key in
                
                                    CategorySell(categoryName: key, items: self.categories[key]!)
                
                
                            }
            }
        }
        
    }
}

// MARK: - Future
struct Future_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            Future()
                .environmentObject(UserData())
        } else {
            FavoritedSell()
        }
    }
}
