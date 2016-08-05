//
//  AddStoryViewController.swift
//  SLOCO
//
//  Created by mac on 5/31/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material

class AddStoryViewController: UIViewController {
    
    private var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        label = UILabel()
        label.text = "type story out"
        label.textAlignment = .Center
        
        view.addSubview(label)
        MaterialLayout.alignFromTop(view, child: label, top: 80)
        MaterialLayout.alignToParentHorizontally(view, child: label, left: 40, right: 40)
    }
}
