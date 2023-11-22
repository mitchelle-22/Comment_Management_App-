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
 
    var body: some View {
        VStack {
                    if let comment = viewModel.comment {
                        Text(comment.title)
                            .fontWeight(.bold)
                            .padding()
                        Text(comment.body)
                            .fontWeight(.regular)
                            .padding()
                    } else {
                        Text("Loading...")
                            .onAppear {
                                viewModel.getCommentDetails(postId: postId)
                            }
                    }
                }
                .onAppear {
                    viewModel.getCommentDetails(postId: postId)
                }
            }
        
        
    }


#Preview {
    PostDetailView(postId: 1)
}
