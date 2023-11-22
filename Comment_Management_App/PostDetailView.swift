//
//  NewPostView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject var viewModel = CommentViewModel()
    let id : Int
 
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
                                viewModel.getCommentDetails(id: id)
                            }
                    }
                }
                .onAppear {
                    viewModel.getCommentDetails(id: id)
                }
            }
        
        
    }


#Preview {
    PostDetailView(id: 1)
}
