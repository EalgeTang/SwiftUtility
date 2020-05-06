//
//  TTUtility.swift
//  SwiftDemo
//
//  Created by tangbowen on 2020/4/29.
//  Copyright © 2020 tangbowen. All rights reserved.
//

import UIKit

let tkDevice_Width = UIScreen.main.bounds.width
let tkDevice_Height = UIScreen.main.bounds.height

public func DLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n>>> \(Date())  \(fileName) (line: \(lineNum)): \(message)\n")
    #endif
}

func tkColor(hex: String, alpha: CGFloat = 1) -> UIColor {
    return UIColor(hex: hex, alpha: alpha)
}

func tkColor(r:CGFloat, g:CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
    return UIColor(r, g: g, b: b, alpha: alpha)
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
    
    convenience init(_ r: CGFloat, g: CGFloat, b: CGFloat, alpha:CGFloat = 1) {
        self.init(red: r / 255.0, green: g/255.0, blue:b/255.0, alpha: alpha)
    }
}

extension NSObject: TTNamespaceWrappable{}
extension TTTypeWrapperProtocol where WrappedType: NSObject{
    
    func className() -> String{
        let cls = type(of: wrappedValue)
        return NSStringFromClass(cls)
    }
    
}

extension TTTypeWrapperProtocol where WrappedType: UIView {
    var x: CGFloat {
        get {
            wrappedValue.frame.origin.x
        }
    }
    
//    @discardableResult
//    func setupX(_ newValue:CGFloat) ->WrappedType {
//        var frame = wrappedValue.frame;
//        frame.origin.x = newValue
//        wrappedValue.frame = frame
//        return wrappedValue
//    }
    
    var y: CGFloat{
        get {
            wrappedValue.frame.origin.y
        }
    }
    
//    @discardableResult
//    func setupY(_ newValue:CGFloat) ->WrappedType  {
//        var frame = wrappedValue.frame;
//        frame.origin.y = newValue
//        wrappedValue.frame = frame
//        return wrappedValue
//    }
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
//    func addGesture(_ target:Any?,  action: Selector, cls: UIGestureRecognizer.Type) -> UIGestureRecognizer? {
//
//        wrappedValue.isUserInteractionEnabled = true
//        let ges = UIGestureRecognizer(target: target, action: action)
//
//        wrappedValue.addGestureRecognizer(ges)
//        return ges
//    }
}

extension UIButton {
    enum DistributionStyle:Int {
        case imageTop = 0
        case imageLeft = 1
    }
}

extension TTTypeWrapperProtocol where WrappedType: UIButton {
    
    func setImageNamed(_ imageName: String, state: UIButton.State = .normal) {
        let image = UIImage(named: imageName)
        wrappedValue.setImage(image, for: state)
    }
    
    func setNormalImageNamed(_ imageName: String) {
        self.setImageNamed(imageName, state: .normal)
    }
    
    func setSelectedImageNamed(_ imageName: String) {
        self.setImageNamed(imageName, state: .selected)
    }
}

extension TTTypeWrapperProtocol where WrappedType: UIImage {
    
     func resizableImageForStretch() -> UIImage {
        let hor = wrappedValue.size.width * 0.5 - 1
        let ver = wrappedValue.size.height * 0.5 - 1
        return wrappedValue .resizableImage(withCapInsets: UIEdgeInsets(top: ver, left: hor, bottom: ver, right: hor),
                                            resizingMode: .stretch)
        
    }
}

extension TTTypeWrapperProtocol where WrappedType: UITableView {
    
    func register(nibCellClass cls: AnyClass, identifier: String? = nil) {
        let nibName = NSStringFromClass(cls)
        let reid = identifier  == nil ? nibName + "ID" : identifier!
        wrappedValue.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reid)
    }
}

extension TTTypeWrapperProtocol where WrappedType: UICollectionView {
    
    func register(nibCellClass nibClass: AnyClass, identifier: String? = nil) {
        let nibName = NSStringFromClass(nibClass)
        var reid:String
        if identifier == nil {
            reid = nibName + "ID"
        } else {
            reid = identifier!
        }
        wrappedValue.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: reid)
    }
    
    func register(supplementaryClass nibClass: AnyClass, isHeader: Bool = true, identifier: String? = nil) {
        let nibName = NSStringFromClass(nibClass)
        let kind = isHeader ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter
        let reid = identifier == nil ? nibName + "ID" : identifier!
        wrappedValue.register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: reid)
    }
}

extension TTTypeWrapperProtocol where WrappedType: UICollectionViewCell {
    
    var cellIdentifer: String {
        let cellId = wrappedValue.tt.className()
        return cellId + "ID"
    }
    
}

class TTUtility: NSObject {
    // 获取命名空间
    func spaceName() -> String? {
        guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return nil
        }
        return spaceName
    }
}

 ///命名空间部分
public protocol TTNamespaceWrappable {
    associatedtype WrapperType
    var tt: WrapperType { get }
//    static var tt: WrapperType.Type { get }
}

public extension TTNamespaceWrappable {
    var tt: TTNamespaceWrapper<Self> {
        return TTNamespaceWrapper(value: self)
    }

//    static var tt: TTNamespaceWrapper<Self>.Type {
//        return TTNamespaceWrapper.self
//    }
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

