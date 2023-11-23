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
    
    //Alert state variables
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                
                //Dismiss the view after saving
                presentationMode.wrappedValue.dismiss()
                
                // Show the alert after successfully update
                showAlert = true
                alertMessage = "Updated Successfully!"
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"),message: Text(alertMessage),dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    
    let comment = Comment(id: 1, userId: 1, title: "Sample Title", body: "Sample Body")
    let viewModel = CommentViewModel()
    return EditPostDetailView(comment: comment,viewModel: viewModel)
}
