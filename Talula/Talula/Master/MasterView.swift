//
//  MasterView.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

protocol FooterViewDelegate: class {
    func willDisplayFooterView() -> UIView?
}

class MasterView: BaseView {
    
    private var didSetupConstraints = false
    weak var delegate: FooterViewDelegate?
    
    let listView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    
    override init() {
        super.init()
        self.setNeedsUpdateConstraints()
        self.backgroundColor = .white
        self.view.addSubview(listView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            listView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
        self.listView.tableFooterView = delegate?.willDisplayFooterView()
    }
    
}
