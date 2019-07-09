//
//  UILabel+Localizable.swift
//  Exchange
//
//  Created by xx11dragon on 2019/6/28.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import UIKit
import Foundation

extension UILabel {
    
    struct AssociatedKey {
        
        /// label text localizable key
        static var textLocalizableKeyKey = "textLocalizableKeyKey"
    }
    
    /// 本地化语言key
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
    
    /// 切换语言
    @objc private func changedLanguage() {

        DispatchQueue.main.async {
            
            self.textChangedLanguage()
        }
    }
    
    /// title 切换语言
    private func textChangedLanguage() {
        
        guard let textLocalizableKey = self.xl_textLocalize else {
            return
        }
        self.text = XLLString(textLocalizableKey)
    }
}
