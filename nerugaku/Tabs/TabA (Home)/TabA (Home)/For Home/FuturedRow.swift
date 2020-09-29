//
//  FuturedRow.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/25/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct FuturedRow: View {
    
    var categoryName: String
    var items: [AudioContent]
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading) {
            //            テキスト
            HStack {
                if #available(iOS 14.0, *) {
                    Text(self.categoryName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading, -2)
                        .padding(.top, 5)
                        .padding(.bottom, -2)
                } else {
                    // Fallback on earlier versions
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
                            FuturedItem(audioContent: audioContent)
                        }
                    }
                }
            }
            .frame(height: 185)
        }.padding(.bottom)
    }
}

struct FuturedRow_Previews: PreviewProvider {
    static var previews: some View {
        FuturedRow(categoryName: audioContentData[0].category.rawValue,
                   items: Array(audioContentData.prefix(4)))
            .environmentObject(UserData())
    }
}




//ここでアイテム自体を定義する
struct FuturedItem: View {
    var audioContent: AudioContent
    var body: some View {
        //        縦方向
        VStack(alignment: .leading) {
            //            画像を追加
            audioContent.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 200, height: 150)
                .cornerRadius(5)
            //            タイトルを追加
            Text(audioContent.name)
                .foregroundColor(.primary)
                .font(.subheadline)
        }
        .padding(.trailing, 15)
    }
}




struct ListView: View {
    var body: some View {
        NavigationView {
            List {
                
                ForEach(1..<10) { _ in
                    FuturedRow(categoryName: audioContentData[0].category.rawValue,
                               items: Array(audioContentData.prefix(4)))
                        .environmentObject(UserData())
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(UserData())
            .previewLayout(.sizeThatFits)
    }
}
