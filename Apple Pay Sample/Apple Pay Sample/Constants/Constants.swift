//
//  Constants.swift
//  Apple Pay Sample
//
//  Created by Tizzle Goulet on 3/12/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import Foundation
import UIKit

/**
    Create a struct of Constants to be accessable when needed throughout the application. This is to ensure consistancy
 */
struct Constants {
    
    /// Sub struct of View Sizes
    struct ViewSizes {
        
        /// Offset from the edge we want to apply to certain views
        static let offset: CGFloat = 20
    }
    
    
}

//  Start of completions
/// Complete an action, no parameters
typealias StandardCompletion = () -> Void
