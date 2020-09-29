//
//  CategorySell.swift
//  nerugaku1
//
//  Created by Shunsuke Takagi on 9/11/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// MARK: - CategorySell
struct CategorySell: View {
    
    var categoryName: String
    var items: [AudioContent]
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: CategoryList(categoryName: categoryName, items: self.items
                )
            ) {
                Image("Airplane")
                    .resizable()
                    .frame(width: 60.0, height: 60.0)
                
                Text(self.categoryName)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.leading, 10.0)
                Spacer()
            }
        }
        .frame(width: 170, height: 60)
        .background(Color(UIColor.systemGray6))
    }
}



// MARK: - CategoryObjectLinkPreview
struct CategorySell_Previews: PreviewProvider {
    static var previews: some View {
        CategorySell(categoryName: audioContentData[0].category.rawValue,
                       items: Array(audioContentData.prefix(4)))
            .previewLayout(.sizeThatFits)
            .environmentObject(UserData())
        
    }
}

