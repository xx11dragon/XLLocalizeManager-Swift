//
//  UIButton+Localizable.swift
//  XLLanguageManagerExample
//
//  Created by xx11dragon on 2019/7/2.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import UIKit

/***
 多状态存取关联值 由于String为值类型 暂时无法封装成根据状态取值的函数
 ***/
extension UIButton {
    
    struct AssociatedKey {
        
        /// button title normal state localizable key
        static var titleNormalLocalizeKey = "titleNormalLocalizeKey"
        
        /// button title selected state localizable key
        static var titleSelectedLocalizeKey = "titleSelectedLocalizeKey"
        
        /// button title highlighted state localizable key
        static var titleHighlightedLocalizeKey = "titleHighlightedLocalizeKey"
        
        /// button title disable state localizable key
        static var titleDisabledLocalizeKey = "titleDisabledLocalizeKey"
    }
    
    /// 本地化key normal 状态
    private var xl_titleNormalLocalize: String? {
        
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKey.titleNormalLocalizeKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.titleNormalLocalizeKey) as? String
        }
    }
    
    /// 本地化key selected 状态
    private var xl_titleSelectedLocalize: String? {
        
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKey.titleSelectedLocalizeKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.titleSelectedLocalizeKey) as? String
        }
    }
    
    /// 本地化key highlighted 状态
    private var xl_titleHighlightedLocalize: String? {
        
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKey.titleHighlightedLocalizeKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.titleHighlightedLocalizeKey) as? String
        }
    }
    
    /// 本地化key disable 状态
    private var xl_titleDisabledLocalize: String? {
        
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKey.titleDisabledLocalizeKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.titleDisabledLocalizeKey) as? String
        }
    }

    /// 根据状态获取key
    ///
    /// - Parameters:
    ///   - state: 状态
    /// - Returns: key
    private func xl_associatedKey(state: UIControl.State) -> String? {
        
        switch state {
        case .normal:
            return xl_titleNormalLocalize
        case .selected:
            return xl_titleSelectedLocalize
        case .highlighted:
            return xl_titleHighlightedLocalize
        case .disabled:
            return xl_titleDisabledLocalize
        default:
            return nil
        }
    }
    
    /// 根据状态设置key
    ///
    /// - Parameters:
    ///   - key: 需要存的key
    ///   - state: 状态
    private func xl_setAssociatedKey(key: String, state: UIControl.State) {
        
        switch state {
        case .normal:
            xl_titleNormalLocalize = key
        case .selected:
            xl_titleSelectedLocalize = key
        case .highlighted:
            xl_titleHighlightedLocalize = key
        case .disabled:
            xl_titleDisabledLocalize = key
        default:
            break
        }
    }
}

extension UIButton {
    
    /// 设置标题本地化key 根据状态
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - state: 状态
    public func xl_setTitleLocalize(key: String?, state: UIControl.State) {
        
        guard let newValue = key else {
            return
        }
        setTitle(XLLString(newValue), for: state)
        xl_setAssociatedKey(key: newValue, state: state)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changedLanguage),
                                               name: XLLocalizeManager.Config.changedLanguageNotification,
                                               object: nil)
    }

    /// 切换语言
    @objc private func changedLanguage() {
        
        DispatchQueue.main.async {
            
            self.titleChangeLanguage()
        }
    }
    
    /// title 切换语言
    private func titleChangeLanguage() {
        
        if let key = xl_titleNormalLocalize {
            setTitle(XLLString(key), for: .normal)
        }
        if let key = xl_titleSelectedLocalize {
            setTitle(XLLString(key), for: .selected)
        }
        if let key = xl_titleHighlightedLocalize {
            setTitle(XLLString(key), for: .highlighted)
        }
        if let key = xl_titleDisabledLocalize {
            setTitle(XLLString(key), for: .disabled)
        }
    }
}
