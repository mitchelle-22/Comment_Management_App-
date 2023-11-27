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
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                        ForEach(viewModel.comments) { comment in
                            NavigationLink(
                                destination: PostDetailView(viewModel: CommentViewModel(), id: comment.id),
                                label: {
                                    CommentView(comment: comment)
                                        .padding(12)
                                        .background(Color.brown.opacity(0.1))
                                        .cornerRadius(8)
                                        .fixedSize(horizontal: false, vertical: true) // Keep the width flexible while constraining the height
                                        .frame(maxWidth: .infinity, alignment: .leading) // Align to leading edge
                                        .frame(maxWidth: .infinity, alignment: .trailing) // Align to trailing edge
                                        .frame(minWidth: 0, maxWidth: .infinity) // Set both min and max width to infinity
                                }
                            )
                        }
                    }
                    .padding(20) // Add padding around the whole LazyVGrid


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
                .foregroundColor(Color(.tertiary))
            
            Text(comment.body)
                .font(.subheadline)
                .foregroundColor(Color(.sec))
                .lineLimit(2)
        }
    }
}
