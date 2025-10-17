//
//  PaparanTetapan.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 设置视图控制器
class PaparanTetapan: UIViewController {
    private let beiJingTuCeng = CAGradientLayer()
    private let biaoTiLabel = UILabel()
    private let fanHuiAnNiu = ButangPermainan(tajuk: "← Back", gaya: .kedua)
    private let gunDongShiTu = UIScrollView()
    private let neiRongShiTu = UIView()

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
        biaoTiLabel.text = "SETTINGS"
        biaoTiLabel.textAlignment = .center
        biaoTiLabel.font = UIFont.boldSystemFont(ofSize: 28)
        biaoTiLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        biaoTiLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
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

        // 滚动视图
        view.addSubview(gunDongShiTu)
        gunDongShiTu.snp.makeConstraints { make in
            make.top.equalTo(biaoTiLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        gunDongShiTu.addSubview(neiRongShiTu)
        neiRongShiTu.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        // 内容区域
        tianjiaShezhineirong()
    }

    private func tianjiaShezhineirong() {
        // 游戏说明部分
        let wanFaKuang = chuangJianXinXiKuang()
        neiRongShiTu.addSubview(wanFaKuang)
        wanFaKuang.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        let wanFaBiaoTi = chuangJianBiaoTi(wenZi: "HOW TO PLAY")
        wanFaKuang.addSubview(wanFaBiaoTi)
        wanFaBiaoTi.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(15)
        }

        let wanFaWenZi = chuangJianNeiRongWenZi(wenZi: """
        ═══ GAME OBJECTIVE ═══
        Battle through 15 challenging maps, defeating minions and bosses using strategic mahjong tile combinations!

        ═══ TILE TYPES ═══
        • Number Tiles : Deal damage to enemies
        • Special Tiles : Restore your HP
        • 4 copies of each tile in the deck (124 total)

        ═══ TURN SYSTEM ═══
        1. Draw 6 random tiles each turn
        2. Tiles are auto-sorted: 万 → 筒 → 条 → Special
        3. Select tiles to form valid combinations
        4. Click "Attack" to play your combo
        5. Enemy attacks after your turn

        ═══ TILE COMBINATIONS ═══
        → Pair (2 same tiles)
           Damage: 1x Base Attack (20)
           Heal: 1x Base Recovery (5)

        → Triple (3 same tiles)
           Damage: 2x Base Attack (40)
           Heal: 2x Base Recovery (10)

        → Quad (4 same tiles)
           Damage: 3x Base Attack (60)
           Heal: 3x Base Recovery (15)

        → Straight (3 consecutive numbers)
           Damage: 1.5x Base Attack (30)
           Only works with number tiles of same suit

        ═══ COMBAT MECHANICS ═══
        • Damage Formula: Enemy receives (Your ATK × Multiplier)
        • Defense Formula: You take max(0, Enemy ATK - Your DEF)
        • Each turn: 1 attack OR skip turn
        • Played tiles are removed from hand
        • Remaining tiles become unplayable until next turn

        ═══ PROGRESSION ═══
        • Complete maps to unlock new challenges
        • Defeat minions before facing the boss
        • Earn coins to upgrade your stats
        • 15 maps with increasing difficulty

        ═══ UPGRADES (100 coins each) ═══
        • Max HP: +50 per upgrade
        • Attack: +10 per upgrade
        • Defense: +3 per upgrade
        • Recovery: +10 per upgrade

        ═══ TIPS & STRATEGY ═══
        ✓ Save special tiles for emergencies
        ✓ Upgrade attack early for faster battles
        ✓ Balance offense and defense
        ✓ Plan combos before selecting tiles
        ✓ Use quads for quick boss takedowns
        """)
        wanFaKuang.addSubview(wanFaWenZi)
        wanFaWenZi.snp.makeConstraints { make in
            make.top.equalTo(wanFaBiaoTi.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-15)
        }

        // 反馈部分
        let fanKuiKuang = chuangJianXinXiKuang()
        neiRongShiTu.addSubview(fanKuiKuang)
        fanKuiKuang.snp.makeConstraints { make in
            make.top.equalTo(wanFaKuang.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        let fanKuiBiaoTi = chuangJianBiaoTi(wenZi: "FEEDBACK")
        fanKuiKuang.addSubview(fanKuiBiaoTi)
        fanKuiBiaoTi.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(15)
        }

        let shuRuKuang = UITextView()
        shuRuKuang.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.15, alpha: 1.0)
        shuRuKuang.textColor = .white
        shuRuKuang.font = UIFont.systemFont(ofSize: 14)
        shuRuKuang.layer.cornerRadius = 8
        shuRuKuang.layer.borderWidth = 1
        shuRuKuang.layer.borderColor = UIColor.gray.cgColor
        shuRuKuang.text = "Enter your feedback here..."
        shuRuKuang.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        fanKuiKuang.addSubview(shuRuKuang)
        shuRuKuang.snp.makeConstraints { make in
            make.top.equalTo(fanKuiBiaoTi.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }

        let tiJiaoAnNiu = ButangPermainan(tajuk: "Submit", gaya: .berjaya)
        fanKuiKuang.addSubview(tiJiaoAnNiu)
        tiJiaoAnNiu.snp.makeConstraints { make in
            make.top.equalTo(shuRuKuang.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-15)
        }
        tiJiaoAnNiu.addAction(UIAction { [weak self, weak shuRuKuang] _ in
            self?.tiJiaoFanKui(neiRong: shuRuKuang?.text ?? "")
        }, for: .touchUpInside)

        // 评分部分
        let pingFenKuang = chuangJianXinXiKuang()
        neiRongShiTu.addSubview(pingFenKuang)
        pingFenKuang.snp.makeConstraints { make in
            make.top.equalTo(fanKuiKuang.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        let pingFenBiaoTi = chuangJianBiaoTi(wenZi: "RATE OUR GAME")
        pingFenKuang.addSubview(pingFenBiaoTi)
        pingFenBiaoTi.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(15)
        }

        let xingXingRongQi = UIStackView()
        xingXingRongQi.axis = .horizontal
        xingXingRongQi.distribution = .fillEqually
        xingXingRongQi.spacing = 10
        for i in 1...5 {
            let xingXingAnNiu = UIButton(type: .system)
            xingXingAnNiu.setTitle("⭐️", for: .normal)
            xingXingAnNiu.titleLabel?.font = UIFont.systemFont(ofSize: 36)
            xingXingAnNiu.tag = i
            xingXingAnNiu.addAction(UIAction { [weak self] _ in
                self?.pingFen(fenShu: i)
            }, for: .touchUpInside)
            xingXingRongQi.addArrangedSubview(xingXingAnNiu)
        }

        pingFenKuang.addSubview(xingXingRongQi)
        xingXingRongQi.snp.makeConstraints { make in
            make.top.equalTo(pingFenBiaoTi.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }

        // 重置按钮
        let chongZhiAnNiu = ButangPermainan(tajuk: "Reset Game Data", gaya: .bahaya)
        neiRongShiTu.addSubview(chongZhiAnNiu)
        chongZhiAnNiu.snp.makeConstraints { make in
            make.top.equalTo(pingFenKuang.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-30)
        }
        chongZhiAnNiu.addTarget(self, action: #selector(chongZhiYouXi), for: .touchUpInside)
    }

    private func chuangJianXinXiKuang() -> UIView {
        let kuang = UIView()
        kuang.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 0.9)
        kuang.layer.cornerRadius = 15
        kuang.layer.borderWidth = 2
        kuang.layer.borderColor = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 0.5).cgColor
        return kuang
    }

    private func chuangJianBiaoTi(wenZi: String) -> UILabel {
        let label = UILabel()
        label.text = wenZi
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        return label
    }

    private func chuangJianNeiRongWenZi(wenZi: String) -> UILabel {
        let label = UILabel()
        label.text = wenZi
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }

    private func tiJiaoFanKui(neiRong: String) {
        // 这里可以实现真实的反馈提交逻辑
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: "Thank You!",
            kandungan: "Your feedback has been saved locally.",
            anNius: [("OK", UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0), {})]
        )

        // 保存到UserDefaults
        UserDefaults.standard.set(neiRong, forKey: "userFeedback_\(Date().timeIntervalSince1970)")
    }

    private func pingFen(fenShu: Int) {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: "Thank You!",
            kandungan: "You rated us \(fenShu) star\(fenShu > 1 ? "s" : "")!",
            anNius: [("OK", UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0), {})]
        )

        UserDefaults.standard.set(fenShu, forKey: "userRating")
    }

    @objc private func chongZhiYouXi() {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: "Warning!",
            kandungan: "This will reset all your progress. Are you sure?",
            anNius: [
                ("Cancel", UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0), {}),
                ("Reset", UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), { [weak self] in
                    PengurusPermainan.gongXiang.setelSemulakanPermainan()
                    self?.xianShiChongZhiChengGong()
                })
            ]
        )
    }

    private func xianShiChongZhiChengGong() {
        let dialog = DialogTersuai()
        dialog.tunjuk(
            zaiShiTu: view,
            tajuk: "Reset Complete",
            kandungan: "Your game data has been reset.",
            anNius: [("OK", UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0), {})]
        )
    }

    @objc private func fanHui() {
        dismiss(animated: true)
    }
}
