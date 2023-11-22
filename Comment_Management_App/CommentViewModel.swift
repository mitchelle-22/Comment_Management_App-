//
//  CommentViewModel.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/21.
//

import SwiftUI

class CommentViewModel : ObservableObject{
    @Published var comments: [Comment] = []
    @Published var isLoading : Bool = false
    @Published var comment : Comment?
 
    func fetchComments(){
        isLoading = true
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
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
                    self.isLoading = false
                }
            }catch{
                print("Error decoding comments:\(error)")
                DispatchQueue.main.async{
                    self.isLoading = false
                }
                
            }
        }.resume()
    }
    
    let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts/")!
    
    func getCommentDetails(postId : Int)
    {
        let requestURL = URL(string: "\(apiURL)/\(postId)")!
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
                  if let error = error {
                      print("Error fetching data: \(error)")
                      return
                  }
                  
                  guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                        let data = data else {
                      print("Invalid response")
                      return
                  }
                  
                  do {
                      let decodedData = try JSONDecoder().decode(Comment.self, from: data)
                      DispatchQueue.main.async {
                          self.comment = decodedData
                      }
                  } catch {
                      print("Error decoding data: \(error)")
                  }
              }.resume()
    }
  
       
    
    
    
    
    
    
    
    func addCommentToTop(comment: Comment) {
        comments.insert(comment, at: 0) // Insert the new comment at the beginning of the array
    }
    
    func postComment(comment: Comment, completion: @escaping (Result<[Comment], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(comment)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                
                // Fetch comments again after posting to get the updated list
                self.fetchComments()
                self.addCommentToTop(comment: comment)
                
                completion(.success(self.comments))
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateComment(_ comment: Comment,completion: @escaping(Result<Void, Error>)->Void){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments/\(comment.id)")else{
            completion(.failure(NSError(domain:"Invalid URL",code:0,userInfo: nil)))
            return
            
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let jsonData = try JSONEncoder().encode(comment)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request){
                data,response,error in
                if let error = error{
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }.resume()
        }catch{
            completion(.failure(error))
        }
    }
    
    func deleteComment(_ comment: Comment,completion:@escaping(Result<Void,Error>)->Void){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments/\(comment.id)")else{
            completion(.failure(NSError(domain: "Invalid", code: 0,userInfo: nil)))
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
        
        
        URLSession.shared.dataTask(with: request){
            data,response,error in if let error = error{
                completion(.failure(error))
                return
            }
            completion(.success(()))
                                
        }.resume()
    }
}
