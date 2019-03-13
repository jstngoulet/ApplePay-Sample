//
//  UIView+Extension.swift
//  Apple Pay Sample
//
//  Created by Tizzle Goulet on 3/12/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Get the offset from the constants file and make it available in any view
    var offset: CGFloat { return Constants.ViewSizes.offset }
    
    /// Add a shadow around view, without effecting th corner radius.
    func shadowAround() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.cornerRadius = max(5, layer.cornerRadius)
    }
    
    /// Sets up an observer on the current view to listen for changes in teh background color, then animates the change
    func listenForColorChange() {
        _ = UIColor.BackgroundColorRelay.subscribe(onNext: { (newColor) in
            runOnMainThreadWith(delay: 0, closure: {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundColor = newColor
                })
            })
        })
    }
    
    /// Sets up an observer that listens for a subview color change, then animates the change
    func listenForSubviewColorChange() {
        _ = UIColor.SubviewBackgroundColorRelay.subscribe(onNext: { (newColor) in
            runOnMainThreadWith(delay: 0, closure: {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundColor = newColor
                })
            })
        })
    }
    
    
}

/// Functions that do not need to be associated with a class to function
/// Runs a function on the main thread after stated delay
///
/// - Parameters:
///   - delay:      Time in seconds to wait before executing
///   - closure:    The operation to perform once the delay has ended
func runOnMainThreadWith(delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() +
            Double(Int64(delay * Double(NSEC_PER_SEC))) /
            Double(NSEC_PER_SEC), execute: closure)
}

/// Runs on a utility thread, NO UI Updating
///
/// - Parameters:
///   - delay:      Time in seconds to wait before executing
///   - closure:    The operation to perform once the delay has ended
func runOnUtilityThreadWith(delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.global(qos: .utility).asyncAfter(
        deadline: DispatchTime.now() +
            Double(Int64(delay * Double(NSEC_PER_SEC))) /
            Double(NSEC_PER_SEC), execute: closure)
}


/// Returns the offset for the given side
///
/// - Parameter side: The side in which to find the offset for. Note that the top and bottom are most helpful
/// - Returns: The offset as a CGFloat
func iPhoneXOffset(side: UIRectEdge) -> CGFloat {
    guard #available(iOS 11, *) else { return 0 }
    guard let window = UIApplication.shared.delegate?.window as? UIWindow else { return 0 }
    switch side {
    case UIRectEdge.bottom:
        return window.safeAreaInsets.bottom
    case UIRectEdge.top:
        return window.safeAreaInsets.top
    case UIRectEdge.left:
        return window.safeAreaInsets.left
    case UIRectEdge.right:
        return window.safeAreaInsets.right
    default:
        return 0
    }
}
