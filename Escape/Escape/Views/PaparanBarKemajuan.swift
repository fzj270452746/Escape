//
//  PaparanBarKemajuan.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 进度条视图（用于显示血量）
class PaparanBarKemajuan: UIView {
    private let beiJingShiTu = UIView()
    private let jinDuShiTu = UIView()
    private let wenZiLabel = UILabel()

    private var dangQianJinDu: CGFloat = 1.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        sheZhiJieMian()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func sheZhiJieMian() {
        // 背景
        addSubview(beiJingShiTu)
        beiJingShiTu.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        beiJingShiTu.layer.cornerRadius = 10
        beiJingShiTu.layer.borderWidth = 2
        beiJingShiTu.layer.borderColor = UIColor.black.cgColor
        beiJingShiTu.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // 进度
        beiJingShiTu.addSubview(jinDuShiTu)
        jinDuShiTu.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        jinDuShiTu.layer.cornerRadius = 8
        jinDuShiTu.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(2)
            make.width.equalToSuperview().multipliedBy(1.0).offset(-4)
        }

        // 文字
        addSubview(wenZiLabel)
        wenZiLabel.textAlignment = .center
        wenZiLabel.font = UIFont.boldSystemFont(ofSize: 14)
        wenZiLabel.textColor = .white
        wenZiLabel.layer.shadowColor = UIColor.black.cgColor
        wenZiLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        wenZiLabel.layer.shadowOpacity = 1.0
        wenZiLabel.layer.shadowRadius = 2
        wenZiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // 更新进度
    func kemaskini(_ jinDu: CGFloat, dongHua: Bool = true) {
        dangQianJinDu = max(0, min(1.0, jinDu))

        jinDuShiTu.snp.remakeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(2)
            make.width.equalToSuperview().multipliedBy(dangQianJinDu).offset(-4)
        }

        // 根据血量改变颜色
        let yanse: UIColor
        if dangQianJinDu > 0.6 {
            yanse = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        } else if dangQianJinDu > 0.3 {
            yanse = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        } else {
            yanse = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
        }
        jinDuShiTu.backgroundColor = yanse

        if dongHua {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }

    // 设置文字
    func tetapkanTeks(_ teks: String) {
        wenZiLabel.text = teks
    }
}
