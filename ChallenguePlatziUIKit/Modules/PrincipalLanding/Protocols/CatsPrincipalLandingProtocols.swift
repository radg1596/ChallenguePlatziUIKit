//
//  CatsPrincipalLandingProtocols.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 15/01/23.
//

import Foundation
import Combine

// MARK: - ROUTER PROTOCOL
protocol CatsPrincipalLandingRouterProtocol {
    static func createModule() -> CatsPrincipalLandingView
    func showDetail(item: CatPreviewMainItem)
}

// MARK: - REPOSITORY PROTOCOL
protocol CatsPrincipalLandingRepositoryProtocol {
    func fetchCats() -> AnyPublisher<[GetCatsServiceResponseDBO], Error>
}

// MARK: - API MANAGER
protocol CatsPrincipalLandingApiDataManagerProtocol {
    func fetchCats() -> AnyPublisher<[GetCatsServiceResponseDBO], Error>
}
