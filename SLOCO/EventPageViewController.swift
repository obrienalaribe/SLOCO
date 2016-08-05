//
//  EventPageViewController.swift
//  SLOCO
//
//  Created by mac on 6/26/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material

class WeeklyEventViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var eventPageViewController: EventPageViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventPageViewController = EventPageViewController(collectionViewLayout: layout)
        dataSource = self
        
        layout.minimumLineSpacing = 0.7
        
        navigationItem.title = "Night Info"
        
        view.backgroundColor = UIColor.whiteColor()
        
        let today = NSDate().dayOfWeek()! - 1
        eventPageViewController.dayOfWeek = weekDays[today]
        
        let viewControllers = [(eventPageViewController as! UIViewController)]
        setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentImageName = (viewController as! EventPageViewController).dayOfWeek
        let currentIndex = weekDays.indexOf(currentImageName!)
        
        if currentIndex < weekDays.count - 1 {
            let eventPageController = EventPageViewController(collectionViewLayout: layout)

            eventPageController.dayOfWeek = weekDays[currentIndex! + 1]
            return eventPageController
        }
        
        else {
            let eventPageController = EventPageViewController(collectionViewLayout: layout)

            eventPageController.dayOfWeek = weekDays.first
            return eventPageController
        }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentImageName = (viewController as! EventPageViewController).dayOfWeek
        let currentIndex = weekDays.indexOf(currentImageName!)

        if currentIndex > 0 {
            let eventPageController = EventPageViewController(collectionViewLayout: layout)

            eventPageController.dayOfWeek = weekDays[currentIndex! - 1]
            return eventPageController
        }
        
        else {
            let eventPageController = EventPageViewController(collectionViewLayout: layout)

            eventPageController.dayOfWeek = weekDays.last
            return eventPageController
        }
    }
    
    
}


class EventPageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var dayOfWeek: String? {
        didSet {
            weekDayLabel.text = dayOfWeek!
        }
    }
    
    let weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(18)
        label.textColor = UIColor.grayColor()
        return label
    }()
    


    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        let layout = UICollectionViewFlowLayout()
        
        collectionView?.alwaysBounceVertical = true
        view.addSubview(weekDayLabel)
        
        collectionView?.registerClass(ViewA.self, forCellWithReuseIdentifier: "cellA")
        collectionView?.registerClass(ViewB.self, forCellWithReuseIdentifier: "cellB")

        view.addConstraint(NSLayoutConstraint(item: weekDayLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraintsWithFormat("V:|-70-[v0]", views: weekDayLabel)
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cellA = collectionView.dequeueReusableCellWithReuseIdentifier("cellA", forIndexPath: indexPath) as! ViewA
            
        
        let cellB = collectionView.dequeueReusableCellWithReuseIdentifier("cellB", forIndexPath: indexPath) as! ViewB
        
        return cellB
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 3
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSizeMake(view.frame.width, 200)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(100, 0, 0, 0)

    }

}

class ViewA : BaseCollectionCell {
    
    override func setupViews() {
        backgroundColor = UIColor.orangeColor()
        
        let leftImageView = createAndAddImageView("miss")
        let topImageView = createAndAddImageView("miss")
        let bottomImageView = createAndAddImageView("miss")
        
        leftImageView.grid.rows = 12
        leftImageView.grid.columns = 6
        
        topImageView.grid.rows = 6
        topImageView.grid.columns = 6
        topImageView.grid.offset.columns = 6
        
        bottomImageView.grid.rows = 6
        bottomImageView.grid.offset.rows = 6
        bottomImageView.grid.columns = 6
        bottomImageView.grid.offset.columns = 6
        
        
        grid.axis.direction = .None
        grid.spacing = 1
        grid.views = [
            leftImageView,
            topImageView,
            bottomImageView,
        ]
        
    }
    
    
}

extension BaseCollectionCell {
    private func createAndAddImageView(imageName: String) -> MaterialView {
        var image: UIImage? = UIImage(named: imageName)
        
        let imageView: MaterialView = MaterialView()
        imageView.image = image
        imageView.contentsGravityPreset = .ResizeAspectFill
        addSubview(imageView)
        
        return imageView
    }
}


class ViewB : BaseCollectionCell {
    
    
    override func setupViews() {
        backgroundColor = UIColor.orangeColor()
        
        let leftImageView = createAndAddImageView("hifi")
        let topImageView = createAndAddImageView("hifi")
        let bottomImageView = createAndAddImageView("hifi")
        
        leftImageView.grid.rows = 12
        leftImageView.grid.columns = 6
        
        topImageView.grid.rows = 6
        topImageView.grid.columns = 6
        topImageView.grid.offset.columns = 6
        
        bottomImageView.grid.rows = 6
        bottomImageView.grid.offset.rows = 6
        bottomImageView.grid.columns = 6
        bottomImageView.grid.offset.columns = 6
        
        
        grid.axis.direction = .None
        grid.spacing = 1
        grid.views = [
            leftImageView,
            topImageView,
            bottomImageView,
        ]
        
    }
}