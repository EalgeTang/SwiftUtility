//
//  ViewController.swift
//  SwiftUtility
//
//  Created by tangbowen on 2020/4/30.
//  Copyright © 2020 tangbowen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vi = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        self.view.addSubview(vi)
        vi.backgroundColor = .red
        vi.frame.origin.x = 0
        vi.tt.setupX(10)
    }
    
    static func test2() {
        //
    }
    @objc func test() {
        
    }
}

