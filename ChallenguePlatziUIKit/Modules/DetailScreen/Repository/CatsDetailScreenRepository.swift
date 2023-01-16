//
//  CatsDetailScreenRepository.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Combine
import UIKit

class CatsDetailScreenRepository: CatsDetailScreenRepositoryProtocol {

    // MARK: - PROPERTIES
    var imageDataSource: ImageRemoteDataSourceProtocol

    // MARK: - INIT
    init(imageDataSource: ImageRemoteDataSourceProtocol) {
        self.imageDataSource = imageDataSource
    }

    // MARK: - METHODS
    func getImage(url: String) -> AnyPublisher<UIImage, Error> {
        return imageDataSource.requestToFetchImage(url,
                                                   cachePolicy: .returnCacheDataElseLoad)
    }

}
