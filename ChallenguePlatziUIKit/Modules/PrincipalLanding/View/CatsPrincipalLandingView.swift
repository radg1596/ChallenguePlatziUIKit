//
//  CatsPrincipalLandingView.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit

class CatsPrincipalLandingView: UIViewController {

    // MARK: - UI COMPONENTS
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: view.frame,
                         collectionViewLayout: UICollectionViewFlowLayout())
    }()

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        buildCollectionView()
        configureCollectionView()
    }

    // MARK: - BUILD VIEW METHODS
    private func buildCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 8.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -8.0),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,
                                                constant: 8.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                   constant: 8.0)
        ])
    }

    // MARK: - CONFIGURATION
    private func configureCollectionView() {
        collectionView.register(CatPreviewCollectionViewCell.self,
                                forCellWithReuseIdentifier: CatPreviewCollectionViewCell.defaultIdentifier)
        collectionView.dataSource = self
        collectionView.reloadData()
    }

}

// MARK: - DATA SOURCE
extension CatsPrincipalLandingView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 90
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatPreviewCollectionViewCell.defaultIdentifier,
                                                      for: indexPath)
        return cell
    }

}
