//
//  ViewController.swift
//  Apple Pay Sample
//
//  Created by Tizzle Goulet on 3/12/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import UIKit
import PassKit

/**
    View Controller in charge of showing the Apple Pay button and the actions
 */

class ApplePayViewController: UIViewController {
    
    //  UI Elements
    /// Headerview to show the background color and title
    private var headerView: HeaderView!
    
    ///  Shows a product image view, solely for example sake
    private var productImageView: UIImageView!
    
    ///  Shows the product title label
    private var productTitleLabel: UILabel!
    
    ///  Shows the product detail label, which may include price
    private var productDescriptionLabel: UILabel!
    
    ///  The Purhcase button to start the purchase process
    private var purchaseButton: BottomButton!
    
    ///  Hlper vars for configuring what the status bar color should be
    private var shouldShowLightStatusBar: Bool = false
    
    /// Set the default style based on a created value in this class
    override var preferredStatusBarStyle: UIStatusBarStyle { return shouldShowLightStatusBar ? .lightContent : .default }

    ///  Create the payment request. Since we only have one product, we can create it in a LABDA
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.hyrecar.ios.apple-pay-test-app"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["US"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iPad Pro", amount: 789.99, type: PKPaymentSummaryItemType.final)]
        return request
    }()
    
    /// When the view loaded, run some additonal UI Still
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        build()
    }


}

// MARK: - Design (Constructs the view)
extension ApplePayViewController {
    
    /// Wrapper function to build the UI Elements in the view
    private func build() {
        _ = addHeaderBackgroundView()
            .addProductImageView()
            .addProductTitleLabel()
            .addProductDescriptionLabel()
            .addApplePayButton()
    }
    
