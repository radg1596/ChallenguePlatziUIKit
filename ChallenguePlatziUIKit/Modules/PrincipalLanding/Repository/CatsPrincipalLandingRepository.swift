//
//  CatsPrincipalLandingRepository.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Combine

final class CatsPrincipalLandingRepository {

    // MARK: - PROPERTIES
    private let apiDataManager = CatsPrincipalLandingApiDataManager()

    // MARK: - METHODS
    func fetchCats() -> AnyPublisher<[GetCatsServiceResponseDBO], Error> {
        return apiDataManager.fetchCats()
    }

}
