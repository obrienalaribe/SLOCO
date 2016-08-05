//
//  BaseCollectionCell.swift
//  SLOCO
//
//  Created by mac on 5/24/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}
