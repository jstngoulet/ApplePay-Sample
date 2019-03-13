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
    private var titleLabel: UILabel!
    
    //  Attributes
    var titleText: BehaviorRelay<String> = BehaviorRelay(value: "")
    var titleColor: BehaviorRelay<UIColor> = BehaviorRelay(value: UIColor.white)
    var color: BehaviorRelay<UIColor> = BehaviorRelay(value: UIColor.clear)
    
    //  Dispose bag, reposponible for alerting the observable to stop emitting events
    private var _bag = DisposeBag()
    
    convenience init(withTitle title: String, frame: CGRect? = nil) {
        let screenBounds = UIScreen.main.bounds
        self.init(frame: frame ?? CGRect(origin: .zero, size: CGSize(width: screenBounds.width, height: screenBounds.height/2.5)))
        self.titleText.accept(title)
        build()
    }
    
}

// MARK: - Design (Construct the view)
extension HeaderView {
    
    /// Construct the UI ELements on the view
    private func build() {
        addTitleLabel()
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
    
}
