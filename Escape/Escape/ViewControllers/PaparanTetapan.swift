//
//  PaparanTetapan.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 设置视图控制器
class PaparanTetapan: BaseViewController {
    private let gunDongShiTu = UIScrollView()
    private let neiRongShiTu = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle("SETTINGS")
        setupBackButton()
        sheZhiJieMian()
    }

    private func sheZhiJieMian() {
        // 滚动视图
        view.addSubview(gunDongShiTu)
        gunDongShiTu.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
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
        return UIView.createCardContainer(cornerRadius: 15, borderWidth: 2)
    }

    private func chuangJianBiaoTi(wenZi: String) -> UILabel {
        return UIView.createLabel(text: wenZi, fontSize: 18, color: AppColors.gold, isBold: true)
    }

    private func chuangJianNeiRongWenZi(wenZi: String) -> UILabel {
        return UIView.createLabel(text: wenZi, fontSize: 14, color: AppColors.white)
    }

    private func tiJiaoFanKui(neiRong: String) {
        showSuccessDialog(title: "Thank You!", message: "Your feedback has been saved locally.")
        UserDefaults.standard.set(neiRong, forKey: "userFeedback_\(Date().timeIntervalSince1970)")
    }

    private func pingFen(fenShu: Int) {
        showSuccessDialog(title: "Thank You!", message: "You rated us \(fenShu) star\(fenShu > 1 ? "s" : "")!")
        UserDefaults.standard.set(fenShu, forKey: "userRating")
    }

    @objc private func chongZhiYouXi() {
        showConfirmDialog(
            title: "Warning!",
            message: "This will reset all your progress. Are you sure?",
            onConfirm: { [weak self] in
                PengurusPermainan.gongXiang.setelSemulakanPermainan()
                self?.showSuccessDialog(title: "Reset Complete", message: "Your game data has been reset.")
            }
        )
    }
}
