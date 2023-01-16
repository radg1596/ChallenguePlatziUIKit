//
//  TagsListHorizontalView.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 15/01/23.
//

import UIKit
import Combine

class TagsListHorizontalView: UIViewController {

    // MARK: - SUB VIEWS
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.estimatedItemSize = CGSize(width: constants.estimatedItemSize,
                                                        height: constants.estimatedItemSize)
        collectionViewLayout.scrollDirection = .horizontal
        return UICollectionView(frame: view.frame,
                                collectionViewLayout: collectionViewLayout)
    }()
    private lazy var emptyTagsLabel: UILabel = {
        UILabel(frame: .zero)
    }()

    // MARK: - PROPERTIES
    private let constants = TagsListHorizontalViewConstants()
    private typealias Localizables = TagsListHorizontalViewStrings

    // MARK: - VIEW MODEL
    var viewModel: TagsListHorizontalViewModel? = TagsListHorizontalViewModel(tags: [])

    // MARK: - CANCELABLES
    private var cancelables = Set<AnyCancellable>()

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - RELOAD
    func reload(tags: [String]) {
        viewModel?.tags = tags
    }

    // MARK: - UI
    private func configureUI() {
        configureColors()
        configureLocalizableStrings()
        configureLabels()
        builCollectionView()
        buildNoTagsLabel()
        configureTagsLabelDataBinding()
        configureCollectionView()
    }

    private func configureColors() {
        view.backgroundColor = .backgroundColorLight
        emptyTagsLabel.textColor = .primaryTextColor
        collectionView.backgroundColor = .backgroundColorLight
    }

    private func configureLocalizableStrings() {
        emptyTagsLabel.text = Localizables.noItemsLabel.localize
    }

    private func configureLabels() {
        emptyTagsLabel.font = .systemFont(ofSize: constants.tagsLabelSize)
        view.layer.cornerRadius = constants.viewCornerRadius
    }

    // MARK: - BUILD
    private func builCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: constants.labelLateralConstant),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -constants.labelLateralConstant),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func buildNoTagsLabel() {
        emptyTagsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyTagsLabel)
        view.bringSubviewToFront(emptyTagsLabel)
        NSLayoutConstraint.activate([
            emptyTagsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyTagsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - CONFIGURE
    private func configureCollectionView() {
        collectionView.register(TagsListCollectionViewCell.self,
                                forCellWithReuseIdentifier: TagsListCollectionViewCell.defaultIdentifier)
        collectionView.dataSource = self
    }

    // MARK: - BINDING
    private func configureTagsLabelDataBinding() {
        viewModel?
            .$tags
            .sink(receiveValue: { [weak self] data in
                self?.collectionView.reloadData()
                self?.emptyTagsLabel.isHidden = !data.isEmpty
            })
            .store(in: &cancelables)
    }

}

// MARK: - DATA SOURCE
extension TagsListHorizontalView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.tags.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsListCollectionViewCell.defaultIdentifier,
                                                      for: indexPath)
        if let cell = cell as? TagsListCollectionViewCell,
            let viewModel = viewModel {
            cell.setTag(text: viewModel.tags[indexPath.row])
        }
        return cell
    }

}
