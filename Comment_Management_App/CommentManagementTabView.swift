//
//  ContentView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct CommentManagementTabView: View {
    var body: some View {
        TabView{
            CommentManagementListView()
                   .tabItem {
                       Image(systemName: "house.fill")
                       Text("Home")
                   }
               AddCommentView()
                   .tabItem {
                       Image(systemName: "person.crop.circle.fill")
                       Text("Profile")
                   }
               ProfileView()
               .tabItem{
                       Image(systemName: "bag.circle.fill")
                       Text("Order")
                   }
               

                   }
        .accentColor(Color("mainColor"))
           
           
    }
}

#Preview {
    CommentManagementTabView()
}
