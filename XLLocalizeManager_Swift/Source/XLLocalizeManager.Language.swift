//
//  XLLocalizeManager.Language.swift
//  XLLocalizeManager
//
//  Created by xx11dragon on 2019/7/2.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import UIKit

extension XLLocalizeManager {

    open class Language {
        
        /// 本地语言文件type
        private static let bundleFileType = "lproj"
        
        /// 重命名
        public typealias Language = XLLocalizeManager.Language
        
        //  id https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html
        public let id: String
        
        /// 语言名称
        public let localizedName: String
        
        /// 书写顺序
        public let semanticContentAttribute: UISemanticContentAttribute
        
        /// Bundle
        public var bundle: Bundle?
        
        /// 初始化
        ///
        /// - Parameters:
        ///   - id: 语言id
        ///   - localizedName: 语言名称
        ///   - semanticContentAttribute: 语言语义顺序
        public init(id: String,
                    localizedName: String,
                    semanticContentAttribute: UISemanticContentAttribute) {
            
            self.id = id
            self.localizedName = localizedName
            self.semanticContentAttribute = semanticContentAttribute
            self.bundle = bundle(resource: id)
        }
        
        /// 获取Bundle
        ///
        /// - Parameter resource: resource name
        /// - Returns: Bundle 对象
        private func bundle(resource: String) -> Bundle? {
            
            guard let path = Bundle.main.path(forResource: id,
                                              ofType: XLLocalizeManager.Language.bundleFileType) else {
                                                return nil
            }
            return Bundle(path: path)
        }
    }
}

// MARK: - APP支持的语言
extension XLLocalizeManager.Language {
    
    /// 简体中文
    public static var zh_Hans: Language {
        
        return Language(id: "zh-Hans",
                        localizedName: "简体中文",
                        semanticContentAttribute: .forceLeftToRight)
    }
    
    /// 英语
    public static var english: Language {
        
        return Language(id: "en",
                        localizedName: "English",
                        semanticContentAttribute: .forceLeftToRight)
    }
    
    /// 日语
    public static var japanese: Language {
        
        return Language(id: "ja",
                        localizedName: "日本語",
                        semanticContentAttribute: .forceLeftToRight)
    }
    
    /// 阿拉伯语
    public static var arabic: Language {
        
        return Language(id: "ar",
                        localizedName: "العربية",
                        semanticContentAttribute: .forceRightToLeft)
    }
}

extension XLLocalizeManager.Language : Equatable {
    
    /// 判断语言语言相同
    ///
    /// - Parameters:
    ///   - lhs: 左侧参数
    ///   - rhs: 右侧参数
    /// - Returns: 是否相同
    public static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.id == rhs.id
    }
}
