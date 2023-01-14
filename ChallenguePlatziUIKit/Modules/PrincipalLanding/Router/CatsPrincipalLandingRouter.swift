//
//  CatsPrincipalLandingRouter.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit

class CatsPrincipalLandingRouter {

    // MARK: - PROPERTIES
    private weak var viewReference: UIViewController?

    // MARK: - INIT
    init(view: UIViewController) {
        self.viewReference = view
    }

    // MARK: - METHODS
    func showDetail(item: CatPreviewMainItem) {
        guard let view = viewReference else { return }
        let detailView = CatsDetailScreenView()
        detailView.viewModel = CatsDetailScreenViewModel(item: item)
        view.navigationController?.pushViewController(detailView,
                                                      animated: true)
    }

}
