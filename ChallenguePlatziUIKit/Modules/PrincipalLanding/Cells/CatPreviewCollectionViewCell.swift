//
//  CatPreviewCollectionViewCell.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit

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

    // MARK: - UI
    private func configureUI() {
        backgroundColor = .red
        builImageView()
        buildActivityIndicatorView()
        imageView.image = UIImage(systemName: "heart.fill")
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

}
