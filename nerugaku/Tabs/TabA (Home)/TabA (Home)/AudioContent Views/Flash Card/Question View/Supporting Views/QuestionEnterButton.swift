//
//  QuestionEnterButton.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 10/6/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct QuestionEnterButton: View {
    var audioContent: AudioContent
    //    現在のスライダーの場所
    @Binding var sliderValue: Double
    //    最初のMac Valueを10と仮定する
    @Binding var maxValue: Double
    //    遷移前かどうかを判断する
    @Binding var isShowSubView: Bool
    //    現在表示している問題の番号
    @Binding var currentQuestionIndex:Int
    @ObservedObject var viewModel = SingleSelectableBoxViewModel()
    var body: some View {
        VStack{
            //                もし今表示している問題が最後の問題であれば
            if currentQuestionIndex == audioContent.allpharase {
                Button(action: {
                    withAnimation() {
                        self.isShowSubView.toggle() // このViewが持っているStateを切り変える
                    }
                }) {
                    Text("問題を終了する")
                }
            } else  {
                //                    まだ問題があれば
                Button(action: {
                    sliderValue += 10 / self.maxValue
                    currentQuestionIndex += 1 // 表示する問題を次のものに
                    viewModel.selectedBox = .unknown // ページを更新するたびに、選択しているものをリセットする
                }) {
                    Text("次の問題に進む")
                }
                
            }
            
        }
        .padding(.bottom, 40.0)
    }
}
