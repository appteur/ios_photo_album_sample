//
//  PhotoAlbumHandler.swift
//  PhotosTest
//
//  Created by Seth on 3/19/18.
//  Copyright © 2018 Seth. All rights reserved.
//

import Foundation
import Photos

public protocol PhotoAlbumHandler: class {
    var albumName: String { get set }
    
    func save(_ photo: UIImage, completion: @escaping (PhotoAlbumHandlerError?) -> Void)
}

extension PhotoAlbumHandler {
    
    func save(_ photo: UIImage, completion: @escaping (PhotoAlbumHandlerError?) -> Void) {
        
        // Check for permission
        guard PHPhotoLibrary.authorizationStatus() == .authorized else {
            
            // not authorized, prompt for access
            PHPhotoLibrary.requestAuthorization({ [weak self] status in
                
                // not authorized, end with error
                guard let strongself = self, status == .authorized else {
                    completion(.authCancelled)
                    return
                }
                
                // received authorization, try to save photo to album
                strongself.save(photo, completion: completion)
            })
            return
        }
        
        // check for album, create if not exists
        guard let album = fetchAlbum(named: albumName) else {
            
            // album does not exist, create album now
            createAlbum(named: albumName, completion: { [weak self] success, error in
                
                // album not created, end with error
                guard let strongself = self, success == true, error == nil else {
                    completion(.albumNotExists)
                    return
                }
                
                // album created, run through again
                strongself.save(photo, completion: completion)
            })
            return
        }
        
        // save the photo now... we have permission and the desired album
        insert(photo: photo, in: album, completion: { success, error in
            
            guard success == true, error == nil else {
                completion(.saveFailed)
                return
            }
            
            // finish with no error
            completion(nil)
        })
    }
    
    internal func fetchAlbum(named: String) -> PHAssetCollection? {
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "title = %@", named)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        
        guard let album = collection.firstObject else {
            return nil
        }
        
        return album
    }
    
    internal func createAlbum(named: String, completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: named)
        }, completionHandler: completion)
    }
    
    internal func insert(photo: UIImage, in collection: PHAssetCollection, completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest.creationRequestForAsset(from: photo)
            request.creationDate = NSDate.init() as Date
            
            guard let assetPlaceHolder = request.placeholderForCreatedAsset,
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: collection) else {
                    return
            }
            let enumeration: NSArray = [assetPlaceHolder]
            albumChangeRequest.addAssets(enumeration)
            
        }, completionHandler: completion)
    }
}
