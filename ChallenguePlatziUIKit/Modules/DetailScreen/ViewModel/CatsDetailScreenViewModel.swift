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
    @Published var descriptionDateText: String?
    @Published var imageOfCat: UIImage?

    // MARK: - PROPERTIES
    private let item: CatPreviewMainItem
    private let repository = CatsDetailScreenRepository()

    // MARK: - CANCELABLES
    private var cancelables = Set<AnyCancellable>()

    // MARK: - INIT
    init(item: CatPreviewMainItem) {
        self.item = item
    }

    // MARK: - METHODS
    func fetchDataFromModel() {
        descriptionDateText = item.createdAt
        repository
            .getImage(url: item.imageUrl)
            .sink { response in
                switch response {
                case .finished:
                    return
                case .failure:
                    return
                }
            } receiveValue: { [weak self] image in
                self?.imageOfCat = image
            }
            .store(in: &cancelables)
    }

}
