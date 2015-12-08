//
//  ViewController.swift
//  INSImageViewExample
//
//  Created by Patrick on 9/12/2015.
//  Copyright © 2015 instil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView = PBImageView(image: UIImage(named: "pineapple"))
    private let contentModeLabel = UILabel()
    private var contentModeIndex = 0;
    private let contentModes = [
        0: "UIViewContentModeScaleToFill",
        1: "UIViewContentModeScaleAspectFit",
        2: "UIViewContentModeScaleAspectFill",
        3: "UIViewContentModeRedraw",
        4: "UIViewContentModeCenter",
        5: "UIViewContentModeTop",
        6: "UIViewContentModeBottom",
        7: "UIViewContentModeLeft",
        8: "UIViewContentModeRight",
        9: "UIViewContentModeTopLeft",
        10: "UIViewContentModeTopRight",
        11: "UIViewContentModeBottomLeft",
        12: "UIViewContentModeBottomRight"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        // contentModeLabel
        contentModeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentModeLabel.textAlignment = .Center
        contentModeLabel.textColor = UIColor.init(white: 0.2, alpha: 1.0)
        contentModeLabel.backgroundColor = UIColor.init(white: 0.9, alpha: 0.4)
        view.addSubview(contentModeLabel)
        updateContentModeLabel()
        
        NSLayoutConstraint.activateConstraints([
            
            // imageView
            imageView.topAnchor     .constraintEqualToAnchor(view.topAnchor),
            imageView.leadingAnchor .constraintEqualToAnchor(view.leadingAnchor),
            imageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            imageView.bottomAnchor  .constraintEqualToAnchor(view.bottomAnchor),
            
            // contentModeLabel
            contentModeLabel.heightAnchor  .constraintEqualToConstant(60),
            contentModeLabel.leadingAnchor .constraintEqualToAnchor(view.leadingAnchor),
            contentModeLabel.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            contentModeLabel.bottomAnchor  .constraintEqualToAnchor(view.bottomAnchor),
            ])
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "animate", userInfo: nil, repeats: true)
    }
    
    @objc private func animate() {
        UIView.animateWithDuration(1,
            animations: {
                self.imageView.contentMode = self.nextContentMode()
            }
        )
    }
    
    private func nextContentMode() -> UIViewContentMode {
        
        contentModeIndex++;
        
        if contentModeIndex > 12 {
            contentModeIndex = 0;
        }
        
        updateContentModeLabel()
        
        return UIViewContentMode(rawValue: contentModeIndex)!
    }
    
    private func updateContentModeLabel() {
        contentModeLabel.text = contentModes[contentModeIndex]
    }
}
