//
//  CatsPrincipalLandingRouter.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit

class CatsPrincipalLandingRouter: CatsPrincipalLandingRouterProtocol {

    // MARK: - PROPERTIES
    private weak var viewReference: UIViewController?

    // MARK: - INIT
    init(viewReference: UIViewController? = nil) {
        self.viewReference = viewReference
    }

    // MARK: - METHODS
    func showDetail(item: CatPreviewMainItem) {
        guard let view = viewReference else { return }
        let detailView = CatsDetailScreenRouter.createModule(model: item)
        view.navigationController?.pushViewController(detailView,
                                                      animated: true)
    }

    static func createModule() -> CatsPrincipalLandingView {
        let view = CatsPrincipalLandingView()
        let router = CatsPrincipalLandingRouter(viewReference: view)
        let apiDataManager = CatsPrincipalLandingApiDataManager()
        let repository = CatsPrincipalLandingRepository(apiDataManager: apiDataManager)
        let connectionChecker = InternetConnectionCheckerManager()
        let viewModel = CatsPrincipalLandingViewModel(router: router,
                                                      connectionChecker: connectionChecker,
                                                      dataRepository: repository)
        view.viewModel = viewModel
        return view
    }

}
