//
//  PaparanNaikTaraf.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 升级视图控制器
class PaparanNaikTaraf: BaseViewController {
    private let jinBiLabel = UILabel()

    private let xueLiangKa = KadNaikTaraf()
    private let gongJiKa = KadNaikTaraf()
    private let fangYuKa = KadNaikTaraf()
    private let huiFuKa = KadNaikTaraf()

    private let pengurusPermainan = PengurusPermainan.gongXiang

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle("UPGRADE")
        setupBackButton()
        sheZhiJieMian()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gengXinJieMian()
    }

    private func sheZhiJieMian() {
        // 金币显示
        view.addSubview(jinBiLabel)
        jinBiLabel.textAlignment = .center
        jinBiLabel.font = UIFont.boldSystemFont(ofSize: 24)
        jinBiLabel.textColor = AppColors.gold
        jinBiLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        // 升级卡片容器
        let shangBuRongQi = UIStackView(arrangedSubviews: [xueLiangKa, gongJiKa])
        shangBuRongQi.axis = .horizontal
        shangBuRongQi.distribution = .fillEqually
        shangBuRongQi.spacing = 15

        let xiaBuRongQi = UIStackView(arrangedSubviews: [fangYuKa, huiFuKa])
        xiaBuRongQi.axis = .horizontal
        xiaBuRongQi.distribution = .fillEqually
        xiaBuRongQi.spacing = 15

        let zhuRongQi = UIStackView(arrangedSubviews: [shangBuRongQi, xiaBuRongQi])
        zhuRongQi.axis = .vertical
        zhuRongQi.distribution = .fillEqually
        zhuRongQi.spacing = 15

        view.addSubview(zhuRongQi)
        zhuRongQi.snp.makeConstraints { make in
            make.top.equalTo(jinBiLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }

        // 配置卡片
        peiZhiKaPian()
    }

    private func peiZhiKaPian() {
        xueLiangKa.peiZhi(
            biaoTi: "MAX HP",
            tubiao: "❤️",
            miaoShu: "+50 HP",
            jiGe: 100,
            dangQianZhi: { [weak self] in
                return self?.pengurusPermainan.pemain.maksimumNyawa ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.naikTarafNyawa()
            }
        )

        gongJiKa.peiZhi(
            biaoTi: "ATTACK",
            tubiao: "⚔️",
            miaoShu: "+10 ATK",
            jiGe: 100,
            dangQianZhi: { [weak self] in
                return self?.pengurusPermainan.pemain.kuasaSerangan ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.naikTarafSerangan()
            }
        )

        fangYuKa.peiZhi(
            biaoTi: "DEFENSE",
            tubiao: "🛡",
            miaoShu: "+3 DEF",
            jiGe: 100,
            dangQianZhi: { [weak self] in
                return self?.pengurusPermainan.pemain.kuasaPertahanan ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.naikTarafPertahanan()
            }
        )

        huiFuKa.peiZhi(
            biaoTi: "RECOVERY",
            tubiao: "✨",
            miaoShu: "+10 HEAL",
            jiGe: 100,
            dangQianZhi: { [weak self] in
                return self?.pengurusPermainan.pemain.jumlahPemulihan ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.naikTarafPemulihan()
            }
        )
    }

    private func gengXinJieMian() {
        jinBiLabel.text = "💰 Coins: \(pengurusPermainan.pemain.syiling)"
        xueLiangKa.gengXin()
        gongJiKa.gengXin()
        fangYuKa.gengXin()
        huiFuKa.gengXin()
    }

    // 升级方法
    private func naikTarafNyawa() {
        if pengurusPermainan.pemain.naikTarafNyawa(harga: 100) {
            pengurusPermainan.simpanData()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Max HP upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func naikTarafSerangan() {
        if pengurusPermainan.pemain.naikTarafSerangan(harga: 100) {
            pengurusPermainan.simpanData()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Attack upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func naikTarafPertahanan() {
        if pengurusPermainan.pemain.naikTarafPertahanan(harga: 100) {
            pengurusPermainan.simpanData()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Defense upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func naikTarafPemulihan() {
        if pengurusPermainan.pemain.naikTarafPemulihan(harga: 100) {
            pengurusPermainan.simpanData()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Recovery upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func xianShiChengGongTiShi(xiaoXi: String) {
        showSuccessDialog(message: xiaoXi)
    }

    private func xianShiShiBaiTiShi() {
        showErrorDialog(title: "Insufficient Coins", message: "You need more coins to upgrade!")
    }
}

// MARK: - 升级卡片
class KadNaikTaraf: UIView {
    private let biaoTiLabel = UILabel()
    private let tubiaoLabel = UILabel()
    private let dangQianZhiLabel = UILabel()
    private let miaoShuLabel = UILabel()
    private let shengJiAnNiu = ButangPermainan(tajuk: "Upgrade", gaya: .berjaya)
    private let jiGeLabel = UILabel()

    private var jiGe: Int = 0
    private var dangQianZhiHuoQu: (() -> Int)?
    private var shengJiHuiDiao: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        sheZhiJieMian()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func sheZhiJieMian() {
        backgroundColor = AppColors.cardBackground
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = AppColors.borderGold.cgColor

        // 图标
        addSubview(tubiaoLabel)
        tubiaoLabel.font = UIFont.systemFont(ofSize: 40)
        tubiaoLabel.textAlignment = .center
        tubiaoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }

        // 标题
        addSubview(biaoTiLabel)
        biaoTiLabel.font = UIFont.boldSystemFont(ofSize: 16)
        biaoTiLabel.textColor = AppColors.gold
        biaoTiLabel.textAlignment = .center
        biaoTiLabel.snp.makeConstraints { make in
            make.top.equalTo(tubiaoLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
        }

        // 当前值
        addSubview(dangQianZhiLabel)
        dangQianZhiLabel.font = UIFont.boldSystemFont(ofSize: 24)
        dangQianZhiLabel.textColor = AppColors.white
        dangQianZhiLabel.textAlignment = .center
        dangQianZhiLabel.snp.makeConstraints { make in
            make.top.equalTo(biaoTiLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }

        // 描述
        addSubview(miaoShuLabel)
        miaoShuLabel.font = UIFont.systemFont(ofSize: 12)
        miaoShuLabel.textColor = UIColor.lightGray
        miaoShuLabel.textAlignment = .center
        miaoShuLabel.snp.makeConstraints { make in
            make.top.equalTo(dangQianZhiLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
        }

        // 价格
        addSubview(jiGeLabel)
        jiGeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        jiGeLabel.textColor = AppColors.gold
        jiGeLabel.textAlignment = .center
        jiGeLabel.snp.makeConstraints { make in
            make.top.equalTo(miaoShuLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }

        // 升级按钮
        addSubview(shengJiAnNiu)
        shengJiAnNiu.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
        shengJiAnNiu.addTarget(self, action: #selector(anXiaShengJi), for: .touchUpInside)
    }

    func peiZhi(biaoTi: String, tubiao: String, miaoShu: String, jiGe: Int, dangQianZhi: @escaping () -> Int, shengJiHuiDiao: @escaping () -> Void) {
        self.biaoTiLabel.text = biaoTi
        self.tubiaoLabel.text = tubiao
        self.miaoShuLabel.text = miaoShu
        self.jiGe = jiGe
        self.jiGeLabel.text = "💰 \(jiGe)"
        self.dangQianZhiHuoQu = dangQianZhi
        self.shengJiHuiDiao = shengJiHuiDiao
        gengXin()
    }

    func gengXin() {
        if let zhi = dangQianZhiHuoQu?() {
            dangQianZhiLabel.text = "\(zhi)"
        }
    }

    @objc private func anXiaShengJi() {
        shengJiHuiDiao?()
    }
}
