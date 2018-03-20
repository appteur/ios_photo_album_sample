//
//  PhotoSave.swift
//  drawmoji
//
//  Created by Seth on 3/19/18.
//  Copyright © 2018 Arnott Industries, Inc. All rights reserved.
//

import Foundation
import Photos

class PhotoAlbum: PhotoAlbumHandler {
    
    var albumName: String
    
    init(named: String) {
        albumName = named
    }
}
