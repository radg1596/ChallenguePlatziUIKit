//
//  CatsPrincipalLandingViewModel.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Combine
import Foundation

final class CatsPrincipalLandingViewModel: ObservableObject {

    // MARK: - PUBLISHED PROPERTIES
    @Published var catItems: [CatPreviewMainItem]
    @Published var isLoadingInitialItems: Bool

    // MARK: - ROUTER
    private let router: CatsPrincipalLandingRouter

    // MARK: - OTHER PROPERTIES
    private var cancelables = Set<AnyCancellable>()
    private let dataRepository = CatsPrincipalLandingRepository()

    // MARK: - INIT
    init(router: CatsPrincipalLandingRouter) {
        self.catItems = []
        self.isLoadingInitialItems = false
        self.router = router
    }

    // MARK: - METHODS
    func requestToLoadItems() {
        isLoadingInitialItems = true
        dataRepository
            .fetchCats()
            .map({$0.map({CatPreviewMainItem(dbo: $0)})})
            .sink { response in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
                // Handle failure, no internet, etc...
            } receiveValue: { [weak self] newItems in
                self?.catItems = newItems
            }
            .store(in: &cancelables)
    }

    func tappedDetailItem(indexPath: IndexPath) {
        router.showDetail(item: catItems[indexPath.row])
    }

}
