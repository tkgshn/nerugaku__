//
//  Description.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 2020/07/21.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI
import UIKit

struct Description: View {
    @EnvironmentObject var userData: UserData
    var audioContent: AudioContent
    
    @State private var isAudioShown: Bool = false
    @State private var isQuestionShown: Bool = false
    
    var audioContentIndex: Int {
        userData.audioContents.firstIndex(where: { $0.id == audioContent.id })!
    }
    
    
    
    
    var body: some View {
        
        VStack {
            
            
            VStack(alignment: .leading) {
                //コンテンツの概要
                HStack {
                    Text(audioContent.description)
                        .foregroundColor(Color(UIColor.label))
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                    
                }
                HStack (alignment: .top) {
                    Text(String(audioContent.allfavorite) + "いいね・" + String(audioContent.alltime) + "分")
                        .foregroundColor(Color(UIColor.secondaryLabel))
//                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.top)
            }.padding()
            
            
            //            ここから操作系のやつ、横並び
            HStack(alignment: .center) {
                //                    Image(systemName: "heart")
                //                        .padding(.trailing, 10.0)
                //                        .font(.system(size: 35.0, weight: .thin))
                
                //                    ここからいいね形の処理
                Button(action: {
                    self.userData.audioContents[self.audioContentIndex]
                        .isFavorite.toggle()
                }) {
                    if self.userData.audioContents[self.audioContentIndex].isFavorite {
                        
                        Image(systemName: "heart.fill")
                            .padding(.trailing, 10.0)
                            .font(.system(size: 35.0, weight: .thin))
                            .foregroundColor(Color.accentColor)
                    } else {
                        Image(systemName: "heart")
                            .padding(.trailing, 10.0)
                            .font(.system(size: 35.0, weight: .thin))
                            .foregroundColor(Color.accentColor)
                    }
                }
                //                    ここまで
                
                
                
                //                    ここから他のアクション
                Image(systemName: "arrow.down.circle")
                    .padding(.horizontal, 3.0)
                    .font(.system(size: 35.0, weight: .thin))
                Image(systemName: "ellipsis")
                    .padding(.horizontal, 13.0)
                    .font(.system(size: 35.0, weight: .thin))
                Spacer()
                
                
                
                //TextやImageをタップした時にトリガーする方法
                Image(systemName: "play.circle.fill")
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 10.0)
                    .frame(width: nil)
                    .font(.system(size: 55.0, weight: .thin))
                    .foregroundColor(Color.accentColor)
                    .onTapGesture {
                        self.isAudioShown = true
                    }
                    .sheet(isPresented: self.$isAudioShown) {
                        //モーダル遷移した後に表示するビュー
                        AudioPlayerView()
                    }
                
                
            }
            .padding([.leading, .trailing])
        
        
        //            問題を解くボタンを追加
        Button(action: {
        }, label: {
            
            //                    問題数を取得
            if #available(iOS 14.0, *) {
                Text("問題を解く\n" + String(audioContent.allpharase) + "単語")
                    .font(.title3)
                    
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 120.0)
                    .frame(height: 55.0)
                    .background(Color(UIColor.systemGray3))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .onTapGesture {
                        self.isQuestionShown = true
                    }
                    .sheet(isPresented: self.$isQuestionShown) {
                        //モーダル遷移した後に表示するビュー
                        QuestionRootView(audioContent: audioContent)
                    }
            } else {
                // Fallback on earlier versions
            }
        })
        .padding(.top)
        
    }
}
}


struct Description_Previews: PreviewProvider {
    static var previews: some View {
        
        //        0番地点の情報を表示
        let userData = UserData()
        return Description(audioContent: userData.audioContents[0])
            .environmentObject(UserData())
            .previewLayout(.sizeThatFits)
        
    }
}



