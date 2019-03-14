//
//  CommonProtocols.swift
//  HyreCar Analytics
//
//  Created by Tizzle Goulet on 2/19/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import Foundation
import UIKit

/// Protocol that every custom child view should implement
protocol DesignProtocol {
    /// Function to build the view, ensures document consistancy
    func build()
}
