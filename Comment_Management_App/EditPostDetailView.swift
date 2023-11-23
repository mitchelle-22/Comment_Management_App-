//
//  EditPostDetailView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/23.
//

import SwiftUI

struct EditPostDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var editedTitle : String
    @State var editedBody : String
    
    let comment: Comment
    
    @StateObject var viewModel = CommentViewModel()
    
    init(comment: Comment,viewModel: CommentViewModel)
    {
        self.comment = comment
        self._editedTitle = State(initialValue: comment.title)
        self._editedBody = State(initialValue: comment.body)
    }
    
    var body: some View {
        VStack{
          TextField("Title",text: $editedTitle)
                .padding()
            TextField("Body",text: $editedBody)
                .padding()
            
            Button("Save")
            {
                viewModel.updateComment(id: comment.id, newTitle: editedTitle, newBody: editedBody)
                
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    
    let comment = Comment(id: 1, userId: 1, title: "Sample Title", body: "Sample Body")
    let viewModel = CommentViewModel()
    return EditPostDetailView(comment: comment,viewModel: viewModel)
}
