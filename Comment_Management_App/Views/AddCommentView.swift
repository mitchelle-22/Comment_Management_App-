//
//  AddCommentView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct AddCommentView: View {
    @State private var newTitle: String = ""
    @State private var newCommenText: String = ""
    @StateObject var viewModel = CommentViewModel()
    @State private var postError: String?
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Title:")
                    .font(.headline)
                CustomTextField(text: $newTitle)
               .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                
                Text("Write your comment:")
                    .font(.headline)
                    .padding(.top,8)
                
                CustomTextEditor(text: $newCommenText)
                                .frame(height: 150)
                                .padding(.horizontal)
                
                Button(action: {
                    let newComment = Comment(id: 0,userId: 0,title: newTitle,body: newCommenText)
                    viewModel.postComment(comment: newComment){
                        result in switch result{
                        case.success:
                            print("Comment poosted successfully!")
                            newTitle = ""
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
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(.sec))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal,40)
                if let error = postError{
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top,8)
                }
            }
            .navigationTitle("New Post")
            .foregroundColor(Color(.tertiary))
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

struct CustomTextField : View {
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.gray.opacity(0.1)))
                        .frame(height: 36) // Adjust height
                    
                    TextField("", text: $text)
                        .padding(8)
                        .foregroundColor(Color.primary) // Set text color
                        .font(.body) // Set font
      }
    }
}
struct CustomTextEditor :View {
    @Binding var text:String
    var body: some View {
        ZStack(alignment: .topLeading) {
                   RoundedRectangle(cornerRadius: 8)
                       .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                       .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.gray.opacity(0.1)))
            
                  TextField("", text: $text)
                           .padding(8)
                           .foregroundColor(Color.primary) // Set text color
                           .font(.body)
                   
                   TextEditor(text: $text)
                       .padding(8)
                       .background(Color.clear)
               }
        .padding()
    }
}

#Preview {
    AddCommentView()
}
