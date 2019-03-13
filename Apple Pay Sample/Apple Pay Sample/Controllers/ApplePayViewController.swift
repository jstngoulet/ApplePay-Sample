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
    private var headerView: HeaderView!
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var productDescriptionLabel: UILabel!
    private var purchaseButton: BottomButton!
    
    //  Hlper vars for configuring what the status bar color should be
    private var shouldShowLightStatusBar: Bool = false
    
    /// Set the default style based on a created value in this class
    override var preferredStatusBarStyle: UIStatusBarStyle { return shouldShowLightStatusBar ? .lightContent : .default }

    //  Create the payment request. Since we only have one product, we can create it in a LABDA
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.hyrecar.ios.apple-pay-test-app"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["US"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Test Product", amount: 19.99, type: PKPaymentSummaryItemType.final)]
        return request
    }()
    
    /// When the view loaded, run some additonal UI Stull
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
            .addApplePayButton()
    }
    
    /// Add the header view to the current view
    ///
    /// - Returns: Self to cherry pick functions to know the previous function ran successfully
    private func addHeaderBackgroundView() -> Self {
        if headerView != nil { return self }
        headerView = HeaderView(
            withTitle: "Apple Pay Sample",
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: view.frame.width,
                    height: view.frame.height * 0.4
                )
            )
        )
        view.addSubview(headerView)
        
        //  Trigger some changes in the color
        headerView.titleColor.accept(UIColor.white)
        headerView.color.accept(UIColor.gray)
        
        //  Update the status bar color, if needed
        shouldShowLightStatusBar = true
        setNeedsStatusBarAppearanceUpdate()
        return self
    }
    
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
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        print("Finished. Showing user an Alert")
        
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let alertView = UIAlertController(
            title: "Payment finished",
            message: "You successfully submitted a payment with Apple Pay",
            preferredStyle: UIAlertController.Style.alert
        )
        controller.dismiss(animated: true) {
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
