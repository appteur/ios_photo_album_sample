//
//  PhotoAlbums.swift
//  PhotosTest
//
//  Created by Seth on 3/19/18.
//  Copyright © 2018 Seth. All rights reserved.
//

import Foundation

public enum PhotoAlbums {
    case landscapes
    case portraits
    
    var albumName: String {
        switch self {
        case .landscapes: return "Landscapes"
        case .portraits: return "Portraits"
        }
    }
    
    func album() -> PhotoAlbumHandler {
        return PhotoAlbum.init(named: albumName)
    }
}
