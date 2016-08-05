//
//  CarListViewController.swift
//  SLOCO
//
//  Created by mac on 6/23/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import HTHorizontalSelectionList

class EventViewController: UIViewController, HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource {
    
    var selectionList : HTHorizontalSelectionList?
    let titles : [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedTitleLabel : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
        view.backgroundColor = UIColor.whiteColor()
        let selectionList = HTHorizontalSelectionList(frame: CGRectMake(0, 0, view.frame.size.width, 80))
        selectionList.delegate = self
        selectionList.dataSource = self
        
        selectionList.selectionIndicatorStyle = .BottomBar
        selectionList.selectionIndicatorColor = UIColor.redColor()
        selectionList.bottomTrimHidden = true
        
        selectionList.centerButtons = true
        selectionList.evenlySpaceButtons = true
        
        selectionList.setSelectedButtonIndex(5, animated: true)

        
        selectionList.centerOnSelection = true
        
        selectionList.buttonInsets = UIEdgeInsetsMake(5, 10, 5, 10);
        
        view.addSubview(selectionList)
        
        let selectedTitleLabel = UILabel()
        selectedTitleLabel.text = titles[selectionList.selectedButtonIndex]
        selectedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedTitleLabel)
        
        view.addConstraint(NSLayoutConstraint(item: selectedTitleLabel,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[selectionList]-margin-[selectedFlowerView]",
            options: .DirectionLeadingToTrailing,
            metrics: ["margin" : 50],
            views: ["selectionList" : selectionList, "selectedFlowerView" : selectedTitleLabel]))
        
        self.selectionList = selectionList
        self.selectedTitleLabel = selectedTitleLabel
    
    }
    
    
    
    // MARK: - HTHorizontalSelectionListDataSource Protocol Methods
    
    func numberOfItemsInSelectionList(selectionList: HTHorizontalSelectionList) -> Int {
        return titles.count
    }
    
    func selectionList(selectionList: HTHorizontalSelectionList, titleForItemWithIndex index: Int) -> String? {
        return titles[index]
    }
    
    // MARK: - HTHorizontalSelectionListDelegate Protocol Methods
    
    func selectionList(selectionList: HTHorizontalSelectionList, didSelectButtonWithIndex index: Int) {
        // update the view for the corresponding index
        selectedTitleLabel?.text = titles[index]
        


    }
    
}