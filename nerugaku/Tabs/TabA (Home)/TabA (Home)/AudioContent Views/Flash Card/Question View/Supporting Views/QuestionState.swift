//
//  QuestionState.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 10/6/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI
struct QuestionState: View {
    var audioContent: AudioContent
    //    現在のスライダーの場所
    @Binding var sliderValue: Double
    //    最初のMac Valueを10と仮定する
    @Binding var maxValue: Double
    //    遷移前かどうかを判断する
    @Binding var isShowSubView: Bool
    //    現在表示している問題の番号
    @Binding var currentQuestionIndex:Int
    var body: some View {
        HStack {
            Text(String(currentQuestionIndex))
            Text("/")
            Text(String(audioContent.allpharase))
        }
        .padding(.bottom, 50.0)
    }
}
