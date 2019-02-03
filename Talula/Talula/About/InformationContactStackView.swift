//
//  InformationContactStackView.swift
//  Talula
//
//  Created by Diana Brnovik on 03/02/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class InformationContactStackView: UIStackView {
        
    let gmailView: InformationSmallRowView = {
        let view = InformationSmallRowView()
        view.iconImageView.image = #imageLiteral(resourceName: "InformationGmail")
        view.titleLabel.text = "dia.brnovikova@gmail.com"
        view.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    let linkedInView: InformationSmallRowView = {
        let view = InformationSmallRowView()
        view.iconImageView.image = #imageLiteral(resourceName: "InformationLinkedIn")
        view.titleLabel.text = "Diana Brnovik"
        view.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = NSLayoutConstraint.Axis.vertical
        self.alignment = UIStackView.Alignment.fill
        self.distribution = UIStackView.Distribution.equalSpacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = 5
        
        self.setNeedsUpdateConstraints()
        self.backgroundColor = .white
        
        self.addArrangedSubview(gmailView)
        self.addArrangedSubview(linkedInView)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
