//
//  TTUtility.swift
//  SwiftDemo
//
//  Created by tangbowen on 2020/4/29.
//  Copyright © 2020 tangbowen. All rights reserved.
//

import UIKit
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

extension UIView: TTNamespaceWrappable {}
extension TTTypeWrapperProtocol where WrappedType == UIView {
     /// 设置圆角
    func setupConnerRadius(_ radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 0) {
        wrappedValue.layer.masksToBounds = true
        wrappedValue.layer.cornerRadius = radius
        wrappedValue.layer.borderWidth = borderWidth
        wrappedValue.layer.borderColor = borderColor?.cgColor
    }
}

extension Array: TTNamespaceWrappable{}

class TTUtility: NSObject {

    
}