    /// Add the header view to the current view
    ///
    /// - Returns: Self to cherry pick functions to know the previous function ran successfully
    private func addHeaderBackgroundView() -> Self {
        if headerView != nil { return self }
        
        //  Create the header view with the desired title and image
        //  Note: We are using a template image so that the color of the image adjusts based on teh tint color of the image
        //      view frame. We will adjust this next
        headerView = HeaderView(
            withTitle: "Apple Pay Sample",
            image: UIImage(named: "Apple_Pay_Header_Icon")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate),
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: view.frame.width,
                    height: view.frame.height * 0.35
                )
            )
        )
        
        //  Set the tint color of the image view, if it exists
        headerView.imageView?.tintColor = UIColor.white
        
        //  Add the header view to the parent subview
        view.addSubview(headerView)
        
        //  Trigger some changes in the color
        headerView.titleColor.accept(UIColor.white)
        headerView.color.accept(UIColor.gray)
        
        //  Update the status bar color, if needed
        shouldShowLightStatusBar = true
        setNeedsStatusBarAppearanceUpdate()
        return self
    }
    
    /// Adds the product image view to the parent view
    ///
    /// - Returns: Self
    private func addProductImageView() -> Self {
        if productImageView != nil { return self }
        productImageView = UIImageView(
            frame: CGRect(
                x: view.offset,
                y: headerView.frame.maxY + view.offset,
                width: view.frame.width - view.offset*2,
                height: headerView.frame.height * 0.65
            )
        )
        
        //  Set the image to scale to fit in the current frame
        productImageView.contentMode = .scaleAspectFit
        
        //  Set the image
        productImageView.image = UIImage(named: "iPad_Pro_Image")
        
        //  Add the image to the parent view
        view.addSubview(productImageView)
        return self
    }
    
    /// Add the Product Title label, includes the product name
    ///
    /// - Returns: Self
    private func addProductTitleLabel() -> Self {
        if productTitleLabel != nil { return self }
        
        //  Store the width in a label becuase we will use it again after resize
        let labelWidth: CGFloat = view.frame.width - view.offset*2
        
        //  Add the label
        productTitleLabel = UILabel(
            frame: CGRect(
                x: view.offset,
                y: productImageView.frame.maxY + view.offset,
                width: labelWidth,
                height: 0
            )
        )
        
        //  Set the text of the Product Label
        productTitleLabel.text = "iPad Pro"
        
        //  Set the font
        productTitleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        //  Center align
        productTitleLabel.textAlignment = .center
        
        //  Size to fit (for auto height)
        productTitleLabel.sizeToFit()
        
        //  Adjust the width
        productTitleLabel.frame.size.width = labelWidth
        
        //  Add to the parent view
        view.addSubview(productTitleLabel)
        return self
    }
    
    /// Add the product description label directly beneath the title label
    ///
    /// - Returns: Self
    private func addProductDescriptionLabel() -> Self {
        if productDescriptionLabel != nil { return self }
        
        //  Add the label
        productDescriptionLabel = UILabel(
            frame: CGRect(
                x: view.offset,
                y: productTitleLabel.frame.maxY + view.offset,
                width: productTitleLabel.frame.width,
                height: 0
            )
        )
        
        //  Ideally, the labels would be a component, that would self size.
        //  This can be done through an extension of UILabel, or just a child Component of UILabel
        //  For sake of example, we are going to show how an attributed string can be created, if a label provides further customization
        
        //  First, create the paragraph style for center alignment
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        //  Now, set the attributed string
        productDescriptionLabel.attributedText = NSAttributedString(
            string: """
            $789.99 per Item
            
            The iPad is a sleek tablet that looks like a cross between an iPhone and the LCD case of the MacBook Air.
            """,
            attributes:
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
            ]
        )
        
        //  Set the number of lines to display
        productDescriptionLabel.numberOfLines = 0
        
        //  Now size the label and ensure that it is placed in the correct location
        productDescriptionLabel.sizeToFit()
        
        //  Note that frame.size.width is mutable, where frame.width is just an accessor
        //  Also note that setting the size or origin is not directly animatable. Must be the frame entirely
        productDescriptionLabel.frame.size.width = productTitleLabel.frame.width
        
        //  Add the label to the parent
        view.addSubview(productDescriptionLabel)
        
        return self
    }
    
    /// Add the Apple Pay button to the bottom of the view
    ///
    /// - Returns: Self
    private func addApplePayButton() -> Self {
        if purchaseButton != nil { return self }
        purchaseButton = BottomButton(withTitle: "Purchase", action: { [weak self] in
            //  Action to perfomr when clicked (onTouchUpinside)
            //  Start the apple pay process
            self?.purchase()
        })
        view.addSubview(purchaseButton)
        return self
    }
    
}

// MARK: - Actions (Handles the on-click events)
extension ApplePayViewController {
    
    /// Assigns the purchase action to the bottom button so that the Apple Pay process may start.
    /// Creates a new payment request, sets the deelgate, then shows the new payment controller
    @IBAction
    private func purchase() {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            print("Could not open product")
        }
    }
    
}

// MARK: - Payment controller delegate
extension ApplePayViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    /// Action to complete if the user cancelled the action
    ///
    /// - Parameter controller: The Payment View Cotnroller, from the Apple Pay Delegate
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) {
            print("Controller Dismissed")
        }
    }
    
    /// Shows an alert confirming the payment
    ///
    /// - Parameters:
    ///   - controller: The payment controller
    ///   - payment: The payment that has been made
    ///   - completion: The completion block that includes the action to occur on successful completion
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        //  Create an alert view. Has no action by default
        let alertView = UIAlertController(
            title: "Payment finished",
            message: "You successfully submitted a payment with Apple Pay",
            preferredStyle: UIAlertController.Style.alert
        )
        
        //  Add a simple action to the alert, allowing the user to dismiss the action view
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            print("Ok Pressed")
        }))
        
        //  Dismiss the controller, when the payment is done, then show an alert containing the success message
        controller.dismiss(animated: true) {
            self.present(alertView, animated: true, completion: nil)
        }
        
        //  We do not need any information from the completion, so we don't have to do anything else here, except end the payment
        completion(PKPaymentAuthorizationResult(status: PKPaymentAuthorizationStatus.success, errors: nil))
    }
}
