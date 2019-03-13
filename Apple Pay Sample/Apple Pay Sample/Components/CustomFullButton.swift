//
//  CustomFullButton.swift
//  HyreCar Analytics
//
//  Created by Tizzle Goulet on 2/19/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import UIKit

class CustomFullButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsTouchWhenHighlighted = true
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
