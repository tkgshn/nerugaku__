//
//  QuestionsView.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/19/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
import SwiftUI


// MARK: - QuestionRootView
struct QuestionRootView: View {
    var audioContent: AudioContent
    //    現在のスライダーの場所
    @State private var sliderValue: Double = 0
    //    最初のMac Valueを10と仮定する
    @State var maxValue: Double = 10
    //    遷移前かどうかを判断する
    @State var isShowSubViw = false
    //    現在表示している問題の番号
    @State var currentQuestionIndex:Int = 1
    
    @ObservedObject var viewModel = SingleSelectableBoxViewModel()
    
    var body: some View {
        ZStack {
            // NOTE: 画面をレンダリングするかで画面遷移を発生する
            if isShowSubViw {
                QuestionSubView()
            } else {
                VStack {
                    
                    ProgressBar(value: $sliderValue.wrappedValue + 1,
                                maxValue: Double(audioContent.allpharase),
                                foregroundColor: .green)
                        .frame(height: 10)
                        .padding(30)
                    Spacer()
                    HStack {
                        //                現在の位置を整数で表示
                        Text(String(currentQuestionIndex))
                        Text("/")
                        Text(String(audioContent.allpharase))
                    }
                    .padding(.bottom, 50.0)
                    Spacer()
                    VStack(alignment: .center) {
                        Text(self.audioContent.phrases[String(currentQuestionIndex)]!.english)
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical)
//                    Text("Selected box is \(viewModel.selectedBox.rawValue)")
//                        .padding(.top)
                    
                    Spacer()
                    
                    SingleSelectableBoxView(selectedBox: $viewModel.selectedBox)
                    Spacer()
                    
                    VStack{
                        //                もし今表示している問題が最後の問題であれば
                        if currentQuestionIndex == audioContent.allpharase {
                            Button(action: {
                                withAnimation() {
                                    self.isShowSubViw.toggle()
                                }
                            }) {
                                Text("問題を終了する")
                            }
                        } else  {
                            //                    まだ問題があれば
                            Button(action: {
                                sliderValue += 10 / self.maxValue
                                currentQuestionIndex += 1
                            }) {
                                Text("次の問題に進む")
                            }
                            
                        }
                        
                    }
                    .padding(.bottom, 40.0)
                }
            }
        }
        .transition(.identity)
    }
    
    
}


// MARK: - QuestionSubView
//ここで遷移先
//サマリーを表示するために引っ張ってくる
struct QuestionSubView: View {
    var body: some View {
        GeometryReader { geometory in
            ZStack {
                Spacer()
                QuestionSummary(audioContent: audioContentData[0])
            }
            .animation(.easeInOut(duration: 0.42))
        }
        .transition(.move(edge: .trailing))
    }
}


// MARK: - Preview
struct QuestionRootView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionRootView(audioContent: audioContentData[0])
        
    }
}
