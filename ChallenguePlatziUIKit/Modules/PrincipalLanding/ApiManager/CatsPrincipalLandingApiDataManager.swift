//
//  CatsPrincipalLandingApiDataManager.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Combine
import GenericNetworkingLayer

final class CatsPrincipalLandingApiDataManager: CatsPrincipalLandingApiDataManagerProtocol {

    // MARK: - PROPERTIES
    private let catsService = GenericWebServiceManager<[GetCatsServiceResponseDBO], GenericWebServiceGenericErrorModel>(request: GetCatsMainRequest(limit: AppGeneralConstants.requestLimit))

    // MARK: - METHODS
    func fetchCats() -> AnyPublisher<[GetCatsServiceResponseDBO], Error> {
        return catsService
            .fetchModel(parameters: GenericServiceEmptyParameters())
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }

}
