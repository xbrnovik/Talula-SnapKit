//
//  InformationSmallRowView.swift
//  Talula
//
//  Created by Diana Brnovik on 03/02/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class InformationSmallRowView: BaseView {
    
    private var didSetupConstraints = false
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "InformationGmail")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init() {
        super.init()
        self.setNeedsUpdateConstraints()
        self.backgroundColor = .systemBackground
        self.view.addSubview(titleLabel)
        self.view.addSubview(iconImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            self.snp.makeConstraints { (make) in
                make.height.equalTo(Constants.ui.smallCell)
            }
            
            iconImageView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(Constants.ui.smallMargin)
                make.height.width.equalTo(Constants.ui.miniIconSize)
                make.centerY.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(iconImageView.snp.right).offset(Constants.ui.bigMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
                make.centerY.equalToSuperview()
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
}
