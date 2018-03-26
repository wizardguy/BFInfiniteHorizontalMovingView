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
    
    var secondView: BFInfiniteHorizontalMovingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        secondView = BFInfiniteHorizontalMovingView.newInstance(patternImage: UIImage(named: "1.jpg")!, frame: containerView.bounds)
        secondView.delegate = self
        containerView.addSubview(secondView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
