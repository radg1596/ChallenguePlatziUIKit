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
    @Published var isShowingServerErrorAlert: Bool
    @Published var isShowingNoInternetConnectionAlert: Bool

    // MARK: - PROPERTIES
    private let router: CatsPrincipalLandingRouterProtocol
    private let connectionChecker: InternetConnectionCheckeable
    private let dataRepository: CatsPrincipalLandingRepositoryProtocol

    // MARK: - OTHER PROPERTIES
    private var cancelables = Set<AnyCancellable>()

    // MARK: - INIT
    init(router: CatsPrincipalLandingRouterProtocol,
         connectionChecker: InternetConnectionCheckeable,
         dataRepository: CatsPrincipalLandingRepositoryProtocol) {
        self.catItems = []
        self.isLoadingInitialItems = false
        self.isShowingServerErrorAlert = false
        self.isShowingNoInternetConnectionAlert = false
        self.router = router
        self.connectionChecker = connectionChecker
        self.dataRepository = dataRepository
    }

    // MARK: - METHODS
    func requestToLoadItems() {
        connectionChecker
            .networkCheckerPublisher()
            .sink { [weak self] connectionAvailable in
                if connectionAvailable {
                    self?.requestToLoadItemsOnSafeConnection()
                } else {
                    self?.isShowingNoInternetConnectionAlert = true
                }
            }
            .store(in: &cancelables)
    }

    func tappedDetailItem(indexPath: IndexPath) {
        router.showDetail(item: catItems[indexPath.row])
    }

    // MARK: - OWN METHODS
    private func requestToLoadItemsOnSafeConnection() {
        isLoadingInitialItems = true
        dataRepository
            .fetchCats()
            .map({$0.map({CatPreviewMainItem(dbo: $0)})})
            .sink { [weak self] response in
                switch response {
                case .failure:
                    self?.isLoadingInitialItems = false
                    self?.isShowingServerErrorAlert = true
                case .finished:
                    return
                }
            } receiveValue: { [weak self] newItems in
                self?.isLoadingInitialItems = false
                self?.catItems = newItems
            }
            .store(in: &cancelables)
    }

}
