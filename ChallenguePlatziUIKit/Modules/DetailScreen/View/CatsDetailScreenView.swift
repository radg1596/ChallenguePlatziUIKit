//
//  CatsDetailScreenView.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 13/01/23.
//

import UIKit
import Combine

class CatsDetailScreenView: UIViewController {

    // MARK: - SUB VIEWS
    private lazy var imageView: UIImageView = {
        UIImageView(frame: .zero)
    }()
    private lazy var creationTitleLabel: UILabel = {
        UILabel(frame: .zero)
    }()
    private lazy var creationDescriptionLabel: UILabel = {
        UILabel(frame: .zero)
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        UIActivityIndicatorView(frame: .zero)
    }()

    // MARK: - VIEW MODEL
    var viewModel: CatsDetailScreenViewModel?

    // MARK: - OTHER PROPERTIES
    private let constants = CatsDetailScreenViewConstants()
    private typealias Localizables = CatsDetailScreenViewStrings

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
        buildDescriptionTitleLabel()
        buildDescriptionLabel()
        buildActivityIndicator()
        configureColors()
        configureLocalizables()
        configureImageView()
        configureLabels()
        configureActivityIndicator()
        configureDataBindingForDescriptionDateText()
        configureDataBindingForImageView()
        configureDataBindingForActivityIndicator()
    }

    private func configureColors() {
        view.backgroundColor = .backgroundColorHard
        imageView.backgroundColor = .backgroundColorLight
        creationDescriptionLabel.textColor = .primaryTextColor
        creationTitleLabel.textColor = .primaryTextColor
    }

    private func configureLocalizables() {
        creationTitleLabel.text = Localizables.creationDateTitle.localize
    }

    // MARK: - BUILD
    private func buildImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: .zero),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                              multiplier: constants.imageHeightFactor)
        ])
    }

    private func buildDescriptionTitleLabel() {
        creationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(creationTitleLabel)
        NSLayoutConstraint.activate([
            creationTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: constants.labelsLateralConstant),
            creationTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -constants.labelsLateralConstant),
            creationTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                                    constant: constants.labelTopConstant)
        ])
    }

    private func buildDescriptionLabel() {
        creationDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(creationDescriptionLabel)
        NSLayoutConstraint.activate([
            creationDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                              constant: constants.labelsLateralConstant),
            creationDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                               constant: -constants.labelsLateralConstant),
            creationDescriptionLabel.topAnchor.constraint(equalTo: creationTitleLabel.bottomAnchor,
                                                          constant: constants.labelTopConstant)
        ])
    }

    private func buildActivityIndicator() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }

    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    private func configureLabels() {
        creationTitleLabel.numberOfLines = .zero
        creationTitleLabel.font = .boldSystemFont(ofSize: constants.detailTitleFontSize)
        creationDescriptionLabel.numberOfLines = .zero
        creationDescriptionLabel.font = .systemFont(ofSize: constants.detailLabelFontSize)
    }

    private func configureActivityIndicator() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .primaryTextColor
        view.bringSubviewToFront(activityIndicatorView)
    }

    // MARK: - BINDING
    private func configureDataBindingForDescriptionDateText() {
        viewModel?
            .$descriptionDateText
            .assign(to: \.text,
                    on: creationDescriptionLabel)
            .store(in: &cancelables)
    }

    private func configureDataBindingForImageView() {
        viewModel?
            .$imageOfCat
            .receive(on: DispatchQueue.main)
            .assign(to: \.image,
                    on: imageView)
            .store(in: &cancelables)
    }

    private func configureDataBindingForActivityIndicator() {
        viewModel?
            .$isLoadingTheImage
            .sink(receiveValue: { [weak self] isAnimating in
                isAnimating ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
            })
            .store(in: &cancelables)
    }

}
