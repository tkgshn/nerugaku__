//
//  HomeView.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 2020/07/15.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    //    カテゴリーを生成
    var categories: [String: [AudioContent]] {
        Dictionary(
            grouping: audioContentData,
            by: { $0.category.rawValue }
        )
    }
    //    フィルターしたFeaturedを生成
    var featured: [AudioContent] {
        audioContentData.filter { $0.isFeatured }
    }
    //    プロフィール画面を開いているかどうかのスイッチ
    @State var showingProfile = false
    @EnvironmentObject var userData: UserData
    
    //        ヘッダーに置くボタン
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
                if #available(iOS 14.0, *) {
                    FuturedCollection()
                        .padding(.vertical)
                        .padding(.horizontal, 15.0)
                    
                } else {
                }
                
                
                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                    //                            .padding(.horizontal, 5.0)
                }
                
                
                .padding(.top)
                Divider()
//                    .padding(.top)
//                    .listRowInsets(EdgeInsets())
                
                
                    
                    Section{
                                NavigationLink(destination: AudioContentList()) {
                                    HStack {
                                        Text("See All")
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }}
                
                
                //                               Listの最後にある”全て見る”を担う部分
//                                NavigationLink(destination: AllContent()
//                                                .environmentObject(UserData())) {
//                                    Text("See All")
//                                }
                
            }
            
            .navigationBarTitle(Text("Home"))
            .environmentObject(UserData())
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
        }
        
    }
    
}








struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserData())
    }
}
