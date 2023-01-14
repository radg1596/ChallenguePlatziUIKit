//
//  GetCatsServiceResponseDBO.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Foundation

struct GetCatsServiceResponseDBO: Codable {
    
    // MARK: - PROPERTIES
    let id: String
    let createdAt: String
    let tags: [String]
    
    // MARK: - CODING KEYS
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt
        case tags
    }

}
