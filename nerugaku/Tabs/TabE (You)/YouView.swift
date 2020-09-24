//
//  TabEView YouView.swift
//  nerugaku1
//
//  Created by Shunsuke Takagi on 2020/07/24.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct learningTime: View {
    var body: some View {
        HStack {
            //                        ここから中身
            VStack {
                HStack {
                    Image(systemName: "timer")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("総学習時間")
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Spacer()
                }
                .padding(.leading, 8.0)
                HStack {
                    Text("7")
                    Text("分")
                }
                .padding(.vertical, 0.2)

            }
            .padding(.bottom, 20.0)
            .frame(width: 120, height: 80)
            .background(Color.gray)
            .cornerRadius(5)
        }
    }
}


struct learningCount: View {
    var body: some View {
        HStack {
            //                        ここから中身
            VStack {
                HStack {
                    Image(systemName: "timer")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("総学習回数")
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Spacer()
                }
                .padding(.leading, 8.0)
                HStack {
                    Text("7")
                    Text("回")
                }
                .padding(.vertical, 0.2)

            }
            .padding(.bottom, 20.0)
            .frame(width: 120, height: 80)
            .background(Color.gray)
            .cornerRadius(5)
        }
    }
}
struct learningDay: View {
    var body: some View {
        HStack {
            //                        ここから中身
            VStack {
                HStack {
                    Image(systemName: "timer")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("連続学習日数")
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Spacer()
                }
                .padding(.leading, 8.0)
                HStack {
                    Text("7")
                    Text("分")
                }
                .padding(.vertical, 0.2)
                
                Text("自己ベスト")
                    .font(.system(size: 10))
            }
            .frame(width: 120, height: 80)
            .background(Color.gray)
            .cornerRadius(5)
        }
    }
}



struct YouView: View {
    
    @State var showingProfile = false
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    //                    縦軸は上から高い順に、dataに入っている数を使うっぽい
                    //                    この例なら、54.00が一番大きく・7.00が一番小さい
                    LineView(data: [8,23,54,32,12,37,7,23,43], legend: "睡眠記録")
                        .padding([.leading, .bottom, .trailing], 20.0)
                    
                    Group {
                        HStack{
                            PieChartView(data: [8,23,54,32], title: "学習済みカテゴリーの割合", dropShadow: false)
                            Spacer()
                            BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "今週の勉強時間", form: ChartForm.medium, dropShadow: false)
                        }
                    }
                    .padding(.top, 300.0)
                    .padding([.leading, .bottom, .trailing], 20.0)
                    
                    
                    
                    HStack {
                        Spacer()
                        learningTime()
                        Spacer()
                        learningCount()
                        Spacer()
                        learningDay()
                        Spacer()
                    } .padding([.leading, .bottom, .trailing], 10.0)
                    
                    
                }
            }
            .navigationBarTitle(Text("You"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
        }
    }
}



struct YouView_Previews: PreviewProvider {
    static var previews: some View {
        YouView()
    }
}



