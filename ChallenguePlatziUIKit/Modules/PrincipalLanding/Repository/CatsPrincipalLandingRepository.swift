//
//  CatsPrincipalLandingRepository.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Combine

final class CatsPrincipalLandingRepository: CatsPrincipalLandingRepositoryProtocol {

    // MARK: - PROPERTIES
    private let apiDataManager: CatsPrincipalLandingApiDataManagerProtocol

    // MARK: - INIT
    init(apiDataManager: CatsPrincipalLandingApiDataManagerProtocol) {
        self.apiDataManager = apiDataManager
    }

    // MARK: - METHODS
    func fetchCats() -> AnyPublisher<[GetCatsServiceResponseDBO], Error> {
        return apiDataManager.fetchCats()
    }

}
