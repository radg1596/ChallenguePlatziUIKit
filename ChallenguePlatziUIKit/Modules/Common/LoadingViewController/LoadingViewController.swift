//
//  LoadingViewController.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 14/01/23.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK: - SUB VIEWS
    private lazy var lottieView: LottiePlayerView = {
        LottiePlayerView(frame: .zero)
    }()

    // MARK: - CONSTANTS
    private let constants = LoadingViewControllerConstants()

    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .primaryTextColor.withAlphaComponent(constants.alphaForView)
        buildLottieView()
        lottieView.startAnimating(lottieFileName: constants.loadingLottieCat)
    }

    // MARK: - BUILD
    private func buildLottieView() {
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieView)
        NSLayoutConstraint.activate([
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottieView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                              multiplier: constants.widthFactor),
            lottieView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                               multiplier: constants.heightFactor)
        ])
    }

}
