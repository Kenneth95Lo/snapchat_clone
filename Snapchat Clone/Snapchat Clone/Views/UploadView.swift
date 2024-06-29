//
//  UploadView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI

struct UploadView: View {
    
    func uploadImage(){
        
    }
    
    var body: some View {
        VStack{
            Image(systemName: "")
                .frame(minWidth: 100, minHeight: 100)
            Button("Upload") {
                uploadImage()
            }
            .background()
        }
    }
}

#Preview {
    UploadView()
}
