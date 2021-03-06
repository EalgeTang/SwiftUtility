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

typealias voidClosure = () ->Void
typealias optionVoidClosure = (()->Void)?

public func DLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n>>> \(Date())  \(fileName) (line: \(lineNum)): \(message)\n")
    #endif
}

public func tkPostNotification(name: NSNotification.Name, obj:Any? = nil) {
    NotificationCenter.default.post(name: name, object: obj)
}

public func tkAddNotification(observer: Any, selector:Selector,name: NSNotification.Name,obj: Any? = nil) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: obj)
}

public func tkRemoveNotification(observer: Any){
    NotificationCenter.default.removeObserver(observer)
}

public func tkStatusBarHeight() -> CGFloat {
    if #available(iOS 13, *) {
        let window = tkCurrentWindow()
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    } else {
        return UIApplication.shared.statusBarFrame.size.height
    }
}

public func tkDispatch_safe_main_queue(_ closure: @escaping ()->Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async {
         closure()
        }
    }
}
func tkRandowColor() -> UIColor {
    let rValue = arc4random() % 255
    let gValue = arc4random() % 255
    let bValue = arc4random() % 255
    return UIColor(red: CGFloat(rValue)/255.0, green: CGFloat(gValue)/255.0, blue: CGFloat(bValue)/255.0, alpha: 1)
}

public func tkColor(hex: String, alpha: CGFloat = 1) -> UIColor {
    return UIColor(hex: hex, alpha: alpha)
}

public func tkColor(r:CGFloat, g:CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
    return UIColor(r, g: g, b: b, alpha: alpha)
}

func tkDoucumentPath() -> String {
    let string = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    return string
}

func tkCachePath() -> String {
    let string = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
    return string
}

func tkCachePathAppend(_ string: String) -> String {
    let home = tkCachePath() as NSString
    let path = home.appendingPathComponent(string)
    return path
}

func tkDoucumentPathAppend(_ string: String) -> String {
    let home = tkDoucumentPath() as NSString
    let path = home.appendingPathComponent(string)
    return path
}

/// 获取当前VC, 不支持多窗口, 如果实现了SceneDelegate 则无法使用此方法查找, rootViewController的获取不同
func tkCurrentViewController() -> UIViewController? {
    var vc = tkCurrentWindow()?.rootViewController
    while true {
        if let tab = vc as? UITabBarController {
            vc = tab.selectedViewController
        }
        if let nav = vc as? UINavigationController {
            vc = nav.visibleViewController
        }
        if let present = vc?.presentedViewController {
            vc = present
        } else {
            break
        }
    }
    return vc
}

