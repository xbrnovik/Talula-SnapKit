//
//  MasterCell.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class MasterCell: UITableViewCell {
    
    private var didSetupConstraints = false
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "meteorite-small_right")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 1
        label.font = Constants.fonts.titleFont
        label.text = "Meteorite"
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 1
        label.font = Constants.fonts.subtitleFont
        label.text = "Mass"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            iconImageView.snp.makeConstraints { (make) in
                make.width.height.equalTo(Constants.ui.iconSize)
                make.left.equalToSuperview().offset(Constants.ui.bigMargin)
                make.centerY.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(Constants.ui.bigMargin+5)
                make.left.equalTo(iconImageView.snp.right).offset(Constants.ui.mediumMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            subTitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(Constants.ui.smallMargin)
                make.left.equalTo(iconImageView.snp.right).offset(Constants.ui.mediumMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            didSetupConstraints = true
            
        }
        
        super.updateConstraints()
        
    }
    
}
