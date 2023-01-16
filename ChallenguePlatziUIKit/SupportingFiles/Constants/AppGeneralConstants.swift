//
//  AppGeneralConstants.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit

class AppGeneralConstants {

    // MARK: - CACHE
    static let memoryCacheSize: Int = 250 * 1024 * 1024
    static let diskCacheSize: Int = 1024 * 1024 * 1024

    // MARK: - LOCALIZABLES
    static let localizablesFileName = "Localizables"
    static let imagePlaceHolderError: String = "errorImagePlaceHolder"

    // MARK: - LIMIT
    static let requestLimit: Int = 1_000
    static let imageTimeOut = 4.0

    // MARK: - MAIN URL
    static let servicesMainUrl = "https://cataas.com/api/"
    static let imagesMainUrl = "https://cataas.com/cat/"

    // MARK: - COLORS
    static let tagsColors: [UIColor] = [
        UIColor.green,
        UIColor.red,
        UIColor.blue,
        UIColor.darkGray,
        UIColor.cyan,
        UIColor.brown,
    ]

}
