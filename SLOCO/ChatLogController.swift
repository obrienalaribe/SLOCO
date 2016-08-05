//
//  ChatLogController.swift
//  SLOCO
//
//  Created by mac on 6/16/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var messages: [Message]?
    
    var buddy: User? {
        didSet {
            navigationItem.title = buddy?.firstname
            messages = buddy?.messages?.allObjects as? [Message]
            messages = messages?.sort({$0.created_at!.compare($1.created_at!) == .OrderedAscending})

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        
        return 0
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.item].content
        
        
        if let messageText = messages?[indexPath.item].content, profileImageName = messages?[indexPath.item].author?.profile?.image {
            
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string:messageText).boundingRectWithSize(size, options:options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(18)], context: nil)
            
            cell.profileImageView.image = UIImage(named: profileImageName)
            let xFloat: CGFloat = 8
            cell.messageTextView.frame = CGRectMake(40 + xFloat, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRectMake(40, 0, estimatedFrame.width + 16 + xFloat, estimatedFrame.height + 20)

        }
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].content {
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string:messageText).boundingRectWithSize(size, options:options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(18)], context: nil)
            
            return CGSizeMake(view.frame.width, estimatedFrame.height + 20)

        }
        return CGSizeMake(view.frame.width, 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
}

class ChatLogMessageCell : BaseCollectionCell {
    
    let messageTextView : UITextView = {
        let textView = UITextView()
        textView.text = "Sample text"
        textView.font = UIFont.systemFontOfSize(18)
        textView.backgroundColor = UIColor.clearColor()
        return textView
    }()
    
    let textBubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]|", views: profileImageView)
        profileImageView.backgroundColor = UIColor.redColor()

    }
}


