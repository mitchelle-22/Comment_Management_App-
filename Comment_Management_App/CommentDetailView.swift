//
//  CommentDetailView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/21.
//

import SwiftUI

struct CommentDetailView: View {
    
    @StateObject var viewModel = CommentViewModel()
    let comment : Comment
    
    @State private var isEditing = false
    @State private var editCommentText = ""
    
    var body: some View {
        VStack{
            if isEditing{
                TextEditor(text: $editCommentText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Button("Save"){
                    //                updateComment()
                }
                .padding()
            }else{
                Text(comment.body)
                    .padding()
            }
            HStack{
                if !isEditing{
                    Button("Edit"){
                        isEditing.toggle()
                        editCommentText = comment.body
                    }
                    .padding()
                }
                Button("Delete")
                {
                    //                    deleteComment()
                }
                .foregroundColor(.red)
                .padding()
            }
        }
        .navigationTitle("Comment")
        .onAppear{
            editCommentText = comment.body
        }
    }
}

#Preview {
    CommentDetailView(comment: Comment(id: 1, name: "John", email: "john@example.com", body: "This is a comment"))
}
