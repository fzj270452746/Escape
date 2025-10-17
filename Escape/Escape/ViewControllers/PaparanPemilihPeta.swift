//
//  PaparanPemilihPeta.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 地图选择视图控制器
class PaparanPemilihPeta: BaseViewController {
    private let lieBiaoShiTu = UITableView()
    private let pengurusPermainan = PengurusPermainan.gongXiang

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle("SELECT MAP")
        setupBackButton()
        sheZhiJieMian()
    }

    private func sheZhiJieMian() {

        // 列表
        view.addSubview(lieBiaoShiTu)
        lieBiaoShiTu.delegate = self
        lieBiaoShiTu.dataSource = self
        lieBiaoShiTu.backgroundColor = .clear
        lieBiaoShiTu.separatorStyle = .none
        lieBiaoShiTu.register(SelPeta.self, forCellReuseIdentifier: "SelPeta")
        lieBiaoShiTu.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PaparanPemilihPeta: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pengurusPermainan.suoYouDiTu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sel = tableView.dequeueReusableCell(withIdentifier: "SelPeta", for: indexPath) as! SelPeta
        let peta = pengurusPermainan.suoYouDiTu[indexPath.row]
        let adakahDibuka = indexPath.row < pengurusPermainan.pemain.jumlahPetaDibuka
        sel.peiZhi(peta: peta, adakahDibuka: adakahDibuka)
        return sel
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let peta = pengurusPermainan.suoYouDiTu[indexPath.row]
        let adakahDibuka = indexPath.row < pengurusPermainan.pemain.jumlahPetaDibuka

        if adakahDibuka {
            // 进入游戏
            let adegan = PaparanAdegan(peta: peta)
            adegan.modalPresentationStyle = .fullScreen
            present(adegan, animated: true)
        } else {
            // 显示未解锁提示
            showInfoDialog(title: "Locked", message: "Complete the previous map to unlock this one!")
        }
    }
}

// MARK: - 地图单元格
class SelPeta: UITableViewCell {
    private let rongQiShiTu = UIView()
    private let mingChengLabel = UILabel()
    private let miaoShuLabel = UILabel()
    private let bossLabel = UILabel()
    private let xueLiangLabel = UILabel()
    private let jiangLiLabel = UILabel()
    private let suoIcon = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sheZhiJieMian()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func sheZhiJieMian() {
        backgroundColor = .clear
        selectionStyle = .none

        // 容器
        contentView.addSubview(rongQiShiTu)
        rongQiShiTu.backgroundColor = AppColors.cardBackground
        rongQiShiTu.layer.cornerRadius = 15
        rongQiShiTu.layer.borderWidth = 2
        rongQiShiTu.layer.borderColor = AppColors.borderGold.cgColor
        rongQiShiTu.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        }

        // 名称
        rongQiShiTu.addSubview(mingChengLabel)
        mingChengLabel.font = UIFont.boldSystemFont(ofSize: 20)
        mingChengLabel.textColor = AppColors.gold
        mingChengLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
        }

        // 描述
        rongQiShiTu.addSubview(miaoShuLabel)
        miaoShuLabel.font = UIFont.systemFont(ofSize: 14)
        miaoShuLabel.textColor = UIColor.lightGray
        miaoShuLabel.numberOfLines = 2
        miaoShuLabel.snp.makeConstraints { make in
            make.top.equalTo(mingChengLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }

        // Boss信息
        rongQiShiTu.addSubview(bossLabel)
        bossLabel.font = UIFont.boldSystemFont(ofSize: 14)
        bossLabel.textColor = AppColors.enemyRed
        bossLabel.snp.makeConstraints { make in
            make.top.equalTo(miaoShuLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(15)
        }

        // 血量
        rongQiShiTu.addSubview(xueLiangLabel)
        xueLiangLabel.font = UIFont.systemFont(ofSize: 12)
        xueLiangLabel.textColor = AppColors.white
        xueLiangLabel.snp.makeConstraints { make in
            make.top.equalTo(bossLabel.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(15)
        }

        // 奖励
        rongQiShiTu.addSubview(jiangLiLabel)
        jiangLiLabel.font = UIFont.boldSystemFont(ofSize: 14)
        jiangLiLabel.textColor = AppColors.gold
        jiangLiLabel.snp.makeConstraints { make in
            make.centerY.equalTo(xueLiangLabel)
            make.right.equalToSuperview().offset(-15)
        }

        // 锁图标
        rongQiShiTu.addSubview(suoIcon)
        suoIcon.text = "🔒"
        suoIcon.font = UIFont.systemFont(ofSize: 40)
        suoIcon.isHidden = true
        suoIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }

    func peiZhi(peta: MaklumatPeta, adakahDibuka: Bool) {
        mingChengLabel.text = peta.nama
        miaoShuLabel.text = peta.penerangan
        bossLabel.text = "Boss: \(peta.namaBoss)"
        xueLiangLabel.text = "HP: \(peta.nyawaBoss) | ATK: \(peta.seranganBoss)"
        jiangLiLabel.text = "💰 \(peta.syilingGanjaran)"

        if adakahDibuka {
            suoIcon.isHidden = true
            rongQiShiTu.alpha = 1.0
        } else {
            suoIcon.isHidden = false
            rongQiShiTu.alpha = 0.5
        }
    }
}
