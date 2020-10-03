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
    @Binding var getChoicesNumber: Int
    
    var body: some View {
        ZStack {
            // NOTE: 画面をレンダリングするかで画面遷移を発生する
            if isShowSubViw {
                QuestionSubView()
            } else {
                VStack {
                    //                    上部の進捗を表示するバー
                    ProgressBar(value: $sliderValue.wrappedValue + 1,
                                maxValue: Double(audioContent.allpharase),
                                foregroundColor: .green)
                        .frame(height: 10)
                        .padding(30)
                    
                    Spacer()
                    //                    進捗を数値でも表示
                    HStack {                        Text(String(currentQuestionIndex))
                        Text("/")
                        Text(String(audioContent.allpharase))
                    }
                    .padding(.bottom, 50.0)
                    
                    Spacer()
                    //                    問題文を表示
                    VStack(alignment: .center) {
                        Text(self.audioContent.phrases[String(currentQuestionIndex)]!.english)
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical)
                    //                    現在選択しているものを表示
                    Text("Selected box is \(viewModel.selectedBox.rawValue)")
                        .padding(.top)
                    
                    Spacer()
                    //                    選択肢のView
                    SingleSelectableBoxView(selectedBox: $viewModel.selectedBox, currentQuestionIndex: $currentQuestionIndex, getChoicesNumber: self.$getChoicesNumber)
                    
                    Spacer()
                    //                    「次に進む」のボタンの要素
                    VStack{
                        //                もし今表示している問題が最後の問題であれば
                        if currentQuestionIndex == audioContent.allpharase {
                            Button(action: {
                                withAnimation() {
                                    self.isShowSubViw.toggle() // このViewが持っているStateを切り変える
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
//struct QuestionRootView_Previews: PreviewProvider {
//    @State var getChoicesNumber: Int = 0
//    static var previews: some View {
//        QuestionRootView(audioContent: audioContentData[0], getChoicesNumber: self.$getChoicesNumber)
//    }
//}w

struct QuestionRootView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionRootViewPreviews()
    }
    struct QuestionRootViewPreviews : View{
        @State var getChoicesNumber: Int = 0
        var body: some View{
//            ここで辞書にString型で引数を設定してあげる
            QuestionRootView(audioContent: audioContentData[0], getChoicesNumber: self.$getChoicesNumber)
        }
    }
}
