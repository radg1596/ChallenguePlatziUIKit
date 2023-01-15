//
//  CatPreviewCollectionViewCell.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit
import Combine

class CatPreviewCollectionViewCell: UICollectionViewCell {

    // MARK: - SUB VIEWS
    private lazy var imageView: UIImageView = {
        UIImageView(frame: .zero)
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        UIActivityIndicatorView(frame: .zero)
    }()

    // MARK: - CONSTANTS
    private let constants = CatPreviewCollectionViewCellConstants()

    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError(AppGeneralErrorStrings.canNotBuildViewError.localize)
    }

    // MARK: - OTHER PROPERTIES
    private let imageDataSource: ImageRemoteDataSourceProtocol = ImageDownloaderManager()
    private var cancelables = Set<AnyCancellable>()

    // MARK: - MODEL
    var model: CatPreviewMainItem? {
        didSet {
            didSetModelInCell()
        }
    }

    // MARK: - VIEW LIFE CYCLE
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelables.forEach({$0.cancel()})
        imageView.image = nil
        activityIndicatorView.startAnimating()
    }

    // MARK: - UI
    private func configureUI() {
        configureColors()
        builImageView()
        buildActivityIndicatorView()
        configureContentView()
        configureActivityIndicator()
    }

    private func configureColors() {
        backgroundColor = .backgroundColorLight
        activityIndicatorView.color = .primaryTextColor
    }

    // MARK: - BUILD VIEW
    private func builImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func buildActivityIndicatorView() {
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        bringSubviewToFront(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func configureContentView() {
        layer.cornerRadius = constants.viewCornerRadius
        layer.masksToBounds = true
    }

    private func configureActivityIndicator() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }

    // MARK: - MODEL DRAW
    private func didSetModelInCell() {
        guard let model = model else { return }
        imageDataSource
            .requestToFetchImage(model.imageUrl,
                                 cachePolicy: .returnCacheDataElseLoad)
            .sink { [weak self] response in
                switch response {
                case .finished:
                    return
                case .failure:
                    self?.activityIndicatorView.stopAnimating()
                    self?.imageView.image = UIImage(named: AppGeneralConstants.imagePlaceHolderError)
                }
            } receiveValue: { [weak self] image in
                self?.activityIndicatorView.stopAnimating()
                self?.imageView.image = image
            }
            .store(in: &cancelables)
    }

}
