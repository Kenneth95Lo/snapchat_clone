//
//  UploadViewModel.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 1/7/24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

let SNAP_COLLECTION = "Snaps"

class UploadViewModel: ObservableObject {
    
    let FIELD_IMAGE_URL_ARRAY = "imageUrlArray"
    let FIELD_SNAP_OWNER = "snapOwner"
    let MEDIA_CHILD = "media"
    let firestore = Firestore.firestore()
    
    typealias ErrorCompletion = (Error?) -> Void
    @Published var uploadCallback: ErrorCompletion?
    
    func uploadImage(with selectedImageData: Data){
        
        //Storing actual image files to Firebase storage
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child(MEDIA_CHILD)
        
        //Should do data compression
        
        let uuid = UUID().uuidString
        let imageRef = mediaFolder.child("\(uuid).jpg")
        
        imageRef.putData(selectedImageData) { [weak self] metadata, error in
            guard let self = self else { return }
            guard error == nil else {
                self.uploadCallback?(error)
                return
            }
            self.getDownloadUrl(from: imageRef)
        }
    }
    
    private func getDownloadUrl(from storageRef: StorageReference) {
        storageRef.downloadURL { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let url):
                self.saveToFirestore(urlStr: url.absoluteString)
                
            case .failure(let error):
                self.uploadCallback?(error)
            }
        }
    }
    
    private func saveToFirestore(urlStr: String){
        
        firestore.getSnapCollection().whereField(FIELD_SNAP_OWNER, isEqualTo: Auth.auth().currentUser!.uid).getDocuments { [weak self] snapshots, error in
            
            guard let self = self else { return }
            
            guard error == nil else {
                self.uploadCallback?(error)
                return
            }
            
            guard let snapshots = snapshots,
               !snapshots.isEmpty else {
                createNewEntry()
                return
            }
            
            for document in snapshots.documents {
                
                let docId = document.documentID
                if var imageUrlArr = document.get(FIELD_IMAGE_URL_ARRAY) as? [String] {
                    imageUrlArr.append(urlStr)
                    
                    let dict = [FIELD_IMAGE_URL_ARRAY: imageUrlArr]
                    
                    firestore.getSnapCollection().document(docId).setData(dict, merge: true, completion: self.uploadCallback)
                }
            }
            
        }
        
        func createNewEntry(){
            //FieldValue provided by Firebase
            let snapDictionary : [String: Any] = [
                FIELD_IMAGE_URL_ARRAY: [urlStr],
                FIELD_SNAP_OWNER: Auth.auth().currentUser!.displayName ?? "",
                "timestamp": FieldValue.serverTimestamp()
            ]
            
            self.firestore.getSnapCollection().addDocument(data: snapDictionary) { [weak self] error in
                guard let self = self else { return }
                guard error == nil else {
                    self.uploadCallback?(error)
                    return
                }
                self.uploadCallback?(nil)
            }
        }
    }
    
}

extension Firestore {
    func getSnapCollection() -> CollectionReference {
        return collection(SNAP_COLLECTION)
    }
    
}
