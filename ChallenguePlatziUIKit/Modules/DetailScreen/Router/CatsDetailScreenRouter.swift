//
//  CatsDetailScreenRouter.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 15/01/23.
//

import Foundation

final class CatsDetailScreenRouter: CatsDetailScreenRouterProtocol {

    // MARK: - METHODS
    static func createModule(model: CatPreviewMainItem) -> CatsDetailScreenView {
        let view = CatsDetailScreenView()
        let imageManager = ImageDownloaderManager()
        let dataRepository = CatsDetailScreenRepository(imageDataSource: imageManager)
        let router = CatsDetailScreenRouter()
        let viewModel = CatsDetailScreenViewModel(item: model,
                                                  repository: dataRepository,
                                                  router: router)
        view.viewModel = viewModel
        return view
    }

}
