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
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            titleLabel.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(Constants.ui.bigMargin)
            }
            
            didSetupConstraints = true
            
        }
        
        super.updateConstraints()
        
    }
    
}
