//
//  StoryPhotoViewController.swift
//  SLOCO
//
//  Created by mac on 5/31/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material

class StoryPhotoViewController: UIViewController {

    private var label: UILabel!
    private var imageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
       
        print("in fusuma del")  
        imageView = UIImageView()
        
        
        view.addSubview(imageView)
        
        MaterialLayout.alignFromTop(view, child: imageView, top: 80)
        MaterialLayout.alignToParentHorizontally(view, child: imageView, left: 40, right: 40)
    }
    
    
    // MARK: FusumaDelegate Protocol
    func fusumaImageSelected(image: UIImage) {
        
        print("Image selected")
        imageView.image = image
    }
    
    func fusumaDismissedWithImage(image: UIImage) {
        
        print("Called just after dismissed FusumaViewController")
    }
    
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested", message: "Saving image needs to access your photo album", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .Default, handler: { (action) -> Void in
            
            if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func fusumaClosed() {
        
        print("Called when the close button is pressed")
    }
}
