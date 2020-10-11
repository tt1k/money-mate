//
//  RecordTableViewCell.swift
//  MoneyPlus
//
//  Created by FakeCoder on 2020/10/11.
//

import UIKit
import SnapKit

class RecordTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var amountLabel = UILabel()
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.size.width -= 20
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.font = AppConstants.kTitleFont
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)
        amountLabel.font = AppConstants.kTitleFont
        
        let margin = AppConstants.kViewMargin / 2
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(margin)
            make.left.equalTo(contentView).offset(margin)
        }
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
            make.left.equalTo(contentView).offset(margin)
        }
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-margin)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
