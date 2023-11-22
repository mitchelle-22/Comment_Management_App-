//
//  AddCommentView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct AddCommentView: View {
    @State private var newCommenText: String = ""
    @StateObject var viewModel = CommentViewModel()
//    @State private var isShowingUpdatedComment = false
    @State private var postError: String?
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Enter your comment:")
                    .font(.headline)
                    .padding()
                
                TextEditor(text: $newCommenText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Button(action: {
                    let newComment = Comment(id: 0,userId: 0,title:"Michelle",body: newCommenText)
                    viewModel.postComment(comment: newComment){
                        result in switch result{
                        case.success:
                            print("Comment poosted successfully!")
                            newCommenText = ""
                            postError = nil
//                            isShowingUpdatedComment.toggle()
                            showAlert = true
                        case.failure(let error):
                            print("Error posting comment:\(error.localizedDescription)")
                            postError = "Failed to post comment.Please try again."
                        }
                    }
                    
                }){
                    Text("Post")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
//                if isShowingUpdatedComment {
//                    // Display updated comments after posting
//                    Text("Fetching updated comments...")
//                        .foregroundColor(.gray)
//                        .padding(.top, 8)
//                        .onAppear {
//                            viewModel.fetchComments() // Fetch updated comments
//                        }
//                }
                if let error = postError{
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top,8)
                }
            }
            .navigationTitle("New Post")
            .padding()
            .onAppear{
                viewModel.fetchComments()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text("Comment posted successfully!"), dismissButton: .default(Text("OK")))
                
            }
        }
    }
}

#Preview {
    AddCommentView()
}
