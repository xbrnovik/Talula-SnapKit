//
//  Constants.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Constants {
    
    struct ui {
        static let masterReusableCellId: String = "masterCell"
        static let bigMargin: CGFloat = 15
        static let mediumMargin: CGFloat = 10
        static let smallMargin: CGFloat = 5
        static let iconSize: CGFloat = 50
        static let miniIconSize: CGFloat = 30
        static let bigCell: CGFloat = 80
        static let smallCell: CGFloat = 40
        static let footerHeight: CGFloat = 80
    }
    
    struct map {
        static let latitudeDelta: CLLocationDegrees = 10
        static let longitudeDelta: CLLocationDegrees = 10
    }
    
    struct error {
        static let dataDomain = "dataError"
        static let emptyReceivedData = 101
        static let incorrectDataFormat = 102
        static let syncFailure = 103
        static let wrongURLFormat = 104
    }
    
    struct coreData {
        static let entityName: String = "Meteorite"
        static let defaultDescriptorPropertyName: String = "mass"
    }
    
    struct fonts {
        static let titleFont = UIFont.preferredFont(forTextStyle: .headline)
        static let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        static let subtitleFont = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    struct dataSync {
        static let taskName = "cz.meteorites.refresh"
        static let timestampKey = "updateTimestamp"
        static let updateDelay = 86400
    }
    
    struct meteoriteMass {
        static let highMassLevel = 10000
        static let lowMassLevel = 1000
    }
    struct numberFormatters {
        static let localeDecimal: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = NSLocale.current
            formatter.minimumFractionDigits = 3
            formatter.maximumFractionDigits = 3
            return formatter
        }()
        static let localeRounded: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = NSLocale.current
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            return formatter
        }()
    }
    
    struct dateFormatters {
        static let iso: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS"
            return formatter
        }()
    }
    
}
