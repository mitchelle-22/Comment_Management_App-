//
//  NewPostView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject var viewModel = CommentViewModel()
    let postId : Int
    let comment : Comment
    var body: some View {
        VStack{
            Text(comment.title)
               
        }
        
        
    }
}

#Preview {
    PostDetailView()
}
