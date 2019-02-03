//
//  InformationIconsStackView.swift
//  Talula
//
//  Created by Diana Brnovik on 03/02/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class InformationIconsStackView: UIStackView {
        
    let meteoriteATypeView: InformationBigRowView = {
        let view = InformationBigRowView()
        view.iconImageView.image = #imageLiteral(resourceName: "BigMeteorite")
        view.titleLabel.text = "This icon describes meteorites with mass value bigger than 10000 g."
        return view
    }()
    
    let meteoriteBTypeView: InformationBigRowView = {
        let view = InformationBigRowView()
        view.iconImageView.image = #imageLiteral(resourceName: "SmaillMeteorite")
        view.titleLabel.text = "This icon describes with mass value smaller than 10000g and bigger than 1000 g."
        return view
    }()
    
    let meteoriteCTypeView: InformationBigRowView = {
        let view = InformationBigRowView()
        view.iconImageView.image = #imageLiteral(resourceName: "OtherMeteorite")
        view.titleLabel.text = "This icon describes other types of meteorites."
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = NSLayoutConstraint.Axis.vertical
        self.alignment = UIStackView.Alignment.fill
        self.distribution = UIStackView.Distribution.equalSpacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = 10
        
        self.setNeedsUpdateConstraints()
        self.backgroundColor = .white
        
        self.addArrangedSubview(meteoriteATypeView)
        self.addArrangedSubview(meteoriteBTypeView)
        self.addArrangedSubview(meteoriteCTypeView)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
