//
//  TagsListCollectionViewCell.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 15/01/23.
//

import UIKit

class TagsListCollectionViewCell: UICollectionViewCell {

    // MARK: - SUBVIEWS
    private lazy var labelBackView: UIView = {
        UIView(frame: .zero)
    }()
    private lazy var principalContentLabel: UILabel = {
        let label =  UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: constants.tagLabelFontSize)
        return label
    }()

    // MARK: - CONSTANTS
    private let constants = TagsListCollectionViewCellConstants()

    // MARK: - VIEW LIFE CYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError(AppGeneralErrorStrings.canNotBuildViewError.localize)
    }

    // MARK: - REUSE
    override func prepareForReuse() {
        super.prepareForReuse()
        principalContentLabel.text = String()
    }

    // MARK: - UI
    private func configureUI() {
        buildLabelBackView()
        buildPrincipalContentLabel()
        configureColors()
        configureContentView()
    }

    private func configureColors() {
        backgroundColor = .backgroundColorLight
        labelBackView.backgroundColor = .backgroundColorHard
    }

    // MARK: - SET
    func setTag(text: String) {
        principalContentLabel.text = text
        principalContentLabel.textColor = AppGeneralConstants.tagsColors.randomElement() ?? .white
    }

    // MARK: - BUILD
    private func buildLabelBackView() {
        labelBackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelBackView)
        NSLayoutConstraint.activate([
            labelBackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelBackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelBackView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: constants.labelTopConstant),
            labelBackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: -constants.labelTopConstant)
        ])
    }

    private func buildPrincipalContentLabel() {
        principalContentLabel.translatesAutoresizingMaskIntoConstraints = false
        labelBackView.addSubview(principalContentLabel)
        NSLayoutConstraint.activate([
            principalContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                           constant: constants.contentLateralConstant),
            principalContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                            constant: -constants.contentLateralConstant),
            principalContentLabel.topAnchor.constraint(equalTo: labelBackView.topAnchor),
            principalContentLabel.bottomAnchor.constraint(equalTo: labelBackView.bottomAnchor)
        ])
    }

    // MARK: - CONFIGURATIONS
    private func configureContentView() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: constants.cellHeight)
        ])
        labelBackView.layer.masksToBounds = true
        labelBackView.layer.cornerRadius = constants.labelContentViewRadius
    }

}
