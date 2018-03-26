//
//  BFProgressButton.swift
//  BFInfiniteHorizontalMovingView
//
//  Created by Dennis on 2018/3/26.
//  Copyright © 2018年 Dennis. All rights reserved.
//

import Foundation
import UIKit

enum BFProgressState {
    case moving
    case stopped
}

enum BFProgressDirection {
    case left
    case right
}


@IBDesignable
class BFProgressButton: UIButton {
    
    @IBInspectable
    public var backgroundPatternImage:UIImage? {
        didSet {
            guard let img = backgroundPatternImage else {
                return
            }
            #if !TARGET_INTERFACE_BUILDER
                backgroundImageView1.backgroundColor = UIColor(patternImage: img)
                backgroundImageView2.backgroundColor = UIColor(patternImage: img)
            #else
                self.backgroundColor = UIColor(patternImage: img)
            #endif
        }
    }
    
    public var movingSpeed: TimeInterval = 4.0
    public var progressState: BFProgressState {
        get {
            return _progressState
        }
    }
    public var direction: BFProgressDirection = .right
    
    fileprivate var _progressState: BFProgressState = .stopped
    fileprivate var backgroundImageView1: UIView!
    fileprivate var backgroundImageView2: UIView!
    
    static public func newInstance(patternImage: UIImage, frame: CGRect) -> BFProgressButton {
        let newButton = BFProgressButton(frame: frame)
        newButton.backgroundPatternImage = patternImage
        return newButton
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func adjustSubViewsPosition() {
        backgroundImageView1.frame = self.bounds
        if direction == .left {
            backgroundImageView2.frame = CGRect(x:self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.height)
        }
        else {
            backgroundImageView2.frame = CGRect(x:-self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.height)
        }
    }
    
    fileprivate func showMovingViews(_ show:Bool) {
        backgroundImageView1.isHidden = !show
        backgroundImageView2.isHidden = !show
    }
    
    
    private func setup() {
        // UIImageView 1
        backgroundImageView1 = UIView()
        backgroundImageView1.isUserInteractionEnabled = false
        self.addSubview(backgroundImageView1!)
        
        // UIImageView 2
        backgroundImageView2 = UIView()
        backgroundImageView2.isUserInteractionEnabled = false
        self.addSubview(backgroundImageView2!)
        
        adjustSubViewsPosition()
        self.clipsToBounds = true
        
        showMovingViews(false)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}


extension BFProgressButton {
    func startMoving() {
        _progressState = .moving
        showMovingViews(true)
        let animationOptions = UIViewAnimationOptions.repeat.rawValue | UIViewAnimationOptions.curveLinear.rawValue
        // Animate background
        UIView.animate(withDuration: movingSpeed, delay: 0.0, options: UIViewAnimationOptions(rawValue: animationOptions), animations: {
            if self.direction == .left {
                self.backgroundImageView1.frame = self.backgroundImageView1.frame.offsetBy(dx: -self.backgroundImageView1.frame.size.width, dy: 0)
                self.backgroundImageView2.frame = self.backgroundImageView2.frame.offsetBy(dx: -self.backgroundImageView2.frame.size.width, dy: 0)
            }
            else {
                self.backgroundImageView1.frame = self.backgroundImageView1.frame.offsetBy(dx: self.backgroundImageView1.frame.size.width, dy: 0)
                self.backgroundImageView2.frame = self.backgroundImageView2.frame.offsetBy(dx: self.backgroundImageView2.frame.size.width, dy: 0)
            }
        })
    }
    
    func stopMoving() {
        _progressState = .stopped
        backgroundImageView1.layer.removeAllAnimations()
        backgroundImageView2.layer.removeAllAnimations()
        adjustSubViewsPosition()
        showMovingViews(false)
    }
}

