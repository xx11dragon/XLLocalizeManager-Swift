//
//  XLLocalizeManager.Config.swift
//  XLLocalizeManager
//
//  Created by xx11dragon on 2019/7/3.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import Foundation

// MARK: - 配置类
extension XLLocalizeManager {
    
    public class Config {
                
        /// 本地化语言名称KEY
        public static var userDefualtLanguageIDKey = "UserDefualtLanguageIDKey"
        
        /// 本地化文件名
        public static var stringFileName = "Localizable"
        
        /// 可用的语言
        public static var availableLanguages = [
            Language.zh_Hans,
            Language.english
        ]
        
        /// 默认语言
        public static var defaultLanguage = Language.english
        
        /// 修改语言通知
        public static var changedLanguageNotification = NSNotification.Name("ChangedLanguageNotification")
    }
}
