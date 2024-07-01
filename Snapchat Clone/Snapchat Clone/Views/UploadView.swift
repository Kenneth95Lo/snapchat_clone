//
//  UploadView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI
import PhotosUI

struct ImageData {
    let data: Data
}

struct UploadView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data = UIImage(named: "SelectImagePlaceholder")!.pngData()!
    
    @StateObject private var uploadViewModel = UploadViewModel()
    
    private func initCallbacks(){
        uploadViewModel.uploadCallback = { error in
            guard error == nil else {
                //show alert
                return
            }
            //else success, can go to feedview
        }
    }
    
    func uploadImage(){
        guard let _ = selectedItem else {
            print("empty woh...")
            return
        }
        uploadViewModel.uploadImage(with: selectedImageData)
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Image(uiImage: UIImage(data: selectedImageData)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.3)
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
                    "Select a photo".makeText()
                }
                .padding()
                .onChange(of: selectedItem) { newItem in
                    
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self){
                            selectedImageData = data
                        }
                    }
                }
                Button("Upload") {
                    uploadImage()
                }
                .disabled(selectedItem == nil)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    UploadView()
}
