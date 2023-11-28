//
//  SplashScreenView.swift
//  Comment_Management_App
//
//  Created by MIch on 2023/11/28.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("Logo")
                    .resizable()
                   .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                            isActive = true
                        }
                    }
                    .fullScreenCover(isPresented: $isActive) {
                        CommentManagementTabView()
                    }
            }
        }
            .ignoresSafeArea()
        }
    }
    


#Preview {
    SplashScreenView()
}
