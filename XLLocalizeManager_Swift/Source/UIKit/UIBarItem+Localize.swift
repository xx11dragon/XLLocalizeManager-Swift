//
//  UIBarItem+Localizable.swift
//  XLLocalizeManager
//
//  Created by xx11dragon on 2019/7/3.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import Foundation

extension UIBarItem {
    
    struct AssociatedKey {
        
        /// tabbar item title localizable key
        static var titleLocalizableKeyKey = "textLocalizableKeyKey"
    }
    
    /// title 本地化语言key
    public var xl_titleLocalize: String? {
        
        set {
            
            guard let newValue = newValue else {
                return
            }
            title = XLLString(newValue)
            objc_setAssociatedObject(self,
                                     &AssociatedKey.titleLocalizableKeyKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(changedLanguage),
                                                   name: XLLocalizeManager.Config.changedLanguageNotification,
                                                   object: nil)
        }
        
        get {
            
            return objc_getAssociatedObject(self,
                                            &AssociatedKey.titleLocalizableKeyKey) as? String
        }
    }
    
    /// 切换语言
    @objc private func changedLanguage() {
        
        DispatchQueue.main.async {
            
            self.titleChangeLanguage()
        }
    }
    
    /// title 切换语言
    private func titleChangeLanguage() {
        
        guard let localizableKey = self.xl_titleLocalize else {
            return
        }
        title = XLLString(localizableKey)
    }
}
