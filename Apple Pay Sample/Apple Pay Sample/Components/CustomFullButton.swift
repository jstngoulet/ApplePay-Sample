//
//  CustomFullButton.swift
//  HyreCar Analytics
//
//  Created by Tizzle Goulet on 2/19/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import UIKit

/**
    Create a button subclass that we want to use for all of our buttons.
    This way, we can ensure a single action can be performed every time a button is pressed, for example
 */
class CustomFullButton: UIButton {

    /// Set evey button to have these traits.
    ///
    /// - Parameter frame: The frame of the new button
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsTouchWhenHighlighted = true
    }
    
    /// Init with Coder, called when initailizing the view from a nib
    ///
    /// - Parameter aDecoder: The curent code attributes.
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
