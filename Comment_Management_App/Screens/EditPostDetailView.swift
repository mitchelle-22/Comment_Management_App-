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
        VStack(spacing:12) {
                  TextField("Title", text: $editedTitle)
                   .font(.title2)
                   .fontWeight(.bold)
                   .foregroundColor(Color(.tertiary))
                   .multilineTextAlignment(.leading)
                   .lineLimit(nil)
                   .padding()

                  TextField("Body", text: $editedBody)
                   .font(.body)
                   .fontWeight(.regular)
                   .foregroundColor(Color(.tertiary))
                   .multilineTextAlignment(.leading)
                   .lineLimit(nil)
                   .frame(height: 150)
                   .padding(.horizontal)


                  Button("Save") {
                      viewModel.updateComment(id: comment.id, newTitle: editedTitle, newBody: editedBody)

                      // Dismiss the view after saving
                      presentationMode.wrappedValue.dismiss()

                      // Show the alert after successfully updating
                      showAlert = true
                      alertMessage = "Updated Successfully!"
                  }
                  .foregroundColor(.white)
                  .padding()
                  .frame(maxWidth: .infinity)
                  .background(Color(.sec))
                  .cornerRadius(8)
                  .padding()
              }
              .padding()
              .alert(isPresented: $showAlert) {
                  Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
              }
          }
}

#Preview {
    
    let comment = Comment(id: 1, userId: 1, title: "Sample Title", body: "Sample Body")
    let viewModel = CommentViewModel()
    return EditPostDetailView(comment: comment,viewModel: viewModel)
}
