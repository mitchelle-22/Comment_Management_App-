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

    var body: some View {
        VStack{
            Text("Enter your comment:")
                .font(.headline)
                .padding()
            
            TextEditor(text: $newCommenText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Button(action: {
                let newComment = Comment(id: 0,name:"Michelle",email:"mich@gmail.com",body: newCommenText)
                viewModel.postComment(comment: newComment){
                    error in if let error = error{
                        print("Error post comment:\(error.localizedDescription)")
                    }else{
                        print("Comment posted successfully!")
                        newCommenText = ""
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
        }
        .navigationTitle("New Post")
        .padding()
        .onAppear{
            viewModel.fetchComments()
        }
    }
}

#Preview {
    AddCommentView()
}
