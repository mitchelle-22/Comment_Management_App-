//
//  CommentsModel.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/20.
//

import SwiftUI

struct Comment:Codable,Identifiable{
    

    let id : Int
    let userId: Int
    let title : String
    let body : String
  
}