func tkCurrentWindow() -> UIWindow? {
    UIApplication.shared.delegate?.window ?? nil
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
extension TTTypeWrapperProtocol where WrappedType: NSLayoutConstraint {
    
    func add(_ x: CGFloat) {
        wrappedValue.constant += x
    }
    
    func mutiply(_ x: CGFloat) {
        wrappedValue.constant = wrappedValue.constant * x
    }
    
}

extension TTTypeWrapperProtocol where WrappedType: UIView {
//    var x: CGFloat {
//        get {
//            wrappedValue.frame.origin.x
//        }
//    }
    
//    @discardableResult
//    func setupX(_ newValue:CGFloat) ->WrappedType {
//        var frame = wrappedValue.frame;
//        frame.origin.x = newValue
//        wrappedValue.frame = frame
//        return wrappedValue
//    }
    
//    var y: CGFloat{
//        get {
//            wrappedValue.frame.origin.y
//        }
//    }
    
//    @discardableResult
//    func setupY(_ newValue:CGFloat) ->WrappedType  {
//        var frame = wrappedValue.frame;
//        frame.origin.y = newValue
//        wrappedValue.frame = frame
//        return wrappedValue
//    }
//    var width: CGFloat {
//        set {
//            var frame = wrappedValue.frame;
//            frame.size.width = newValue
//            wrappedValue.frame = frame
//        }
//        get {
//            wrappedValue.frame.width
//        }
//    }
//
//    var height: CGFloat {
//        set {
//            var frame = wrappedValue.frame;
//            frame.size.height = newValue
//            wrappedValue.frame = frame
//        }
//        get {
//            wrappedValue.frame.height
//        }
//    }
//
//    var left: CGFloat {
//        set {
//            var frame = wrappedValue.frame;
//            frame.origin.x = newValue
//            wrappedValue.frame = frame
//        }
//        get {
//            wrappedValue.frame.origin.x
//        }
//    }
//
//    var right: CGFloat{
//        set {
//            var frame = wrappedValue.frame;
//            frame.origin.x = newValue-frame.width
//            wrappedValue.frame = frame
//        }
//        get {
//            wrappedValue.frame.maxX
//        }
//    }
//
//    var top:CGFloat {
//        set {
//            var frame = wrappedValue.frame;
//            frame.origin.y = newValue
//            wrappedValue.frame = frame
//        }
//        get {
//            wrappedValue.frame.origin.y
//        }
//    }
//
//    var bottom: CGFloat {
//        set {
//            var frame = wrappedValue.frame;
//            frame.origin.y = newValue + frame.height
//            wrappedValue.frame = frame
//        }
//        get {
//            wrappedValue.frame.maxY
//        }
//    }
    
    func shake() {
        let keyAnimaiton = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let shakeWidth = 16.0
        keyAnimaiton.values = [-shakeWidth, 0, shakeWidth, 0, -shakeWidth, 0, shakeWidth, 0]
        keyAnimaiton.duration = 0.1
        keyAnimaiton.repeatCount = 2
        keyAnimaiton.isRemovedOnCompletion = true
        wrappedValue.layer.add(keyAnimaiton, forKey: "shake")
        
    }
     /// 设置圆角
    func setupConnerRadius(_ radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 0) {
        wrappedValue.layer.masksToBounds = true
        wrappedValue.layer.cornerRadius = radius
        wrappedValue.layer.borderWidth = borderWidth
        wrappedValue.layer.borderColor = borderColor?.cgColor
    }
    
    func screenShot(size: CGSize = CGSize.zero) -> UIImage? {
        var targetSize = size
        if size == CGSize.zero {
            targetSize = wrappedValue.frame.size
        }
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        wrappedValue.layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    /// 添加一个边缘拖动手势
    @discardableResult
    func addScreenEdgePanGesture(_ target: Any? = nil, action: Selector) -> UIScreenEdgePanGestureRecognizer {
        self.addGesture(target, action: action, cls: UIScreenEdgePanGestureRecognizer.self) as! UIScreenEdgePanGestureRecognizer
    }
    /// 添加一个长按手势
    @discardableResult
    func addLongPressGesture(_ target: Any? = nil, action: Selector) -> UILongPressGestureRecognizer {
        self.addGesture(target, action: action, cls: UILongPressGestureRecognizer.self) as! UILongPressGestureRecognizer
    }
    /// 添加一个捏合手势
    @discardableResult
    func addPinGesture(_ target: Any? = nil, action: Selector) -> UIPinchGestureRecognizer {
        self.addGesture(target, action: action, cls: UIPinchGestureRecognizer.self) as! UIPinchGestureRecognizer
    }
    /// 添加一个旋转手势
    @discardableResult
    func addRotationGesture(_ target: Any? = nil, action: Selector) -> UIRotationGestureRecognizer {
        self.addGesture(target, action: action, cls: UIRotationGestureRecognizer.self) as! UIRotationGestureRecognizer
    }
    /// 添加一个轻扫手势
    @discardableResult
    func addSwipeGesture(_ target: Any? = nil, action : Selector) -> UISwipeGestureRecognizer {
        self.addGesture(target, action: action, cls: UISwipeGestureRecognizer.self) as! UISwipeGestureRecognizer
    }
    /// 添加一个拖动手势
    @discardableResult
    func addPanGesture(_ target: Any? = nil, action: Selector) -> UIPanGestureRecognizer {
        self.addGesture(target, action: action, cls: UIPanGestureRecognizer.self) as! UIPanGestureRecognizer
    }
    /// 添加一个点击手势
    @discardableResult
    func addTapGesture(_ target: Any? = nil, action: Selector) -> UITapGestureRecognizer {
         self.addGesture(target, action: action, cls: UITapGestureRecognizer.self) as! UITapGestureRecognizer
    }
    
    ///添加手势     `@discardableResult` 用来告知编辑器结果外部可以不用接收, 否则编辑器会报黄
    @discardableResult
    func addGesture(_ target: Any? = nil,  action: Selector, cls: UIGestureRecognizer.Type) -> UIGestureRecognizer {
        var obj = target
        if target == nil {
            obj = wrappedValue
        }
        wrappedValue.isUserInteractionEnabled = true
        let ges = cls.init(target: obj, action: action)
        wrappedValue.addGestureRecognizer(ges)
        return ges
    }
}
// MARK: - UIButton
extension UIButton {
    enum DistributionStyle:Int {
        case imageTop = 0, imageLeft, imageBottom, imageRight
    }
    
    func layoutButton(distributionStyle: DistributionStyle, space: CGFloat) {
        
        let imageWidth = self.currentImage?.size.width ?? 0;
        let imageHeight = self.currentImage?.size.height ?? 0;
        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0;
        let labelHeight = self.titleLabel?.intrinsicContentSize.width ?? 0;
        
        var imageEdgeInsets = UIEdgeInsets()
        var labelEdgeInsets = UIEdgeInsets()
        switch distributionStyle {
        case .imageTop:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space/2.0, right: 0)
        case .imageLeft:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .imageBottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWidth, bottom: 0, right: 0)
        case .imageRight:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-space/2.0, bottom: 0, right: imageWidth+space/2.0)
            
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
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

extension TTTypeWrapperProtocol where WrappedType: UIButton {
    
    /// 以拉伸部分区域的形式去改变图片, isBackground默认值为true
    func updateImageForScretch(state: UIButton.State, isBackground: Bool = true) {
        var image = isBackground ? wrappedValue.backgroundImage(for: state) :wrappedValue.image(for: state)
        image = image?.tt.resizableImageForStretch()
        if isBackground {
            wrappedValue.setImage(image, for: state)
        } else {
            wrappedValue.setImage(image, for: state)
        }
    }
}
// MARK: - UIImage
extension TTTypeWrapperProtocol where WrappedType: UIImage {
    
     func resizableImageForStretch() -> UIImage {
        let hor = wrappedValue.size.width * 0.5 - 1
        let ver = wrappedValue.size.height * 0.5 - 1
        return wrappedValue .resizableImage(withCapInsets: UIEdgeInsets(top: ver, left: hor, bottom: ver, right: hor),
                                            resizingMode: .stretch)
        
    }
    
    /// 修改图片颜色
    func render(color:UIColor) -> UIImage? {
        guard let cgImage = wrappedValue.cgImage else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(wrappedValue.size, true, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let area = CGRect(x: 0, y: 0, width: wrappedValue.size.width, height: wrappedValue.size.height)
        ctx?.scaleBy(x: 1, y: -1)
        ctx?.translateBy(x: 0, y: -area.size.height)
        ctx?.saveGState()
        ctx?.clip(to: area, mask: cgImage)
        color.set()
        ctx?.fill(area)
        ctx?.restoreGState()
        ctx?.setBlendMode(.multiply)
        ctx?.draw(cgImage, in: area)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: - UITableView
extension TTTypeWrapperProtocol where WrappedType: UITableView {
    
    func register(nibCellClass cls: AnyClass, identifier: String? = nil) {
        let nibName = NSStringFromClass(cls)
        let reid = identifier  == nil ? nibName + "ID" : identifier!
        wrappedValue.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reid)
    }
}

// MARK: - UICollectionView
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

// MARK: - UICollectionViewCell
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

