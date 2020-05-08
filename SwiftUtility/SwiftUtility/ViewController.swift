//
//  ViewController.swift
//  SwiftUtility
//
//  Created by eagle on 2020/5/3.
//  Copyright © 2020 eagle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var vi: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vi = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        self.view.addSubview(vi)
        vi.backgroundColor = UIColor(230, g: 120, b: 137)
        vi.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        vi.addGestureRecognizer(tap)
        for index in 1..<5 {
            DLog("index is \(index)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @objc func tapAction() {
        self.vi?.tt.shake()
    }
    @objc func test() {
        
    }
}

