//
//  XLLocalizeManager.Language+Extension.swift
//  Example
//
//  Created by xx11dragon on 2019/7/9.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import XLLocalizeManager_Swift

extension XLLocalizeManager.Language {
    
    /// 繁体中文
    static var zh_Hant: Language {
        
        return Language(id: "zh-Hant",
                        localizedName: "繁体中文",
                        semanticContentAttribute: .forceLeftToRight)
    }
}
