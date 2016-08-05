//
//  StoryMenuViewController.swift
//  SLOCO
//
//  Created by mac on 5/31/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material

class StoryMenuViewController: MenuViewController {

    /// MenuView diameter.
    private let baseViewSize: CGSize = CGSizeMake(56, 56)
    
    /// MenuView inset position.
    private let menuViewInset: CGFloat = 16

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareMenuView()
    }
    
    /// Prepares the add button.
    private func prepareMenuView() {
        var image: UIImage? = UIImage.fontAwesomeIconWithName(.Plus, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        let storyMenu: FabButton = FabButton()
        storyMenu.tintColor = MaterialColor.white
        storyMenu.setImage(image, forState: .Normal)
        storyMenu.setImage(image, forState: .Highlighted)
        storyMenu.addTarget(self, action: #selector(handleMenu), forControlEvents: .TouchUpInside)
        menuView.addSubview(storyMenu)
        
        image = UIImage.fontAwesomeIconWithName(.Pencil, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        let writeStoryButton: FabButton = FabButton()
        writeStoryButton.tintColor = MaterialColor.white
        writeStoryButton.backgroundColor = MaterialColor.blue.base
        writeStoryButton.setImage(image, forState: .Normal)
        writeStoryButton.setImage(image, forState: .Highlighted)
        menuView.addSubview(writeStoryButton)
        writeStoryButton.addTarget(self, action: #selector(handleStoryWriteUp), forControlEvents: .TouchUpInside)
        
        image = UIImage.fontAwesomeIconWithName(.Camera, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        let addStoryPhotoButton: FabButton = FabButton()
        addStoryPhotoButton.tintColor = MaterialColor.white
        addStoryPhotoButton.backgroundColor = MaterialColor.green.base
        addStoryPhotoButton.setImage(image, forState: .Normal)
        addStoryPhotoButton.setImage(image, forState: .Highlighted)
        menuView.addSubview(addStoryPhotoButton)
        addStoryPhotoButton.addTarget(self, action: #selector(handleStoryPhoto), forControlEvents: .TouchUpInside)
 
        
        // Initialize the menu and setup the configuration options.
        menuView.menu.baseViewSize = baseViewSize
        menuView.menu.views = [storyMenu, writeStoryButton, addStoryPhotoButton]
        
        view.addSubview(menuView)
        MaterialLayout.size(view, child: menuView, width: baseViewSize.width, height: baseViewSize.height)
        MaterialLayout.alignFromBottomRight(view, child: menuView, bottom: menuViewInset, right: menuViewInset)
    }
    
    
    /// Handle the menuView touch event.
    func handleMenu() {
        if menuView.menu.opened {
            menuViewController?.rootViewController.view.alpha = 1
            closeMenu()
        } else {
            menuViewController?.rootViewController.view.alpha = 0.5
            openMenu()
        }
    }

    /// Loads the AddStoryViewController into the menuViewControllers rootViewController.
    func handleStoryWriteUp() {
        if rootViewController is AddStoryViewController {
            return
        }
        
        closeMenu { [weak self] in
            self?.transitionFromRootViewController(AddStoryViewController(), options: [.TransitionCrossDissolve])
        }
    }
    
    /// Loads the StoryPhotoController into the menuViewControllers rootViewController.
    func handleStoryPhoto() {
        if rootViewController is StoryPhotoViewController {
           return
        }
        
        closeMenu { [weak self] in
            self?.transitionFromRootViewController(StoryPhotoViewController(), options: [.TransitionCrossDissolve])
        }
    }
    
}
