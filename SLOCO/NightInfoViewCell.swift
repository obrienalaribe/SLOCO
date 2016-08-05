//
//  NightInfoViewCell.swift
//  SLOCO
//
//  Created by mac on 6/22/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit

class NightInfoCell: BaseCollectionCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let eventsCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        return collectionView
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.whiteColor()
        
        addSubview(eventsCollectionView)
        eventsCollectionView.dataSource = self
        eventsCollectionView.delegate = self
        
        eventsCollectionView.registerClass(EventCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: eventsCollectionView)
        addConstraintsWithFormat("V:|[v0]|", views: eventsCollectionView)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(300,frame.height)
    }
}

class EventCell: BaseCollectionCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hifi")
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.cornerRadius = 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    override func setupViews() {
        addSubview(imageView)
        
        imageView.frame = CGRectMake(0, 0, frame.width, frame.height)
    }
}
