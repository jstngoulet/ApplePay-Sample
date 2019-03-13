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

extension UIColor {
    
    static let BackgroundColorRelay: BehaviorRelay<UIColor> = BehaviorRelay(value: UIColor.white)
    static let SubviewBackgroundColorRelay: BehaviorRelay<UIColor> = BehaviorRelay(value: .clear)
    
    
}
