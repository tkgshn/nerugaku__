//
//  Recomend.
//CategoryRow
//swift
//  nerugaku1
//
//  Created by Shunsuke Takagi on 2020/07/23.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [AudioContent]
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        //        縦方向
        VStack(alignment: .leading) {
//            テキスト
            HStack {
                if #available(iOS 14.0, *) {
                    Text(self.categoryName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                } else {
                    // Fallback on earlier versions
                }
                Spacer()
                NavigationLink(
                    destination: CategoryList(categoryName: categoryName, items: self.items
                    )
                ) {
                    Text("すべて見る")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.trailing, 15)
                        .padding(.top, 5)
                }
            }
            //            横向きにスクロールを追加
            ScrollView(.horizontal, showsIndicators: false) {
                //                横方向
                HStack(alignment: .top, spacing: 0) {
                    //                    アイテムがあるかぎり繰り返す
                    ForEach(self.items) { audioContent in
                        //                        それをクリックできるようにする
                        NavigationLink(
                            destination: AudioContentDetail(
                                audioContent: audioContent
                            )
                        ) {
                            //                            下で定義したものを使用
                            CategoryItem(audioContent: audioContent)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}


//ここでアイテム自体を定義する
struct CategoryItem: View {
    var audioContent: AudioContent
    var body: some View {
        //        縦方向
        VStack(alignment: .leading) {
            //            画像を追加
            audioContent.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            //            タイトルを追加
            Text(audioContent.name)
                .foregroundColor(.primary)
                .font(.subheadline)
        }
        .padding(.leading, 15)
    }
}




struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(categoryName: audioContentData[0].category.rawValue,
                 items: Array(audioContentData.prefix(4))
        )
        .environmentObject(UserData())
        
    }
}

