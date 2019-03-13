//
//  UIColor+Extension.swift
//  Apple Pay Sample
//
//  Created by Tizzle Goulet on 3/12/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

/**
    Extend UIColor to add properties to be accessable throughout the application
 */
extension UIColor {
    
    /// Background color relay, if we want to apply themes to the application down the road
    static let BackgroundColorRelay: BehaviorRelay<UIColor> = BehaviorRelay(value: UIColor.white)
    
    /// Subview background color relay, if we want to have themes down the road
    static let SubviewBackgroundColorRelay: BehaviorRelay<UIColor> = BehaviorRelay(value: .clear)
    
    
}
