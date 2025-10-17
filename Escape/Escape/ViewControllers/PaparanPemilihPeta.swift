//
//  PaparanPemilihPeta.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 地图选择视图控制器
class PaparanPemilihPeta: UIViewController {
    private let beiJingTuCeng = CAGradientLayer()
    private let biaoTiLabel = UILabel()
    private let fanHuiAnNiu = ButangPermainan(tajuk: "← Back", gaya: .kedua)
    private let lieBiaoShiTu = UITableView()

    private let pengurusPermainan = PengurusPermainan.gongXiang

    override func viewDidLoad() {
        super.viewDidLoad()
        sheZhiJieMian()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        beiJingTuCeng.frame = view.bounds
    }

    private func sheZhiJieMian() {
        // 渐变背景
        beiJingTuCeng.colors = [
            UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0).cgColor,
            UIColor(red: 0.15, green: 0.1, blue: 0.25, alpha: 1.0).cgColor
        ]
        view.layer.insertSublayer(beiJingTuCeng, at: 0)

        // 标题
        view.addSubview(biaoTiLabel)
        biaoTiLabel.text = "SELECT MAP"
        biaoTiLabel.textAlignment = .center
        biaoTiLabel.font = UIFont.boldSystemFont(ofSize: 28)
        biaoTiLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        biaoTiLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        // 返回按钮
        view.addSubview(fanHuiAnNiu)
        fanHuiAnNiu.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        fanHuiAnNiu.addTarget(self, action: #selector(fanHui), for: .touchUpInside)

        // 列表
        view.addSubview(lieBiaoShiTu)
        lieBiaoShiTu.delegate = self
        lieBiaoShiTu.dataSource = self
        lieBiaoShiTu.backgroundColor = .clear
        lieBiaoShiTu.separatorStyle = .none
        lieBiaoShiTu.register(SelPeta.self, forCellReuseIdentifier: "SelPeta")
        lieBiaoShiTu.snp.makeConstraints { make in
            make.top.equalTo(biaoTiLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }

    @objc private func fanHui() {
        dismiss(animated: true)
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
            let dialog = DialogTersuai()
            dialog.tunjuk(
                zaiShiTu: view,
                tajuk: "Locked",
                kandungan: "Complete the previous map to unlock this one!",
                anNius: [("OK", UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0), {})]
            )
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
        rongQiShiTu.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 0.9)
        rongQiShiTu.layer.cornerRadius = 15
        rongQiShiTu.layer.borderWidth = 2
        rongQiShiTu.layer.borderColor = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        rongQiShiTu.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        }

        // 名称
        rongQiShiTu.addSubview(mingChengLabel)
        mingChengLabel.font = UIFont.boldSystemFont(ofSize: 20)
        mingChengLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
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
        bossLabel.textColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0)
        bossLabel.snp.makeConstraints { make in
            make.top.equalTo(miaoShuLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(15)
        }

        // 血量
        rongQiShiTu.addSubview(xueLiangLabel)
        xueLiangLabel.font = UIFont.systemFont(ofSize: 12)
        xueLiangLabel.textColor = .white
        xueLiangLabel.snp.makeConstraints { make in
            make.top.equalTo(bossLabel.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(15)
        }

        // 奖励
        rongQiShiTu.addSubview(jiangLiLabel)
        jiangLiLabel.font = UIFont.boldSystemFont(ofSize: 14)
        jiangLiLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
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
