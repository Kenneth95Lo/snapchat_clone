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
    
    @State private var shouldDisplayError = false
    @State private var errorMessage = ""
    
    @State private var isUploading = false
    
    var shouldDisableButton: Bool {
        return isUploading
    }
    
    private func initCallbacks(){
        uploadViewModel.uploadCallback = { error in
            guard error == nil else {
                //show alert
                errorMessage = error?.localizedDescription ?? "Error uploading image..."
                shouldDisplayError = true
                return
            }
            print("image uploaded jor")
            isUploading = false
            //else success, can go to feedview
        }
    }
    
    func uploadImage(){
        
        guard let _ = selectedItem else {
            print("empty woh...")
            return
        }
        isUploading = true
        uploadViewModel.uploadImage(with: selectedImageData)
    }
    
    var body: some View {
        GeometryReader{ geometry in
            if isUploading {
                ProgressView {
                    "Loading".makeText()
                }
            }
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
                .disabled(shouldDisableButton)
                Button("Upload") {
                    uploadImage()
                }
                .disabled(selectedItem == nil || shouldDisableButton)
                .alert(isPresented: $shouldDisplayError) {
                    Alert(title: "Error".makeText(), message: errorMessage.makeText())
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                initCallbacks()
            }
            
        }
    }
}

#Preview {
    UploadView()
}
