//
//  TimelineViewController.swift
//  SLOCO
//
//  Created by mac on 5/4/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material
import SwiftHEXColors
import FontAwesome_swift

let cellId = "cellId"
let storyFontSize:CGFloat = 14

class Post {
    var name: String?
    var statusText:String?
    var profileImageName:String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
}

class TimelineViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SLOCO"
        
    
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.profileImageName = "zuckprofile"
        postMark.statusText = "By giving people the power to share, we're making the world more transparent."
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = 400
        postMark.numComments = 123
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.profileImageName = "steve_profile"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" +
            "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" +
        "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 1000
        postSteve.numComments = 55
        
        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.profileImageName = "gandhi"
        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n" +
            "The weak can never forgive. Forgiveness is the attribute of the strong.\n" +
        "Happiness is when what you think, what you say, and what you do are in harmony."
        postGandhi.statusImageName = "gandhi_status"
        postGandhi.numLikes = 333
        postGandhi.numComments = 22
        
        
        posts.append(postMark)
        posts.append(postSteve)
        posts.append(postGandhi)
        
    
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.registerClass(StoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewDidAppear(animated: Bool) {
        collectionView?.scrollEnabled = true

        print("enabled scrolling for view appear")
    }
    

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let feedCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! StoryCell
        feedCell.post = posts[indexPath.row]
        
        return feedCell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let statusText = posts[indexPath.item].statusText {
            //determine bounding height for varying status
            let statusBlock = NSString(string:statusText).boundingRectWithSize(CGSizeMake(view.frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union((NSStringDrawingOptions.UsesLineFragmentOrigin)), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(storyFontSize)], context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSizeMake(view.frame.width, statusBlock.height + knownHeight + 24)
        }
        
        
        return CGSizeMake(view.frame.width, 400)
    }
    
    //MARK: Actions
    
    internal func handleSearch() {
        print("searching something")
    }
    
}


class StoryCell: BaseCollectionCell {
    
    var post: Post? {
        //listen for when this attribute is set on the collection view
        didSet {
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
                
                attributedText.appendAttributedString(NSAttributedString(string:"\nDec 18 - San Fran - " ,
                    attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(12), NSForegroundColorAttributeName: UIColor.rgb(155, green: 161, blue: 171)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range:NSMakeRange(0, attributedText.string.characters.count))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRectMake(0, -2, 12, 12)
                attributedText.appendAttributedString(NSAttributedString(attachment: attachment))
                
                
                nameLabel.attributedText = attributedText
            }
            
            if let statusText = post?.statusText {
                storyTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            if let statusImageName = post?.statusImageName {
                storyImageView.image = UIImage(named: statusImageName)
            }
            
           
            
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.redColor()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let storyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Meanwhile this time all is good"
        textView.font = UIFont.boldSystemFontOfSize(14)
        textView.scrollEnabled = false
        return textView
    }()
    
    let storyImageView : UIImageView = {
        let imageView = UIImageView()
        //        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true //remove overflow
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.text = "488 Likes   10.7k Comments"
        commentLabel.textAlignment = .Right
        commentLabel.font = UIFont.systemFontOfSize(12)
        commentLabel.textColor = UIColor.rgb(155, green: 161, blue: 171)
        return commentLabel
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    
    var likeButton = StoryCell.buttonForTitle("Like", imageName: .ThumbsUp)

    let commentButton = StoryCell.buttonForTitle("Comment", imageName: .Comment)
    
    override func setupViews() {
        
        backgroundColor = UIColor(hexString: "fff")
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(storyTextView)
        addSubview(storyImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        
        likeButton.addTarget(self, action: #selector(handleLikeAction), forControlEvents: .TouchUpInside)
        
        //horizontal constraints
        addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat("H:|-4-[v0]-4-|", views: storyTextView)
        addConstraintsWithFormat("H:|[v0]|", views: storyImageView)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", views: likesCommentsLabel)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", views: dividerLineView)
        
        //horizantal button constraints
        addConstraintsWithFormat("H:|[v0(v1)][v1]|", views: likeButton,commentButton)
        
        //vertical constraints
        addConstraintsWithFormat("V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, storyTextView, storyImageView, likesCommentsLabel, dividerLineView, likeButton)
        
        //vertical button constraints to match grid layout
        addConstraintsWithFormat("V:[v0(44)]|", views: commentButton) //vertical height of 44 same as like Button

    }
    
    static func buttonForTitle(title:String, imageName:FontAwesome) ->UIButton {
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.rgb(143, green: 150, blue: 163), forState: .Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.setImage(UIImage.fontAwesomeIconWithName(imageName, textColor: UIColor(hexString: "fafafa")!, size: CGSizeMake(10, 10)), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        return button
    }
    
    
    internal func handleLikeAction() {
        print("like this")
    }
    
}

