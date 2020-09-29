//
//  FuturedCollectiondCollection.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/25/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// MARK: - FuturedCollection
@available(iOS 14.0, *)
struct FuturedCollection: View {
    
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

// MARK: - FuturedCollection
struct FuturedCollection_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            FuturedCollection()
                .environmentObject(UserData())
                .previewLayout(.sizeThatFits)
        } else {
            FavoritedSell()
                .previewLayout(.sizeThatFits)
        }
    }
}

