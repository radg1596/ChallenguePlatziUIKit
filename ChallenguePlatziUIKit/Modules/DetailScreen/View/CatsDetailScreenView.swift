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
    private lazy var tagsLabelTitle: UILabel = {
        UILabel(frame: .zero)
    }()
    private lazy var tagsDescriptionListContentView: UIView = {
        UIView(frame: .zero)
    }()
    
    // MARK: - VIEW MODEL
    var viewModel: CatsDetailScreenViewModel?

    // MARK: - TAGS CONTROLLER
    private let tagsDisplayerController: TagsListHorizontalView = TagsListHorizontalView()

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
        buildTagsLabelTitle()
        buildTagsListContentView()
        configureColors()
        configureLocalizables()
        configureImageView()
        configureLabels()
        configureActivityIndicator()
        configureDataBindingForDescriptionDateText()
        configureDataBindingForImageView()
        configureDataBindingForActivityIndicator()
        addOneChild(viewController: tagsDisplayerController,
                    contentView: tagsDescriptionListContentView)
        configureDataBindingForTags()
    }
    
    private func configureColors() {
        view.backgroundColor = .backgroundColorHard
        imageView.backgroundColor = .backgroundColorLight
        creationDescriptionLabel.textColor = .primaryTextColor
        creationTitleLabel.textColor = .primaryTextColor
        tagsLabelTitle.textColor = .primaryTextColor
    }
    
    private func configureLocalizables() {
        creationTitleLabel.text = Localizables.creationDateTitle.localize
        tagsLabelTitle.text = Localizables.tagsLabelTitle.localize
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

    private func buildTagsLabelTitle() {
        tagsLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagsLabelTitle)
        NSLayoutConstraint.activate([
            tagsLabelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: constants.labelsLateralConstant),
            tagsLabelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -constants.labelsLateralConstant),
            tagsLabelTitle.topAnchor.constraint(equalTo: creationDescriptionLabel.bottomAnchor,
                                                constant: constants.labelTopConstant)
        ])
    }

    private func buildTagsListContentView() {
        tagsDescriptionListContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagsDescriptionListContentView)
        NSLayoutConstraint.activate([
            tagsDescriptionListContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                    constant: constants.labelsLateralConstant),
            tagsDescriptionListContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                     constant: -constants.labelsLateralConstant),
            tagsDescriptionListContentView.topAnchor.constraint(equalTo: tagsLabelTitle.bottomAnchor,
                                                                constant: constants.labelTopConstant),
            tagsDescriptionListContentView.heightAnchor.constraint(equalToConstant: constants.tagControllerHeight)
        ])
    }

    // MARK: - CONFIG
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    private func configureLabels() {
        creationTitleLabel.numberOfLines = .zero
        creationTitleLabel.font = .boldSystemFont(ofSize: constants.detailTitleFontSize)
        creationDescriptionLabel.numberOfLines = .zero
        creationDescriptionLabel.font = .systemFont(ofSize: constants.detailLabelFontSize)
        tagsLabelTitle.numberOfLines = .zero
        tagsLabelTitle.font = .boldSystemFont(ofSize: constants.detailTitleFontSize)
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

    private func configureDataBindingForTags() {
        viewModel?
            .$tags
            .sink(receiveValue: { [weak self] tags in
                self?.tagsDisplayerController.reload(tags: tags)
            })
            .store(in: &cancelables)
    }

}
