//
//  String+Localize.swift
//  XLLocalizeManager
//
//  Created by xx11dragon on 2019/7/3.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import Foundation

public extension String {
    
    /// 本地化 String
    var xl_localize: String {
        
        return XLLString(self)
    }
}
