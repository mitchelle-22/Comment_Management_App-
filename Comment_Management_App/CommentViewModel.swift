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
    
    func postComment(comment: Comment,completion: @escaping(Error?)->Void)
    {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments")else{
            completion(NSError(domain: "Invalid URL", code: 0,userInfo: nil))
            return
            
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let jsonData = try JSONEncoder().encode(comment)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request){
                data,response,error in
                if let error = error{
                    completion(error)
                    return
                }
                completion(nil)
            }.resume()
        }catch{
            completion(error)
        }
    }
}
