//
//  ButangPermainan.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit

// 游戏按钮
class ButangPermainan: UIButton {
    enum GayaButang {
        case utama    // 主要按钮（金色）
        case kedua     // 次要按钮（蓝色）
        case bahaya   // 危险按钮（红色）
        case berjaya // 成功按钮（绿色）
    }

    init(tajuk: String, gaya: GayaButang = .utama) {
        super.init(frame: .zero)
        sheZhiJieMian(tajuk: tajuk, gaya: gaya)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func sheZhiJieMian(tajuk: String, gaya: GayaButang) {
        setTitle(tajuk, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 12

        let yanse: UIColor
        switch gaya {
        case .utama:
            yanse = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0)
        case .kedua:
            yanse = UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0)
        case .bahaya:
            yanse = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        case .berjaya:
            yanse = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0)
        }

        backgroundColor = yanse
        layer.shadowColor = yanse.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8

        // 添加按下效果
        addTarget(self, action: #selector(anNiuAnXia), for: .touchDown)
        addTarget(self, action: #selector(anNiuSongKai), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }

    @objc private func anNiuAnXia() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.alpha = 0.8
        }
    }

    @objc private func anNiuSongKai() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.alpha = 1.0
        }
    }

    // 禁用状态
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
