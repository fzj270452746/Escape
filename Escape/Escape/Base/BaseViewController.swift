//
//  BaseViewController.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    // MARK: - UI Components
    private let gradientLayer = CAGradientLayer()
    let titleLabel = UILabel()
    lazy var backButton = ButangPermainan(tajuk: "← Back", gaya: .kedua)

    // MARK: - Properties
    var gradientColors: [CGColor] {
        return AppColors.gradientColors
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // MARK: - Setup Methods
    private func setupGradientBackground() {
        gradientLayer.colors = gradientColors
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func setupTitle(_ text: String, fontSize: CGFloat = 28) {
        view.addSubview(titleLabel)
        titleLabel.text = text
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        titleLabel.textColor = AppColors.gold
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    func setupBackButton(action: Selector? = nil) {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }

        let targetAction = action ?? #selector(dismissViewController)
        backButton.addTarget(self, action: targetAction, for: .touchUpInside)
    }

    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
