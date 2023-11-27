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
            CommentGridView()
                   .tabItem {
                       Image(systemName: "house.fill")
                       Text("Home")
                   }
               AddCommentView()
                   .tabItem {
                       Image(systemName: "plus.message.fill")
                       Text("New Post")
                   }
               ProfileView()
               .tabItem{
                       Image(systemName: "person.crop.circle.fill")
                       Text("Profile")
                   }
               

                   }
        .accentColor(Color("mainColor"))
           
           
    }
}

#Preview {
    CommentManagementTabView()
}
