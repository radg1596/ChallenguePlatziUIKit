//
//  LottiePlayerView.swift
//  ChallenguePlatziUIKit
//
//  Created by Ricardo Desiderio on 14/01/23.
//

import UIKit
import Lottie

/**
 Abstract:
    Abstraction of class that play a lottie json, using a custom UIView as content.
    Expose some methods, `startAnimating` and `stopAnimating` to manage the play of lottie
    Has properties, `lottieName` for the name of the json file in the `main` `Bundle`
    And `animationSpeed`, to manipulate the speed of animation
 */
class LottiePlayerView: UIView  {
    
    //MARK: - INSPECTABLES
    /// The animation speed for the lottie, for example 1.0
    private var animationSpeed: CGFloat = LottiePlayerViewConstants().defaultSpeed

    // MARK: - PROPERTIES
    /// View of the animation
    private var animationView: LottieAnimationView?

    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError(AppGeneralErrorStrings.canNotBuildViewError.localize)
    }

    //MARK: METHODS
    /// Starts to play the lottie animation, using the lottie defined by the name in the inspectable
    func startAnimating(lottieFileName: String) {
        self.animationView = LottieAnimationView(name: lottieFileName)
        if let animationView = self.animationView {
            animationView.translatesAutoresizingMaskIntoConstraints = false
            animationView.contentMode = .scaleToFill
            animationView.loopMode = .loop
            animationView.animationSpeed = animationSpeed
            animationView.backgroundBehavior = .pauseAndRestore
            addSubview(animationView)
            NSLayoutConstraint.activate([
                animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
                animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
                animationView.topAnchor.constraint(equalTo: topAnchor),
                animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            animationView.play()
        }
    }

    //MARK: Stop the animation
    /// Stops if exist the current lottie animation of the view
    func stopAnimating() {
        if let animationView = self.animationView {
            animationView.stop()
            animationView.removeFromSuperview()
        }
    }

    //MARK: Deinit
    deinit {
        /// Release animation on deinit
        self.stopAnimating()
    }

}
