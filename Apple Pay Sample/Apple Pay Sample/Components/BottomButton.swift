//
//  BottomButton.swift
//  HyreCar Analytics
//
//  Created by Tizzle Goulet on 2/19/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import UIKit

class BottomButton: UIView, DesignProtocol {
    
    /// Button
    private var _mainButton: CustomFullButton!
    
    //  Accessable elements, mutates design if needed
    var buttonTitle: String = "Button Title"{
        didSet {
            setButtonTitle()
        }
    }
    var buttonAction: StandardCompletion = {}
    private var buttonHeight: CGFloat = 50

    /// Create a new bottom buttom with the set title and action. This button will appear at the bottom of the frame by default
    ///
    /// - Parameters:
    ///   - buttonTitle: The title of hte button to display
    ///   - action: The action to perofmr when the button is tapped
    convenience init(withTitle buttonTitle: String, action: @escaping StandardCompletion) {
        self.init()
        self.buttonTitle = buttonTitle
        self.buttonAction = action
        build()
    }
    
}

// MARK: - DEsign
extension BottomButton {
    
    /// Builds the parent view and the child view
    func build() {
        _ = buildBackground()
            .buildButton()
    }
    
    /// Adjust the background of the view so that the button fits nicely in it
    ///
    /// - Returns: self
    private func buildBackground() -> Self {
        let height = offset*2 + buttonHeight + iPhoneXOffset(side: .bottom)
        frame = CGRect(
            x: 0,
            y: UIScreen.main.bounds.height - height,
            width: UIScreen.main.bounds.width,
            height: height
        )
        return self
    }
    
    /// Builds teh main bitton in the view
    ///
    /// - Returns: self
    private func buildButton() -> Self {
        if _mainButton != nil { return self }
        _mainButton = CustomFullButton(
            frame: CGRect(
                x: offset,
                y: offset,
                width: frame.width - offset*2,
                height: buttonHeight
            )
        )
        _mainButton.layer.cornerRadius = 5
        _mainButton.backgroundColor = UIColor.gray
        _mainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setButtonTitle()
        _mainButton.addTarget(self, action: #selector(buttonSelected), for: UIControl.Event.touchUpInside)
        addSubview(_mainButton)
        return self
    }
}

// MARK: - Mutators
extension BottomButton {
    
    /// Sets the button title in a single function to ensure consistancy
    private func setButtonTitle() {
        _mainButton.setTitle(buttonTitle, for: .normal)
    }
    
}

// MARK: - Actions
extension BottomButton {
    
    /// Action to be performed when the button is selected. Note that this action may be changed after set
    @IBAction
    private func buttonSelected() {
        self.buttonAction()
    }
    
}
