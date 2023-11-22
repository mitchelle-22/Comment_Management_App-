//
//  CommentsModel.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct Comment:Codable,Identifiable{
    
//    let postId : Int
    let id : Int
//    let userId: Int
    let name : String
    let email : String
    let body : String
  
}

