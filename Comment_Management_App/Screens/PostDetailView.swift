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
    @Environment(\.presentationMode) var presenationMode
    
    @State private var isDeleted = false
    
    
    let id : Int
    @State private var redirectToCommentGridView = false
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationView {
              VStack {
                  if !isDeleted {
                      if let comment = viewModel.comment {
                          VStack(spacing: 12) {
                              Text(comment.title)
                                  .font(.title2)
                                  .fontWeight(.bold)
                                  .foregroundColor(Color(.tertiary))
                                  .padding()

                              Text(comment.body)
                                  .font(.body)
                                  .fontWeight(.regular)
                                  .padding()

                              HStack(spacing: 20) {
                                  // Edit Button
                                  Button(action: {
                                      isEditing = true
                                  }) {
                                      Text("Edit")
                                          .foregroundColor(.white)
                                          .padding()
                                          .frame(maxWidth: .infinity)
                                          .background(Color(.sec))
                                          .cornerRadius(8)
                                  }
                                  .sheet(isPresented: $isEditing) {
                                      EditPostDetailView(comment: comment, viewModel: viewModel)
                                  }
                              

                                  // Delete Button
                                  Button(action: {
                                      deleteComment(id: comment.id) { result in
                                          switch result {
                                          case .success:
                                              isDeleted = true
                                              showAlert = true
                                              redirectToCommentGridView = true
                                              // Handle success
                                              print("Post deleted successfully.")
                                          case .failure(let error):
                                              // Handle failure
                                              print("Failed to delete post: \(error.localizedDescription)")
                                          }
                                      }
                                  }) {
                                      Text("Delete")
                                          .foregroundColor(.white)
                                          .padding()
                                          .frame(maxWidth: .infinity)
                                          .background(Color(.tertiary))
                                          .cornerRadius(8)
                                  }
                              }
                              .padding(.horizontal, 20)
                          }
                      } else {
                          Text("Loading...")
                              .onAppear {
                                  viewModel.getCommentDetails(id: id)
                              }
                      }
                  }
//                  Spacer() // Pushes content to the top
              }
              .navigationBarTitle("Post Detail")
              .alert(isPresented: $showAlert) {
                  Alert(
                      title: Text("Deleted"),
                      message: Text("Post deleted successfully"),
                      dismissButton: .default(Text("OK"))
                  )
              }
              .background(
                  NavigationLink(destination: CommentGridView(), isActive: $redirectToCommentGridView) {
                      EmptyView()
                  }
                  .isDetailLink(false)
                  .opacity(0)
              )
          }
            .alert(isPresented: $showAlert) {
                
                Alert(title: Text("Deleted"), message: Text("Post deleted successfully"), dismissButton: .default(Text("OK")))
                            
            }
        }
        }
        
    

#Preview {
    PostDetailView(viewModel:CommentViewModel(),id: 1)
}
