//
//  UIView+Factory.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit

// View Factory Extension - Common view creation helpers
extension UIView {

    // MARK: - Label Factory
    static func createLabel(text: String = "", fontSize: CGFloat = 16, color: UIColor = .white, alignment: NSTextAlignment = .left, isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = 0
        return label
    }

    static func createTitleLabel(text: String, fontSize: CGFloat = 28, color: UIColor = AppColors.gold) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.textColor = color
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 10
        return label
    }

    // MARK: - Container Factory
    static func createCardContainer(cornerRadius: CGFloat = 20, borderWidth: CGFloat = 3) -> UIView {
        let container = UIView()
        container.backgroundColor = AppColors.cardBackground
        container.layer.cornerRadius = cornerRadius
        container.layer.borderWidth = borderWidth
        container.layer.borderColor = AppColors.borderGold.cgColor
        return container
    }

    static func createStackView(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 10, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        return stackView
    }

    // MARK: - Button Factory
    static func createButton(title: String, backgroundColor: UIColor, titleColor: UIColor = .white, cornerRadius: CGFloat = 10) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.layer.shadowColor = backgroundColor.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 8
        return button
    }

    // MARK: - View Styling Helpers
    func addShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: 4), radius: CGFloat = 8) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }

    func addBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    // MARK: - Gradient Factory
    static func createGradientLayer(colors: [CGColor], locations: [NSNumber]? = nil) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        return gradientLayer
    }
}
