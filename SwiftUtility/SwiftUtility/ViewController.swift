//
//  ViewController.swift
//  SwiftUtility
//
//  Created by tangbowen on 2020/5/8.
//  Copyright © 2020 tangbowen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = tkRandowColor()
        self.view.tt.addTapGesture(self, action: #selector(abcd))
    }
    
    @objc func abcd(){
            
    }
}

