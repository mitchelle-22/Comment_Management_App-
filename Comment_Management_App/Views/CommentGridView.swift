//
//  CommentGridView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/21.
//

import SwiftUI

struct CommentGridView: View {
    
    @StateObject var viewModel = CommentViewModel()
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                if viewModel.isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }else{
                    LazyVGrid(columns: [GridItem(.flexible())],spacing: 10){
                        ForEach(viewModel.comments) { comment in
                            NavigationLink(
                                destination: PostDetailView(id: comment.id),
                                label: {
                                    CommentView(comment: comment)
                                        .padding(12)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Comments")
            .onAppear{
                viewModel.fetchComments()
            }
        }
    }
}

#Preview {
    CommentGridView()
}

struct CommentView: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
         
            Text(comment.title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(comment.body)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
    }
}