//
//  CatsPrincipalLandingView.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit
import Combine

class CatsPrincipalLandingView: UIViewController {

    // MARK: - UI COMPONENTS
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: view.frame,
                         collectionViewLayout: UICollectionViewFlowLayout())
    }()

    // MARK: - PROPERTIES
    private lazy var viewModel: CatsPrincipalLandingViewModel = {
        CatsPrincipalLandingViewModel(router: CatsPrincipalLandingRouter(view: self))
    }()

    // MARK: - CANCELABLES
    private var cancelables = Set<AnyCancellable>()

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.requestToLoadItems()
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        title = "Cute Cats!"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        collectionView.delegate = self
        /// Binding collection view to view model `$catItems`
        viewModel.$catItems.sink { [weak self] _ in
            self?.collectionView.reloadData()
        }
        .store(in: &cancelables)
    }

}

// MARK: - COLLECTION VIEW DATA SOURCE
extension CatsPrincipalLandingView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.catItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatPreviewCollectionViewCell.defaultIdentifier, for: indexPath)
        if let cell = cell as? CatPreviewCollectionViewCell {
            cell.model = viewModel.catItems[indexPath.row]
        }
        return cell
    }

}

// MARK: - COLLECTION VIEW DELEGATE
extension CatsPrincipalLandingView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width - 36) / 3,
               height: view.frame.height / 5 )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.tappedDetailItem(indexPath: indexPath)
    }

}
