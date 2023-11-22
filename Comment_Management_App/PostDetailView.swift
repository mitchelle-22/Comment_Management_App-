//
//  NewPostView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject var viewModel = CommentViewModel()
    @State private var editiedTitle = ""
    @State private var editedBody = ""
   
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
                        
                        HStack {
                            // Edit Button
                            Button(action: {
                                // Handle edit functionality
                                // For now, let's print a message
                                print("Edit button tapped")
                            }) {
                                Text("Edit")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            .padding()
                            
                            // Delete Button
                            Button(action: {
                                // Handle delete functionality
//                                viewModel.deleteComment(commentId: comment.id)
                            }) {
                                Text("Delete")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                            .padding()
                        }
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
