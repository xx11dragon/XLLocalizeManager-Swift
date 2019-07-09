//
//  XLLocalizeManager.swift
//  XLLocalizeManager
//
//  Created by xx11dragon on 2019/7/2.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import Foundation

/// 本地化文案
///
/// - Parameter text: 语言KEY
/// - Returns: 本地化语言 如果获取不到直接返回key
public func XLLString(_ text: String) -> String {
    
    return XLLocalizeManager.string(text) ?? text
}

/// 重定义 LanguageManager.Language类名称
public typealias XLLanguage = XLLocalizeManager.Language

open class XLLocalizeManager {
    
    /// 保存当前语言
    private static var _currentLanguage: XLLanguage?

    /// 设置语言 获取语言
    public static var currentLanguage: XLLanguage {
        
        set {
            
            XLLocalizeManager._currentLanguage = newValue
            XLLocalizeManager.saveCurrentLanguage(newValue)
            NotificationCenter.default.post(name: XLLocalizeManager.Config.changedLanguageNotification,
                                            object: nil)
        }
        get {
            //  优先级 1.内存语言 2.本地语言 3.当前系统语言 4.默认语言
            return _currentLanguage ??
                XLLocalizeManager.getLanguageFromLocal() ??
                XLLocalizeManager.systemLanguage ??
                XLLocalizeManager.Config.defaultLanguage
        }
    }
    
    /// 获取本地化 String
    ///
    /// - Parameter key: 键
    /// - Returns: 本地化 String
    static func string(_ key: String) -> String? {

        return currentLanguage.bundle?.localizedString(forKey: key,
                                                       value: nil,
                                                       table: XLLocalizeManager.Config.stringFileName)
    }
}

// MARK: - 语言
public extension XLLocalizeManager {

    /// 通过id获取支持的语言
    ///
    /// - Parameter id: 语言id
    /// - Returns: 语言对象
    private static func getLanguage(id: String) -> XLLanguage? {
        
        var language: Language?
        for item in XLLocalizeManager.Config.availableLanguages {  //  获取APP支持的语言
            if id.contains(item.id) || id == item.id {
                language = item
                break
            }
        }
        return language
    }
}

// MARK: - 本地语言
public extension XLLocalizeManager {

    /// 存储语言
    ///
    /// - Parameter language: 语言
    private static func saveCurrentLanguage(_ language: XLLanguage) {
        
        saveToLocal(languageId: language.id)
    }
    
    /// 从本地取出语言
    private static func getLanguageFromLocal() -> XLLanguage? {
        
        guard let languageId = languageIDFormLocal() else {
            return nil
        }
        return XLLocalizeManager.getLanguage(id: languageId)
    }
    
    /// 存储语言id到沙盒
    ///
    /// - Parameter languageId: 语言id
    private static func saveToLocal(languageId: String) {
        
        let defaults = UserDefaults()
        defaults.setValue(languageId, forKey: XLLocalizeManager.Config.userDefualtLanguageIDKey)
        defaults.synchronize()
    }

    /// 从本地取语言id
    ///
    /// - Returns: 语言id
    private static func languageIDFormLocal() -> String? {
        
        return UserDefaults().string(forKey: XLLocalizeManager.Config.userDefualtLanguageIDKey)
    }
    
}

// MARK: - iOS当前系统语言
extension XLLocalizeManager {
    
    /// 系统语言id
    private static var systemLanguageId: String? {
        
        return Locale.preferredLanguages.first
    }
    
    /// 系统语言
    static var systemLanguage: XLLanguage? {
        
        var result: XLLanguage?
        if let systemLanguageId = systemLanguageId,
            let language = XLLocalizeManager.getLanguage(id: systemLanguageId) {
            result = language
        }
        return result
    }
}
