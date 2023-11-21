//
//  CommentViewModel.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/21.
//

import SwiftUI

class CommentViewModel : ObservableObject{
    @Published var comments: [Comment] = []
    
    func fetchComments(){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments")
        else{
            return
        }
        URLSession.shared.dataTask(with: url)
        {
            data,response,error in 
            guard let data = data else {return}
            
            do{
                let fetchedComments = try JSONDecoder().decode([Comment].self, from: data)
                DispatchQueue.main.async{
                    self.comments = fetchedComments
                }
            }catch{
                print("Error decoding comments:\(error)")
            }
        }.resume()
    }
}
