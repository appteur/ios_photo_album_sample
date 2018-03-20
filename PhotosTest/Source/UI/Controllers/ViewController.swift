//
//  ViewController.swift
//  PhotosTest
//
//  Created by Seth on 3/19/18.
//  Copyright © 2018 Seth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonAction(_ sender: Any) {
        let photo: UIImage = #imageLiteral(resourceName: "settings")
        
        viewModel.savePhoto(photo) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    // show alert with error message or...???
                    self.label.text = error.message
                    return
                }
                
                self.label.text = "Saved image to album"
            }
        }
    }

}

