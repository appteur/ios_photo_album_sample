//
//  ViewModel.swift
//  PhotosTest
//
//  Created by Seth on 3/19/18.
//  Copyright © 2018 Seth. All rights reserved.
//

import UIKit

class ViewModel {
    let landscapeAlbum = PhotoAlbums.landscapes.album()
    let portraitAlbum = PhotoAlbums.portraits.album()
    
    func savePhoto(_ photo: UIImage?, completion: @escaping (PhotoAlbumHandlerError?) -> Void) {
        guard let photo = photo else {
            completion(.nilPhoto)
            return
        }
        
        landscapeAlbum.save(photo, completion: completion)
    }
}
