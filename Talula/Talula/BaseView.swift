//
//  BaseView.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BaseView: UIView {
    
    private var didSetupMainConstraints = false
    
    var view: UIView
    
    init() {
        view = UIView(frame: .zero)
        super.init(frame: CGRect.zero)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupMainConstraints) {
            
            view.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            
            didSetupMainConstraints = true
        }
        
        super.updateConstraints()
    }
    
}
