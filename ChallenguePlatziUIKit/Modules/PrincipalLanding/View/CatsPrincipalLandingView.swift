//
//  CatsPrincipalLandingView.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit
import Combine

class CatsPrincipalLandingView: UIViewController, LoadableViewController {

    // MARK: - UI COMPONENTS
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: view.frame,
                         collectionViewLayout: UICollectionViewFlowLayout())
    }()

    // MARK: - VIEW MODEL
    var viewModel: CatsPrincipalLandingViewModel?

    // MARK: - OTHER PROPERTIES
    private let alertController = AlertViewManager()
    private let constants = CatsPrincipalLandingConstants()
    private typealias Localizables = CatsPrincipalLandingStrings

    // MARK: - CANCELABLES
    private var cancelables = Set<AnyCancellable>()
    
    // MARK: - CURRENT LOADING VIEW
    var currentLoadingViewController: LoadingViewController?

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel?.requestToLoadItems()
    }

    // MARK: - UI
    private func configureUI() {
        configureColors()
        configureLocalizableStrings()
        configureNavigationView()
        buildCollectionView()
        configureCollectionView()
        configureDataBindingForCollectionView()
        configureDataBindingForLoader()
        configureDataBindingForServiceErrorModal()
        configureDataBindingForNoInternetAlert()
    }

    private func configureColors() {
        view.backgroundColor = .backgroundColorHard
    }

    private func configureNavigationView() {
        let appearanceOfNavBar = UINavigationBarAppearance()
        navigationController?.navigationBar.barTintColor = UIColor.primaryTextColor
        navigationController?.navigationBar.tintColor = UIColor.primaryTextColor
        appearanceOfNavBar.backgroundColor = .backgroundColorLight
        appearanceOfNavBar.largeTitleTextAttributes = [.foregroundColor: UIColor.primaryTextColor]
        appearanceOfNavBar.titleTextAttributes = [.foregroundColor: UIColor.primaryTextColor]
        navigationController?.navigationBar.compactAppearance = appearanceOfNavBar
        navigationController?.navigationBar.standardAppearance = appearanceOfNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceOfNavBar
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.compactScrollEdgeAppearance = appearanceOfNavBar
        }
    }

    private func configureLocalizableStrings() {
        title = Localizables.navigationTitle.localize
    }

    // MARK: - BUILD VIEW METHODS
    private func buildCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .backgroundColorHard
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: constants.collectionViewConstraintConstant),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -constants.collectionViewConstraintConstant),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: constants.collectionViewConstraintConstant),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: constants.collectionViewConstraintConstant)
        ])
    }

    // MARK: - CONFIGURATION
    private func configureCollectionView() {
        collectionView.register(CatPreviewCollectionViewCell.self,
                                forCellWithReuseIdentifier: CatPreviewCollectionViewCell.defaultIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - DATA BINDING
    private func configureDataBindingForCollectionView() {
        viewModel?
            .$catItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancelables)
        viewModel?
            .$isLoadingInitialItems
            .assign(to: \.isHidden, on: collectionView)
            .store(in: &cancelables)
        viewModel?
            .$isShowingNoInternetConnectionAlert
            .assign(to: \.isHidden, on: collectionView)
            .store(in: &cancelables)
    }

    private func configureDataBindingForLoader() {
        viewModel?
            .$isLoadingInitialItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.showLoading(completion: nil) : self?.hideLoading(completion: nil)
            }
            .store(in: &cancelables)
    }

    private func configureDataBindingForServiceErrorModal() {
        viewModel?
            .$isShowingServerErrorAlert
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isShowingError in
                guard let self = self,
                      isShowingError else { return }
                let titleOfAlert = AppGeneralErrorStrings.serverErrorTitle.localize
                let bodyOfAlert = AppGeneralErrorStrings.serverErrorBody.localize
                let retryButton = AppGeneralErrorStrings.serverErrorRetryButton.localize
                self.alertController.showSimpleRetryAlert(view: self,
                                                          title: titleOfAlert,
                                                          message: bodyOfAlert,
                                                          retryTitle: retryButton,
                                                          retryCompletion: { [weak self] in
                    self?.viewModel?.requestToLoadItems()
                })
            }
            .store(in: &cancelables)
    }

    private func configureDataBindingForNoInternetAlert() {
        viewModel?
            .$isShowingNoInternetConnectionAlert
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isShowingModal in
                guard let self = self,
                      isShowingModal else { return }
                let titleOfAlert = AppGeneralErrorStrings.noInternetTitle.localize
                let bodyOfAlert = AppGeneralErrorStrings.noInternetBody.localize
                let retryButton = AppGeneralErrorStrings.noInternetRetryButton.localize
                self.alertController.showSimpleRetryAlert(view: self,
                                                          title: titleOfAlert,
                                                          message: bodyOfAlert,
                                                          retryTitle: retryButton,
                                                          retryCompletion: { [weak self] in
                    self?.viewModel?.requestToLoadItems()
                })
            }
            .store(in: &cancelables)
    }

}

// MARK: - COLLECTION VIEW DATA SOURCE
extension CatsPrincipalLandingView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.catItems.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatPreviewCollectionViewCell.defaultIdentifier, for: indexPath)
        if let cell = cell as? CatPreviewCollectionViewCell, let viewModel = viewModel {
            cell.model = viewModel.catItems[indexPath.row]
        }
        return cell
    }

}

// MARK: - COLLECTION VIEW DELEGATE
extension CatsPrincipalLandingView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width - constants.collectionItemOffset) / constants.collectionItemWidhtFactor,
               height: view.frame.height / constants.collectionItemHeightFactor )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.tappedDetailItem(indexPath: indexPath)
    }

}
