//
//  TTUtility.swift
//  SwiftDemo
//
//  Created by tangbowen on 2020/4/29.
//  Copyright © 2020 tangbowen. All rights reserved.
//

import UIKit

func DLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n>>> \(Date())  \(fileName) (line: \(lineNum)): \(message)\n")
    #endif
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension NSObject: TTNamespaceWrappable{}
extension TTTypeWrapperProtocol where WrappedType: NSObject{
    
    func className() -> String{
        let cls =  type(of: wrappedValue)
        return NSStringFromClass(cls)
    }
    
}

extension TTTypeWrapperProtocol where WrappedType: UIView {
    var x: CGFloat {
        get {
            wrappedValue.frame.origin.x
        }
    }
    func setupX(_ newValue:CGFloat) {
        var frame = wrappedValue.frame;
        frame.origin.x = newValue
        wrappedValue.frame = frame
    }
    
    var y: CGFloat{
        set {
            var frame = wrappedValue.frame;
            frame.origin.y = newValue
            wrappedValue.frame = frame
        }
        get {
            wrappedValue.frame.origin.y
        }
    }
    
    var width: CGFloat {
        set {
            var frame = wrappedValue.frame;
            frame.size.width = newValue
            wrappedValue.frame = frame
        }
        get {
            wrappedValue.frame.width
        }
    }
    
    var height: CGFloat {
        set {
            var frame = wrappedValue.frame;
            frame.size.height = newValue
            wrappedValue.frame = frame
        }
        get {
            wrappedValue.frame.height
        }
    }
    
    var left: CGFloat {
        set {
            var frame = wrappedValue.frame;
            frame.origin.x = newValue
            wrappedValue.frame = frame
        }
        get {
            wrappedValue.frame.origin.x
        }
    }
    
    var right: CGFloat{
        set {
            var frame = wrappedValue.frame;
            frame.origin.x = newValue-frame.width
            wrappedValue.frame = frame
        }
        get {
            wrappedValue.frame.maxX
        }
    }
    
    var top:CGFloat {
        set {
            var frame = wrappedValue.frame;
            frame.origin.y = newValue
            wrappedValue.frame = frame
        }
        get {
            wrappedValue.frame.origin.y
        }
    }
    
    var bottom: CGFloat {
        set {
            var frame = wrappedValue.frame;
            frame.origin.y = newValue + frame.height
            wrappedValue.frame = frame
        }
        get {
            wrappedValue.frame.maxY
        }
    }
     /// 设置圆角
    func setupConnerRadius(_ radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 0) {
        wrappedValue.layer.masksToBounds = true
        wrappedValue.layer.cornerRadius = radius
        wrappedValue.layer.borderWidth = borderWidth
        wrappedValue.layer.borderColor = borderColor?.cgColor
    }
//    ///添加手势     `@discardableResult` 用来告知编辑器结果外部可以不用接收, 否则编辑器会报黄
//    @discardableResult
//    func addGesture(_ target:Any?,  action: Selector, cls: AnyClass) -> UIGestureRecognizer? {
//
//        guard cls.isSubclass(of: UIGestureRecognizer.Type) else {
//            return nil;
//        }
//        wrappedValue.isUserInteractionEnabled = true
//        return nil
//    }
}

extension TTTypeWrapperProtocol where WrappedType: UICollectionViewCell {
    
    var cellIdentifer: String {
        let cellId = wrappedValue.tt.className()
        return cellId + "ID"
    }
    
}

class TTUtility: NSObject {

    
}

 ///命名空间部分
public protocol TTNamespaceWrappable {
    associatedtype WrapperType
    var tt: WrapperType { get }
    static var tt: WrapperType.Type { get }
}

public extension TTNamespaceWrappable {
    var tt: TTNamespaceWrapper<Self> {
        return TTNamespaceWrapper(value: self)
    }

    static var tt: TTNamespaceWrapper<Self>.Type {
        return TTNamespaceWrapper.self
    }
}

public protocol TTTypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

public struct TTNamespaceWrapper<T>: TTTypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

