//
//  MajiangPaiShiTu.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 麻将牌视图
class MajiangPaiShiTu: UIView {
    let pai: MajiangPai
    private let tupianShiTu = UIImageView()
    private var shiXuanZhong = false

    init(pai: MajiangPai) {
        self.pai = pai
        super.init(frame: .zero)
        sheZhiJieMian()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func sheZhiJieMian() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4

        addSubview(tupianShiTu)
        tupianShiTu.image = UIImage(named: pai.tuPianMingCheng)
        tupianShiTu.contentMode = .scaleAspectFit
        tupianShiTu.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }

    // 设置选中状态
    func sheZhiXuanZhong(_ xuanZhong: Bool, dongHua: Bool = true) {
        shiXuanZhong = xuanZhong

        let bianHua = {
            if xuanZhong {
                self.transform = CGAffineTransform(translationX: 0, y: -15)
                self.layer.borderColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0).cgColor
                self.layer.borderWidth = 3
                self.layer.shadowColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0).cgColor
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 8
            } else {
                self.transform = .identity
                self.layer.borderColor = UIColor.darkGray.cgColor
                self.layer.borderWidth = 2
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.3
                self.layer.shadowRadius = 4
            }
        }

        if dongHua {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                bianHua()
            }
        } else {
            bianHua()
        }
    }

    var huoQuXuanZhongZhuangTai: Bool {
        return shiXuanZhong
    }
}
