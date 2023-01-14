//
//  CatsDetailScreenRepository.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Combine
import UIKit

class CatsDetailScreenRepository {

    // MARK: - PROPERTIES
    private let imageDataSource: ImageRemoteDataSourceProtocol = ImageDownloaderManager()

    // MARK: - METHODS
    func getImage(url: String) -> AnyPublisher<UIImage, Error> {
        return imageDataSource.requestToFetchImage(url,
                                                   cachePolicy: .returnCacheDataElseLoad)
    }

}
