//
//  CommentsModel.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct Comment:Codable,Identifiable{
    
    
    let id : Int
    let name : String
    let email : String
    let body : String
  
}

