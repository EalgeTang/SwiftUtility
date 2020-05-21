//
//  ViewController.swift
//  SwiftUtility
//
//  Created by tangbowen on 2020/5/8.
//  Copyright © 2020 tangbowen. All rights reserved.
//

import UIKit
typealias block = ()-> Bool
class ViewController: UIViewController {

    lazy var arr: [String] =  {
        let array = ["1", "2"]
        return array
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.tt.addTapGesture(self, action: #selector(abcd))
        view.backgroundColor = .red
        let aa = makeIncrementer(forIncrement: 10)
        let value1 = aa()
        print("value is \(value1)")
        let value2 = aa()
        print("value is \(value2)")
        let value3 = aa()
        print("value is \(value3)")
        let value4 = aa()
        print("value is \(value4)")
        
        DLog("array is \(arr)")
        
    }
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int{
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    @objc func abcd(block:block){
            
    }
}

