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
//                       updateComment()
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
                      //deleteComment()
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
//    func updateComment() {
//        let updatedComment = Comment(id:comment.id, userId: comment.userId, title: comment.title, body: editCommentText)
//            viewModel.updateComment(updatedComment) { result in
//                switch result {
//                case .success:
//                    isEditing.toggle()
//                case .failure(let error):
//                    print("Failed to update comment: \(error.localizedDescription)")
//                }
//            }
//        }
        
//    func deleteComment() {
//        viewModel.deleteComment(comment) { result in
//            switch result {
//            case .success:
//                // Pop to the previous view after deletion
//                DispatchQueue.main.async {
//                    // Navigate back to the previous view
//                    presentationMode.wrappedValue.dismiss()
//                }
//            case .failure(let error):
//                print("Failed to delete comment: \(error.localizedDescription)")
//            }
//        }
//    }

}



#Preview {
    CommentDetailView(comment: Comment(id: 1,userId: 1, title: "Heat wave", body: "This is a comment"))
}
