//
//  TagsListHorizontalViewModel.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 15/01/23.
//

import Foundation

final class TagsListHorizontalViewModel: ObservableObject {

    // MARK: - PROPERTIES
    @Published var tags: [String]

    // MARK: - INIT
    init(tags: [String]) {
        self.tags = tags
    }

}
