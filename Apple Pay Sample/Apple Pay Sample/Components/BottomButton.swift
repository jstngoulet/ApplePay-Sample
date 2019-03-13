//
//  BottomButton.swift
//  HyreCar Analytics
//
//  Created by Tizzle Goulet on 2/19/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import UIKit

/**
    Creates a button at the bottom of the view
 */
class BottomButton: UIView, DesignProtocol {
    
    /// Button
    private var mainButton: CustomFullButton!
    
    //  Accessable elements, mutates design if needed
    
    /// The current button title, using a custom didSet function.
    /// When the value is changed, the button title is set accordingly in the UI
    var buttonTitle: String = "Button Title"{
        didSet {
            setButtonTitle()
        }
    }
    
    /// The button action to perform when the button is selected
    var buttonAction: StandardCompletion = {}
    
    /// The default button height to be displayed. DEfaults to 50
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
        if mainButton != nil { return self }
        mainButton = CustomFullButton(
            frame: CGRect(
                x: offset,
                y: offset,
                width: frame.width - offset*2,
                height: buttonHeight
            )
        )
        mainButton.layer.cornerRadius = 5
        mainButton.backgroundColor = UIColor.gray
        mainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setButtonTitle()
        mainButton.addTarget(self, action: #selector(buttonSelected), for: UIControl.Event.touchUpInside)
        addSubview(mainButton)
        return self
    }
}

// MARK: - Mutators
extension BottomButton {
    
    /// Sets the button title in a single function to ensure consistancy
    private func setButtonTitle() {
        mainButton.setTitle(buttonTitle, for: .normal)
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
