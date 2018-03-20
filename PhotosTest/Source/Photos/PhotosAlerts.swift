//
//  PhotosAlerts.swift
//  drawmoji
//
//  Created by Seth on 3/19/18.
//  Copyright © 2018 Arnott Industries, Inc. All rights reserved.
//

import Foundation


public enum PhotoAlbumAlerts {
    case confirmSave
    case success
    case genericError
    case permissionsError
    
    var title: String? {
        switch self {
        case .confirmSave:
            return "Save to Photos?"
        case .success:
            return "Success"
        case .permissionsError:
            return "Photo Album Access"
        default:
            return nil
        }
    }
    
    var message: String {
        switch self {
        case .confirmSave:
            return "Would you like to save an image of your drawing to your photos library?"
        case .success:
            return "Successfully saved an image of your drawing to your photo library"
        case .genericError:
            return "An error occured, unable to save an image of your drawing to your photos library"
        case .permissionsError:
            return "Unable to access your photo album. Please enable photo permissions in the settings app."
        }
    }
    
    var okBtnTitle: String {
        switch self {
        case .success:
            return "Success"
        case .permissionsError:
            return "Go to Settings"
        default:
            return ""
        }
    }
    
    var cancelBtnTitle: String {
        return "Cancel"
    }
}
