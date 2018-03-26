//
//  ViewController.swift
//  BFInfiniteHorizontalMovingView
//
//  Created by Dennis on 25/3/2018.
//  Copyright © 2018 Dennis. All rights reserved.
//

//
//  ViewController.swift
//  BFInfiniteHorizontalMovingViewDemo
//
//  Created by Dennis on 5/8/2017.
//  Copyright © 2017 Dennis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BFInfiniteHorizontalMovingViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bar: BFInfiniteHorizontalMovingView!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressButton: BFProgressButton!
    
    var secondView: BFInfiniteHorizontalMovingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if secondView == nil {
            secondView = BFInfiniteHorizontalMovingView.newInstance(patternImage: UIImage(named: "background")!, frame: containerView.bounds, backColor: #colorLiteral(red: 0, green: 0.7058823529, blue: 1, alpha: 1))
            secondView.delegate = self
            containerView.addSubview(secondView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        if progressButton.progressState == .stopped {
            progressButton.startMoving()
        }
        else {
            progressButton.stopMoving()
        }
    }
    
    @IBAction func switchChaged(_ sender: Any) {
        if switcher.isOn {
            bar.startMoving()
            secondView.startMoving()
        }
        else {
            bar.stopMoving()
            secondView.stopMoving()
        }
    }
}

extension ViewController {
    func didTapped(view: BFInfiniteHorizontalMovingView) {
        label.text = "View did Tapped!"
    }
}
