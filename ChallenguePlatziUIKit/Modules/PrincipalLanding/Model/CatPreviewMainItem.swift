//
//  CatPreviewMainItem.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Foundation

struct CatPreviewMainItem {

    // MARK: - PROPERTIES
    let id: String
    let createdAt: String
    let tags: [String]

    // MARK: - INIT DBO
    init(dbo: GetCatsServiceResponseDBO) {
        self.id = dbo.id
        self.createdAt = dbo.createdAt
        self.tags = dbo.tags
    }

}
