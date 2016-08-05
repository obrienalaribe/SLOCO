//
//  NotificationViewController.swift
//  SLOCO
//
//  Created by mac on 6/7/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit

class NotificationViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(hexString: "fafafa")
        navigationItem.title = "Notifications"

        collectionView?.registerClass(NotificationCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor(hexString: "fff")

        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(view.frame.width, 70)
    }
    
    //Handle various screen orientation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    

}


class NotificationCell: BaseCollectionCell {
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.blackColor()
        label.text = "Daniel Jobbs commented on your post  \n Here"
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.orangeColor()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
 
    
    override func setupViews() {
        
        addSubview(profileImageView)
        setupContainerView()
        
        //horizontal constraints
        addConstraintsWithFormat("H:|-8-[v0(44)]", views: profileImageView)
        
        
        //vertical constraints
        addConstraintsWithFormat("V:|-8-[v0(44)]", views: profileImageView)
        
        
        
    }
    
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        containerView.backgroundColor = UIColor.clearColor()
        addConstraintsWithFormat("H:|-70-[v0]-10-|", views: containerView)
        addConstraintsWithFormat("V:[v0(60)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
       
        
        containerView.addConstraintsWithFormat("H:|[v0]", views: nameLabel)
        
        containerView.addConstraintsWithFormat("V:|-10-[v0]", views: nameLabel)
        
       
    }

    
    
    
}


