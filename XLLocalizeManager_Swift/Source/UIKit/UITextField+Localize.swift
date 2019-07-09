//
//  UITextField+Localizable.swift
//  XLLanguageManagerExample
//
//  Created by xx11dragon on 2019/7/2.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import UIKit

extension UITextField {
    struct AssociatedKey {
        
        /// text field text localizable key
        static var textLocalizableKeyKey = "textLocalizableKeyKey"
        
        /// text field placeholder localizable key
        static var placeholderLocalizableKeyKey = "placeholderLocalizableKeyKey"
    }

    /// text 本地化语言key
    public var xl_textLocalize: String? {
        
        set {
            
            guard let newValue = newValue else {
                return
            }
            text = XLLString(newValue)
            objc_setAssociatedObject(self,
                                     &AssociatedKey.textLocalizableKeyKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(changedLanguage),
                                                   name: XLLocalizeManager.Config.changedLanguageNotification,
                                                   object: nil)
        }
        
        get {
            
            return objc_getAssociatedObject(self,
                                            &AssociatedKey.textLocalizableKeyKey) as? String
        }
    }
    
    /// placehold 本地化语言key
    public var xl_placeholderLocalize: String? {
        
        set {
            
            guard let newValue = newValue else {
                return
            }
            placeholder = XLLString(newValue)
            objc_setAssociatedObject(self,
                                     &AssociatedKey.placeholderLocalizableKeyKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(changedLanguage),
                                                   name: XLLocalizeManager.Config.changedLanguageNotification,
                                                   object: nil)
        }
        
        get {
            
            return objc_getAssociatedObject(self,
                                            &AssociatedKey.placeholderLocalizableKeyKey) as? String
        }
    }
    
    /// 切换语言
    @objc private func changedLanguage() {
        
        DispatchQueue.main.async {
            
            self.textChangedLanguage()
            self.placeholderChangedLanguage()
        }
    }
    
    private func textChangedLanguage() {
        
        guard let textLocalizableKey = self.xl_textLocalize else {
            return
        }
        self.text = XLLString(textLocalizableKey)
    }
    
    private func placeholderChangedLanguage() {
        
        guard let textLocalizableKey = self.xl_placeholderLocalize else {
            return
        }
        placeholder = XLLString(textLocalizableKey)
    }
}
