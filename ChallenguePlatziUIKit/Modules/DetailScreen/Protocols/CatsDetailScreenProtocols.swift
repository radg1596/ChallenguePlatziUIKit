//
//  CatsDetailScreenProtocols.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 15/01/23.
//

import Foundation
import UIKit
import Combine

// MARK: - ROUTER PROTOCOL
protocol CatsDetailScreenRouterProtocol {
    static func createModule(model: CatPreviewMainItem) -> CatsDetailScreenView
}

// MARK: - REPOSITORY PROTOCOL
protocol CatsDetailScreenRepositoryProtocol {
    var imageDataSource: ImageRemoteDataSourceProtocol { get set }
    func getImage(url: String) -> AnyPublisher<UIImage, Error>
}
