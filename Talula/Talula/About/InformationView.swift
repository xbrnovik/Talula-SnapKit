//
//  InformationView.swift
//  Talula
//
//  Created by Diana Brnovik on 03/02/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class InformationView: BaseView {
    
    private var didSetupConstraints = false
    
    let outerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.delaysContentTouches = false
        scrollView.autoresizesSubviews = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollsToTop = false
        scrollView.setContentOffset(.zero, animated: false)
        return scrollView
    }()
    
    let innerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let descriptionAppLabel: UILabel = {
        let label = UILabel()
        label.text = "This application shows the list of fallen meteorites on Earth since 2011 and also its count. The meteorites are sorted by their masses in descending order. Source data is obtained from NASA and it is updated periodically. In the detail of every fallen meteorite, the user can see its position on map."
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let iconsDescriptionStackView: InformationIconsStackView = {
        let view = InformationIconsStackView()
        return view
    }()
    
    let autorAppLabel: UILabel = {
        let label = UILabel()
        label.text = "This application was implemented by Diana Brnovik."
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let contactStackView: InformationContactStackView = {
        let view = InformationContactStackView()
        return view
    }()
    
    let licenseHeadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Icons"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    let licenseBodyTextView: UITextView = {
        let view = UITextView()
        view.text = "This application uses free icons availables on certain websites. \nThe source of application icon is https://icons8.com/. \nThe source of other icons is https://www.flaticon.com/."
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.isEditable = false
        view.dataDetectorTypes = .link
        view.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.textContainer.lineFragmentPadding = 0
        view.isScrollEnabled = false
        return view
    }()
    
    
    override init() {
        super.init()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(outerView)
        self.outerView.addSubview(scrollView)
        self.scrollView.addSubview(innerView)
        innerView.addSubview(descriptionAppLabel)
        innerView.addSubview(iconsDescriptionStackView)
        innerView.addSubview(autorAppLabel)
        innerView.addSubview(contactStackView)
        innerView.addSubview(licenseHeadlineLabel)
        innerView.addSubview(licenseBodyTextView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            outerView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            
            scrollView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            
            innerView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
                make.leading.trailing.equalTo(outerView)
            })
            
            descriptionAppLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(20)
                make.left.equalToSuperview().offset(Constants.ui.bigMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            iconsDescriptionStackView.snp.makeConstraints { (make) in
                make.top.equalTo(descriptionAppLabel.snp.bottom).offset(Constants.ui.bigMargin)
                make.left.equalToSuperview().offset(Constants.ui.bigMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            autorAppLabel.snp.makeConstraints { (make) in
                make.top.equalTo(iconsDescriptionStackView.snp.bottom).offset(Constants.ui.bigMargin)
                make.left.equalToSuperview().offset(Constants.ui.bigMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            contactStackView.snp.makeConstraints { (make) in
                make.top.equalTo(autorAppLabel.snp.bottom).offset(Constants.ui.bigMargin)
                make.left.equalToSuperview().offset(Constants.ui.bigMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            licenseHeadlineLabel.snp.makeConstraints { (make) in
                make.top.equalTo(contactStackView.snp.bottom).offset(Constants.ui.bigMargin)
                make.left.equalToSuperview().offset(Constants.ui.bigMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            licenseBodyTextView.snp.makeConstraints { (make) in
                make.top.equalTo(licenseHeadlineLabel.snp.bottom).offset(Constants.ui.mediumMargin)
                make.left.equalToSuperview().offset(Constants.ui.bigMargin)
                make.right.equalToSuperview().offset(-Constants.ui.bigMargin)
                make.bottom.equalToSuperview().offset(-Constants.ui.bigMargin)
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
}
