//
//  EnumStringLocalizable.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 14/01/23.
//

import Foundation

func Localize(_ string: String) ->  String {
    return NSLocalizedString(string,
                             tableName: AppGeneralConstants.localizablesFileName,
                             comment: String())
}

protocol EnumStringLocalizable {
    var localize: String { get }
}

extension EnumStringLocalizable where Self: RawRepresentable<String> {

    var localize: String {
        return Localize(self.rawValue)
    }

}
