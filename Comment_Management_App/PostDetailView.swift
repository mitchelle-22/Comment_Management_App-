//
//  NewPostView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject var viewModel = CommentViewModel()
    @State private var isEditing = false
    @State private var comments: [Comment] = []
   
   
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
                               isEditing = true
                            }) {
                                Text("Edit")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            .sheet(isPresented: $isEditing)
                            {
                                EditPostDetailView(comment: comment, viewModel: viewModel)
                            }
                            .padding()
                            
                            // Delete Button
                            Button(action: {
                                // Handle delete functionality
//                                viewModel.deleteComment(commentId: comment.id)
                                if let index = comments.firstIndex(where: {$0.id == comment.id}) {
                                    comments.remove(at: index)
                                }
                                deleteComment(id: comment.id){
                                    result in switch result {
                                    case .success:
                                        // Handle success
                                        print("Post deleted successfully.")
                                    case .failure(let error):
                                        // Handle failure
                                        print("Failed to delete post: \(error.localizedDescription)")
                                    }
                                }
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
