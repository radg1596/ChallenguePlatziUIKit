//
//  CatsDetailScreenView.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit
import Combine

class CatsDetailScreenView: UIViewController {

    // MARK: - PROPERTIES
    private lazy var imageView: UIImageView = {
        UIImageView(frame: .zero)
    }()
    private lazy var creationDescriptionLabel: UILabel = {
        UILabel(frame: .zero)
    }()

    // MARK: - VIEW MODEL
    var viewModel: CatsDetailScreenViewModel?

    // MARK: - CANCELABLES
    private var cancelables = Set<AnyCancellable>()

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel?.fetchDataFromModel()
    }

    // MARK: - UI
    private func configureUI() {
        buildImageView()
        buildLabel()
        view.backgroundColor = .white
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        creationDescriptionLabel.numberOfLines = .zero
        viewModel?
            .$descriptionDateText
            .assign(to: \.text,
                    on: creationDescriptionLabel)
            .store(in: &cancelables)
        viewModel?
            .$imageOfCat
            .assign(to: \.image,
                    on: imageView)
            .store(in: &cancelables)
    }

    private func buildImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }

    private func buildLabel() {
        creationDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(creationDescriptionLabel)
        NSLayoutConstraint.activate([
            creationDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            creationDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            creationDescriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                                          constant: 10)
        ])
    }

}
