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

    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        // TODO: - Move error to localizables
        fatalError("init(coder:) has not been implemented")
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
        backgroundColor = .gray
        builImageView()
        buildActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
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

    // MARK: - MODEL DRAW
    private func didSetModelInCell() {
        guard let model = model else { return }
        let urlForImage = "https://cataas.com/cat/\(model.id)"
        imageDataSource
            .requestToFetchImage(urlForImage,
                                            cachePolicy: .returnCacheDataElseLoad)
            .sink { response in
                switch response {
                case .finished:
                    return
                case .failure:
                    // Error...
                    return
                }
            } receiveValue: { image in
                self.activityIndicatorView.stopAnimating()
                self.imageView.image = image
            }
            .store(in: &cancelables)
    }

}
