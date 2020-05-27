//
//  TestViewController.swift
//  SwiftUtility
//
//  Created by tangbowen on 2020/5/25.
//  Copyright © 2020 tangbowen. All rights reserved.
//

import UIKit
import WebKit
class TestViewController: UIViewController {

    @IBOutlet weak var textVi: UITextView!
    @IBOutlet weak var bt: UIButton!
    var attribute:NSMutableAttributedString{
        if textVi.attributedText.length>0 {
            return NSMutableAttributedString(attributedString: textVi.attributedText)
        } else{
            return NSMutableAttributedString(string: textVi.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func transform(_ sender: Any) {
        
        let attribute = self.attribute;
        let data = try? attribute.data(from: NSRange(location: 0, length: attribute.length), documentAttributes: [.documentType:NSAttributedString.DocumentType.html])
        if let data = data {
            let aa = String(data: data, encoding: .utf8)!
            print("aa:" + aa)
            
        }
    }
    @IBAction func changFont(_ sender: Any) {
        if self.textVi.selectedRange.length > 0 {
            
            let attribute = NSMutableAttributedString(string: textVi.text);
            attribute.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)], range: self.textVi.selectedRange)
            self.textVi.attributedText = attribute
            
        }
    }
    
    @IBAction func imsetImage(_ sender: Any) {
        
        let attribute = self.attribute
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "icon")
        attachment.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        let imageString = NSAttributedString(attachment: attachment)
//        attribute.insert(imageString, at: attribute.length-1)
        attribute.append(imageString)
        self.textVi.attributedText = attribute
    }
    
    func testaaa( closure: voidClosure) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
