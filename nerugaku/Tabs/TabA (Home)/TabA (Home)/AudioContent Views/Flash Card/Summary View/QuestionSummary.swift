//
//  QuestionSummary.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/23/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

//MARK:- Body
struct QuestionSummary: View {
    var audioContent: AudioContent
    @State var isShowSubView = false
    @State var isDictionaryShown = false
    @Binding var getChoicesNumber: Int
    
    var body: some View {
        //        Text("hoge")
        ZStack {
            if isShowSubView {
                //                単語の復讐へをクリックすると表示されるview
                QuestionRootView(audioContent: audioContent, getChoicesNumber: getChoicesNumber)
            } else {
                //                それ以外の場合の処理
                ScrollView {
                    //  文字の表示
                    SummaryText(audioContent: audioContent)
                        .padding(.vertical)
                    
                    // ボタン
                    SummaryButton(isShowSubView: $isShowSubView)
                    
                    SummaryWords(audioContent: audioContent, isDictionaryShown: $isDictionaryShown)
                    
                }
            }
        }
    }
}

