//
//  CatsDetailScreenViewModel.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import Foundation
import Combine
import UIKit

final class CatsDetailScreenViewModel: ObservableObject {

    // MARK: - PUBLISHED
    @Published var isLoadingTheImage: Bool
    @Published var descriptionDateText: String?
    @Published var imageOfCat: UIImage?
    @Published var tags: [String]

    // MARK: - PROPERTIES
    private let item: CatPreviewMainItem
    private let router: CatsDetailScreenRouterProtocol
    private let repository: CatsDetailScreenRepositoryProtocol

    // MARK: - CANCELABLES
    private var cancelables = Set<AnyCancellable>()

    // MARK: - INIT
    init(item: CatPreviewMainItem,
         repository: CatsDetailScreenRepositoryProtocol,
         router: CatsDetailScreenRouterProtocol) {
        self.item = item
        self.isLoadingTheImage = false
        self.tags = item.tags
        self.repository = repository
        self.router = router
    }

    // MARK: - METHODS
    func fetchDataFromModel() {
        descriptionDateText = item.createdAt
        tags = item.tags
        isLoadingTheImage = true
        repository
            .getImage(url: item.imageUrl)
            .sink { [weak self] response in
                switch response {
                case .finished:
                    return
                case .failure:
                    self?.isLoadingTheImage = false
                    self?.imageOfCat = UIImage(named: AppGeneralConstants.imagePlaceHolderError)
                }
            } receiveValue: { [weak self] image in
                self?.isLoadingTheImage = false
                self?.imageOfCat = image
            }
            .store(in: &cancelables)
    }

}
