//
//  BFInfiniteHorizontalMovingView.swift
//  animationTest
//
//  Created by Dennis on 25/3/2018.
//  Copyright © 2018 Dennis. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class BFInfiniteHorizontalMovingView: UIView {
    
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
    
    fileprivate var backgroundImageView1: UIView!
    fileprivate var backgroundImageView2: UIView!
    
    
    static public func newInstance(patternImage: UIImage, frame: CGRect) -> BFInfiniteHorizontalMovingView {
        let newView = BFInfiniteHorizontalMovingView(frame: frame)
        newView.backgroundPatternImage = patternImage
        return newView
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func adjustSubviewsPosition() {
        backgroundImageView1.frame = self.bounds
        backgroundImageView2.frame = CGRect(x:self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.height)
    }
    
    private func setup() {
        // UIImageView 1
        backgroundImageView1 = UIView()
        self.addSubview(backgroundImageView1!)
        
        // UIImageView 2
        backgroundImageView2 = UIView()
        self.addSubview(backgroundImageView2!)
        
        adjustSubviewsPosition()
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}


extension BFInfiniteHorizontalMovingView {
    func startMoving() {
        let animationOptions = UIViewAnimationOptions.repeat.rawValue | UIViewAnimationOptions.curveLinear.rawValue
        // Animate background
        UIView.animate(withDuration: movingSpeed, delay: 0.0, options: UIViewAnimationOptions(rawValue: animationOptions), animations: {
            self.backgroundImageView1.frame = self.backgroundImageView1.frame.offsetBy(dx: -1 * self.backgroundImageView1.frame.size.width, dy: 0)
            self.backgroundImageView2.frame = self.backgroundImageView2.frame.offsetBy(dx: -1 * self.backgroundImageView2.frame.size.width, dy: 0)
        })
    }
    
    func stopMoving() {
        backgroundImageView1.layer.removeAllAnimations()
        backgroundImageView2.layer.removeAllAnimations()
        adjustSubviewsPosition()
    }
}
