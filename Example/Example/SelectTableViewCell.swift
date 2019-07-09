//
//  SelectTableViewCell.swift
//  XLLanguageManagerExample
//
//  Created by xx11dragon on 2019/7/1.
//  Copyright © 2019 xx11dragon. All rights reserved.
//

import UIKit

class SelectTableViewCell: UITableViewCell {

    public var isSelectedCell: Bool = false {
        
        didSet {
            selectImageView.isHidden = !isSelectedCell
        }
    }
    
    private lazy var selectImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "selected")
        self.contentView .addSubview(imageView)
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = 20
        let height: CGFloat = width
        let x: CGFloat = self.contentView.bounds.width - width - 15
        let y: CGFloat = (self.contentView.bounds.height - height) / 2
        selectImageView.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
