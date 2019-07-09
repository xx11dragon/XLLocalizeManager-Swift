//
//  ViewController.swift
//  Example
//
//  Created by xx11dragon on 2019/7/9.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import UIKit
import XLLocalizeManager_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        XLLocalizeManager.Config.availableLanguages = [
            XLLanguage.zh_Hans,
            XLLanguage.zh_Hant,
            XLLanguage.english,
            XLLanguage.arabic
        ]
        self.xl_titleLocalize = "示例"
        view.backgroundColor = UIColor.white
        let languageItem = UIBarButtonItem(title: "Language",
                                           style: .plain,
                                           target: self,
                                           action: #selector(pushLanguageController))
        
        languageItem.xl_titleLocalize = "语言"
        let viewItem = UIBarButtonItem(title: "->",
                                       style: .plain,
                                       target: self,
                                       action: #selector(pushViewController))
        self.navigationItem.rightBarButtonItems = [viewItem, languageItem]
        layoutUI()
    }
    
    func layoutUI() {
        
        let totalColumns = 4
        for index  in 0 ... 40 {
            let row: CGFloat = CGFloat(index / totalColumns)
            let col: CGFloat = CGFloat(index % totalColumns)
            let width: CGFloat = UIScreen.main.bounds.width / CGFloat(totalColumns)
            let height: CGFloat = 20
            let x = col * width
            let y = 50 + row * height
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.frame = CGRect(x: x, y: y, width: width, height: height);
            label.xl_textLocalize = "你好世界"
            self.view.addSubview(label);
        }
        
        let textField = UITextField(frame: CGRect(x: 20, y: 300, width: 300, height: 100))
        textField.backgroundColor = UIColor.lightGray
        textField.xl_placeholderLocalize = "请输入账号"
        self.view .addSubview(textField)
        
        let button = UIButton(frame: CGRect(x: 20, y: 400, width: 300, height: 40))
        button.backgroundColor = UIColor.orange
        button.xl_setTitleLocalize(key: "注册", state: .normal)
        button.xl_setTitleLocalize(key: "你好世界", state: .highlighted)
        self.view.addSubview(button)
    }
    
    @objc private func pushViewController() {
        
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func pushLanguageController() {
        
        let languageController = LanguageController()
        navigationController?.pushViewController(languageController, animated: true)
    }
}

