//
//  ZiDingYiTanKuang.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 自定义弹框
class ZiDingYiTanKuang: UIView {
    private let neiRongShiTu = UIView()
    private let biaoTiLabel = UILabel()
    private let xiaoXiLabel = UILabel()
    private let anNiuRongQi = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        sheZhiJieMian()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func sheZhiJieMian() {
        backgroundColor = UIColor.black.withAlphaComponent(0.7)

        // 内容视图
        addSubview(neiRongShiTu)
        neiRongShiTu.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 1.0)
        neiRongShiTu.layer.cornerRadius = 20
        neiRongShiTu.layer.borderWidth = 3
        neiRongShiTu.layer.borderColor = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        neiRongShiTu.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }

        // 标题
        neiRongShiTu.addSubview(biaoTiLabel)
        biaoTiLabel.textAlignment = .center
        biaoTiLabel.font = UIFont.boldSystemFont(ofSize: 24)
        biaoTiLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        biaoTiLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        // 消息
        neiRongShiTu.addSubview(xiaoXiLabel)
        xiaoXiLabel.textAlignment = .center
        xiaoXiLabel.font = UIFont.systemFont(ofSize: 16)
        xiaoXiLabel.textColor = .white
        xiaoXiLabel.numberOfLines = 0
        xiaoXiLabel.snp.makeConstraints { make in
            make.top.equalTo(biaoTiLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        // 按钮容器
        neiRongShiTu.addSubview(anNiuRongQi)
        anNiuRongQi.axis = .horizontal
        anNiuRongQi.distribution = .fillEqually
        anNiuRongQi.spacing = 10
        anNiuRongQi.snp.makeConstraints { make in
            make.top.equalTo(xiaoXiLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }

    // 显示弹框
    func xianShi(zaiShiTu shiTu: UIView, biaoTi: String, xiaoXi: String, anNius: [(String, UIColor, () -> Void)]) {
        biaoTiLabel.text = biaoTi
        xiaoXiLabel.text = xiaoXi

        // 清空旧按钮
        anNiuRongQi.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // 添加新按钮
        for (wenZi, yanse, dongZuo) in anNius {
            let anNiu = chuangJianAnNiu(wenZi: wenZi, yanse: yanse, dongZuo: dongZuo)
            anNiuRongQi.addArrangedSubview(anNiu)
        }

        shiTu.addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // 动画显示
        alpha = 0
        neiRongShiTu.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.alpha = 1
            self.neiRongShiTu.transform = .identity
        }
    }

    // 关闭弹框
    func guanBi(wanCheng: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.neiRongShiTu.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.removeFromSuperview()
            wanCheng?()
        }
    }

    private func chuangJianAnNiu(wenZi: String, yanse: UIColor, dongZuo: @escaping () -> Void) -> UIButton {
        let anNiu = UIButton(type: .system)
        anNiu.setTitle(wenZi, for: .normal)
        anNiu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        anNiu.setTitleColor(.white, for: .normal)
        anNiu.backgroundColor = yanse
        anNiu.layer.cornerRadius = 10
        anNiu.layer.shadowColor = yanse.cgColor
        anNiu.layer.shadowOffset = CGSize(width: 0, height: 4)
        anNiu.layer.shadowOpacity = 0.5
        anNiu.layer.shadowRadius = 8

        anNiu.addAction(UIAction { [weak self] _ in
            dongZuo()
            self?.guanBi()
        }, for: .touchUpInside)

        return anNiu
    }
}
