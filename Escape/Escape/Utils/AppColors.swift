//
//  AppColors.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit

struct AppColors {
    // MARK: - Primary Colors
    static let gold = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
    static let borderGold = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0)

    // MARK: - Background Colors
    static let darkBackground = UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 0.9)
    static let cardBackground = UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 0.9)

    // MARK: - Gradient Colors
    static let gradientTop = UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0)
    static let gradientBottom = UIColor(red: 0.15, green: 0.1, blue: 0.25, alpha: 1.0)

    static var gradientColors: [CGColor] {
        return [gradientTop.cgColor, gradientBottom.cgColor]
    }

    // MARK: - Semantic Colors
    static let playerBlue = UIColor(red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0)
    static let enemyRed = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0)
    static let white = UIColor.white

    // MARK: - Button Colors
    static let primaryButton = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0)
    static let secondaryButton = UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0)
    static let dangerButton = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
    static let successButton = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0)

    // MARK: - Turn Indicator Colors
    static let playerTurnBackground = UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 0.9)
    static let enemyTurnBackground = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 0.9)

    // MARK: - Progress Bar Colors
    static let healthGreen = UIColor(red: 0.2, green: 0.8, blue: 0.3, alpha: 1.0)
    static let healthYellow = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
    static let healthRed = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0)
}
