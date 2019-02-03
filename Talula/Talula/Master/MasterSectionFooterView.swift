//
//  MasterSectionFooterView.swift
//  Talula
//
//  Created by Diana Brnovik on 03/02/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class MasterSectionFooterView: UIView {
    private var didSetupConstraints = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = Constants.fonts.bodyFont
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        self.setNeedsUpdateConstraints()
    }
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(titleLabel)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            self.backgroundColor = UIColor.white
            
            titleLabel.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
