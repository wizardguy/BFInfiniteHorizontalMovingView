//
//  BFInfiniteHorizontalMovingView.swift
//  animationTest
//
//  Created by Dennis on 25/3/2018.
//  Copyright © 2018 Dennis. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol BFInfiniteHorizontalMovingViewDelegate {
    @objc optional func didTapped(view: BFInfiniteHorizontalMovingView)
}


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
    public var delegate: BFInfiniteHorizontalMovingViewDelegate?
   
    fileprivate var backgroundImageView1: UIView!
    fileprivate var backgroundImageView2: UIView!
    
    private var backupBackgroundColor: UIColor!
    
    static public func newInstance(patternImage: UIImage, frame: CGRect, backColor: UIColor? = UIColor.clear) -> BFInfiniteHorizontalMovingView {
        let newView = BFInfiniteHorizontalMovingView(frame: frame)
        newView.backgroundPatternImage = patternImage
        newView.backgroundColor = backColor
        newView.backupBackgroundColor = backColor
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
        
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(viewDidTapped(gesture:)))
        tap.minimumPressDuration = 0.1
        self.addGestureRecognizer(tap)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    @objc
    private func viewDidTapped(gesture: UITapGestureRecognizer) {
        if gesture.state == .began {
            self.backgroundColor = backupBackgroundColor.lighter()
        }
        else if gesture.state == .ended {
            self.backgroundColor = backupBackgroundColor
            delegate?.didTapped?(view: self)
        }
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


extension UIColor {
    
    func lighter(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
}
