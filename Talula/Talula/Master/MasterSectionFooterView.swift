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
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UITableView().separatorColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fonts.bodyFont
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(separatorView)
        self.addSubview(titleLabel)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            self.backgroundColor = UIColor.clear
            
            separatorView.snp.makeConstraints({ (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(2)
            })
            
            titleLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(separatorView).offset(10)
                make.left.right.equalToSuperview()
            })
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
