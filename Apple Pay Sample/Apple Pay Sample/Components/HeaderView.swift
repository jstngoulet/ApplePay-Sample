//
//  HeaderView.swift
//  Apple Pay Sample
//
//  Created by Tizzle Goulet on 3/12/19.
//  Copyright © 2019 HyreCar. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

/**
    This header view is Reactive to the text, color and fonts displayed. Just contains a header label and a parent frame
 */
class HeaderView: UIView {

    //  UI  Elements
    /// The label to house the title text in the frame
    private var titleLabel: UILabel!
    
    /// The image view to hold the image in the header
    private var headerImageView: UIImageView!
    
    //  Expose the image view for further customization,
    /// The current image view in the header, if it exists
    var imageView: UIImageView? { return headerImageView == nil ? nil : headerImageView }
    
    //  Attributes
    /// Relay for listening to the title text. Adjust the label when changed
    var titleText: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// The title color. Adjust the title color of the label when changed
    var titleColor: BehaviorRelay<UIColor> = BehaviorRelay(value: UIColor.white)
    
    /// Changes the color of the background in an animation when changed
    var color: BehaviorRelay<UIColor> = BehaviorRelay(value: UIColor.clear)
    
    /// The image in the image view. Adjusts the image view content when changed
    var image: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    
    ///  Dispose bag, reposponible for alerting the observable to stop emitting events
    private var _bag = DisposeBag()
    
    /// Create a new header with an optional image.
    ///
    /// - Note: If no frame is provided, the frame will automatically be placed in the top of the view with a height
    ///     of the screen divided by 2.5
    ///
    /// - Parameters:
    ///   - title:      The title to display in the header label
    ///   - image:      The image to display in the title image view
    ///   - frame:      The frame of the header, if different than default
    convenience init(withTitle title: String, image: UIImage?, frame: CGRect? = nil) {
        let screenBounds = UIScreen.main.bounds
        self.init(
            frame: frame ?? CGRect(
                origin: .zero,
                size: CGSize(
                    width: screenBounds.width,
                    height: screenBounds.height/2.5
                )
            )
        )
        self.titleText.accept(title)
        self.image.accept(image)
        build()
    }
    
}

// MARK: - Design (Construct the view)
extension HeaderView: DesignProtocol {
    
    /// Construct the UI ELements on the view
    func build() {
        addTitleLabel()
            .addImageView()
            .adjustBackground()
    }
    
    /// Add the title label to the view
    ///
    /// - Returns: Self
    private func addTitleLabel() -> Self {
        if titleLabel != nil { return self }
        titleLabel = UILabel(
            frame: CGRect(
                x: offset,
                y: 0,
                width: frame.width - offset*2,
                height: 0
            )
        )
        
        //  Set the font of the label to default bold font of the system
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        //  Set the number of lines to 0 so that there is no limit
        titleLabel.numberOfLines = 0
        
        //  Listen for text changes and update the text and frame accordingly
        //  Note that this example is showing all available blocks on the observable.
        //      They are not all required
        titleText.subscribe(onNext: { [weak self] (newString) in
            guard let wSelf = self else { return }
            
            //  When the text is updated, we want to adjust the frame to fit in the parent
            wSelf.adjustLabelFrame(with: newString, label: &wSelf.titleLabel)
            
            //  Check to see if the image view exists. If it does, adjust the frame
            if var imageViewFound = wSelf.imageView {
                wSelf.adjustImageViewFrame(imgView: &imageViewFound, fromLabel: &wSelf.titleLabel)
            }
            }, onError: { (error) in
                print("Error Found in Title Text Update: \(error)")
        }, onCompleted: nil,
           onDisposed: nil)
            .disposed(by: _bag)
        
        //  Listen for color changes to the text color and listen accordingly
        //  We may use anonymous objects to make our lives easier, and to reduce the code amount
        titleColor
            .subscribe(onNext: { [weak self] in self?.titleLabel.textColor = $0 })
            .disposed(by: _bag)
        
        addSubview(titleLabel)
        return self
    }
    
    /// Adds the image view to the view. Note that it may or may not contain an image
    ///
    /// - Returns: Self
    private func addImageView() -> Self {
        if headerImageView != nil { return self }
        let startingY: CGFloat = iPhoneXOffset(side: .top) + offset
        let height: CGFloat = titleLabel.frame.minY - startingY - offset
        headerImageView = UIImageView(
            frame: CGRect(
                x: bounds.midX - height/2,
                y: startingY,
                width: height,
                height: height
            )
        )
        headerImageView.contentMode = .scaleAspectFit
        addSubview(headerImageView)
        
        //  Listen for image changes
        image
            .subscribe(onNext: { [weak self] in self?.headerImageView.image = $0 })
            .disposed(by: _bag)
        
        return self
    }
    
    /// Set up the observable to ajust the background color when the color changes. Not that this actually happens whn the value is changed already.
    /// This is just an example of how to run a simple animation (UI Updates must be on the main thread)
    private func adjustBackground() {
        color.subscribe(onNext: { (newBackgroundColor) in
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.backgroundColor = newBackgroundColor
            })
        }).disposed(by: _bag)
    }
    
}

// MARK: - Observable actions
extension HeaderView {
    
    /// Set the text in the label and ajust the frame to fit accordingly
    ///
    /// - Parameter newString: The String we are adding to the view
    private func adjustLabelFrame(with newString: String, label: inout UILabel) {
        let initalFrameWidth = label.frame.width
        label.text = newString
        label.sizeToFit()
        label.frame.size.width = initalFrameWidth
        label.frame.origin.y = frame.height - offset - label.frame.height
    }
    
    /// Adjust the image view frame to the new origin of the label every time the label is adjusted
    ///
    /// - Parameter imgView: The image view we are modifying the size for.
    private func adjustImageViewFrame(imgView: inout UIImageView, fromLabel lbl: inout UILabel) {
        imgView.frame.size.height = lbl.frame.minY - imgView.frame.minY - offset
    }
    
}
