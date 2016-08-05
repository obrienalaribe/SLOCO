//
//  CustomTabBarController.swift
//  SLOCO
//
//  Created by mac on 5/24/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material
import FontAwesome_swift

class CustomTabBarController: BottomNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.tintColor = UIColor(hexString: "298eea")
        tabBar.tintColor = UIColor(hexString: "ff7788")

        tabBar.backgroundColor = MaterialColor.grey.darken4
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1.5
        
        
        let storyNavController: UINavigationController = UINavigationController(rootViewController: TimelineViewController(collectionViewLayout: layout))
        
        let nightInfoCV = WeeklyEventViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        let nightInfoNVC = UINavigationController(rootViewController: nightInfoCV)
        
        nightInfoNVC.tabBarItem.title = "Night Info"
        nightInfoNVC.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Ticket, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        storyNavController.tabBarItem.title = "Stories"
        storyNavController.tabBarItem.image = UIImage.fontAwesomeIconWithName(.ThList, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        let messageNavController: UINavigationController = UINavigationController(rootViewController: MessageViewController(collectionViewLayout: layout))

        messageNavController.tabBarItem.title = "Messages"
        messageNavController.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Envelope, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))

                
        
        let notificationVC = NotificationViewController(collectionViewLayout: layout)
        let notificationNC = UINavigationController(rootViewController: notificationVC)
        notificationNC.tabBarItem.title = "Notifications"
        notificationNC.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Bell, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        
        viewControllers = [storyNavController, nightInfoNVC, messageNavController, notificationNC]
        
        tabBar.translucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, 1000, 0.5)
        topBorder.backgroundColor = UIColor.rgb(229, green: 231, blue: 235).CGColor
        
        tabBar.layer.addSublayer(topBorder)
    
        tabBar.clipsToBounds = true; //removes divider line
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
