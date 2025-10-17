//
//  YouXiChangJingShiTu.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 游戏场景视图控制器
class YouXiChangJingShiTu: UIViewController {
    private let beiJingTuCeng = CAGradientLayer()
    private let diTu: DituXinXi
    private let youXiGuanLi = YouXiGuanLiQi.gongXiang

    // UI元素
    private let wanJiaXueLiangTiao = JinDuTiaoShiTu()
    private let diRenXueLiangTiao = JinDuTiaoShiTu()
    private let wanJiaXinXiLabel = UILabel()
    private let diRenXinXiLabel = UILabel()
    private let diRenTuXiang = UILabel()
    private let huiHeShuLabel = UILabel()
    private let huiHeTiShiLabel = UILabel()  // 回合提示标签

    private let shouPaiRongQi = UIView()
    private var shouPaiShiTuShuZu: [MajiangPaiShiTu] = []
    private var dangQianShouPai: [MajiangPai] = []

    private let daChupaiAnNiu = YouXiAnNiu(biaoTi: "Attack", yangShi: .zhuyao)
    private let tiaoGuoAnNiu = YouXiAnNiu(biaoTi: "Skip Turn", yangShi: .ciYao)
    private let tuiChuAnNiu = YouXiAnNiu(biaoTi: "Exit", yangShi: .weixian)

    private let xiaoGuoLabel = UILabel()

    // 游戏状态
    private var diRenLieBiao: [DiRenXinXi] = []
    private var dangQianDiRen: DiRenXinXi?
    private var huiHeShu = 0
    private var shiWanJiaHuiHe = true

    init(diTu: DituXinXi) {
        self.diTu = diTu
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sheZhiJieMian()
        chuShiHuaYouXi()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        beiJingTuCeng.frame = view.bounds
    }

    private func sheZhiJieMian() {
        // 渐变背景
        beiJingTuCeng.colors = [
            UIColor(red: 0.1, green: 0.05, blue: 0.15, alpha: 1.0).cgColor,
            UIColor(red: 0.15, green: 0.1, blue: 0.2, alpha: 1.0).cgColor,
            UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0).cgColor
        ]
        view.layer.insertSublayer(beiJingTuCeng, at: 0)

        // 退出按钮
        view.addSubview(tuiChuAnNiu)
        tuiChuAnNiu.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(36)
        }
        tuiChuAnNiu.addTarget(self, action: #selector(tuiChuYouXi), for: .touchUpInside)

        // 回合数
        view.addSubview(huiHeShuLabel)
        huiHeShuLabel.textAlignment = .center
        huiHeShuLabel.font = UIFont.boldSystemFont(ofSize: 18)
        huiHeShuLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        huiHeShuLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.centerX.equalToSuperview()
        }

        // 回合提示标签
        view.addSubview(huiHeTiShiLabel)
        huiHeTiShiLabel.textAlignment = .center
        huiHeTiShiLabel.font = UIFont.boldSystemFont(ofSize: 16)
        huiHeTiShiLabel.layer.cornerRadius = 12
        huiHeTiShiLabel.layer.masksToBounds = true
        huiHeTiShiLabel.snp.makeConstraints { make in
            make.top.equalTo(huiHeShuLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.greaterThanOrEqualTo(120)
        }

        // 敌人区域
        sheZhiDiRenQuYu()

        // 玩家区域
        sheZhiWanJiaQuYu()

        // 手牌区域
        sheZhiShouPaiQuYu()

        // 效果标签
        view.addSubview(xiaoGuoLabel)
        xiaoGuoLabel.textAlignment = .center
        xiaoGuoLabel.font = UIFont.boldSystemFont(ofSize: 36)
        xiaoGuoLabel.textColor = .white
        xiaoGuoLabel.alpha = 0
        xiaoGuoLabel.layer.shadowColor = UIColor.black.cgColor
        xiaoGuoLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        xiaoGuoLabel.layer.shadowOpacity = 1.0
        xiaoGuoLabel.layer.shadowRadius = 4
        xiaoGuoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func sheZhiDiRenQuYu() {
        // 敌人图像
        view.addSubview(diRenTuXiang)
        diRenTuXiang.text = "👹"
        diRenTuXiang.font = UIFont.systemFont(ofSize: 80)
        diRenTuXiang.textAlignment = .center
        diRenTuXiang.snp.makeConstraints { make in
            make.top.equalTo(huiHeTiShiLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        // 敌人信息
        view.addSubview(diRenXinXiLabel)
        diRenXinXiLabel.textAlignment = .center
        diRenXinXiLabel.font = UIFont.boldSystemFont(ofSize: 16)
        diRenXinXiLabel.textColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0)
        diRenXinXiLabel.snp.makeConstraints { make in
            make.top.equalTo(diRenTuXiang.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        // 敌人血量条
        view.addSubview(diRenXueLiangTiao)
        diRenXueLiangTiao.snp.makeConstraints { make in
            make.top.equalTo(diRenXinXiLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
    }

    private func sheZhiWanJiaQuYu() {
        // 玩家信息
        view.addSubview(wanJiaXinXiLabel)
        wanJiaXinXiLabel.textAlignment = .center
        wanJiaXinXiLabel.font = UIFont.boldSystemFont(ofSize: 16)
        wanJiaXinXiLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0)
        wanJiaXinXiLabel.numberOfLines = 2
        wanJiaXinXiLabel.snp.makeConstraints { make in
            make.top.equalTo(diRenXueLiangTiao.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }

        // 玩家血量条
        view.addSubview(wanJiaXueLiangTiao)
        wanJiaXueLiangTiao.snp.makeConstraints { make in
            make.top.equalTo(wanJiaXinXiLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
    }

    private func sheZhiShouPaiQuYu() {
        // 手牌容器
        view.addSubview(shouPaiRongQi)
        shouPaiRongQi.snp.makeConstraints { make in
            make.top.equalTo(wanJiaXueLiangTiao.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }

        // 按钮容器
        let anNiuRongQi = UIStackView(arrangedSubviews: [daChupaiAnNiu, tiaoGuoAnNiu])
        anNiuRongQi.axis = .horizontal
        anNiuRongQi.distribution = .fillEqually
        anNiuRongQi.spacing = 15

        view.addSubview(anNiuRongQi)
        anNiuRongQi.snp.makeConstraints { make in
            make.top.equalTo(shouPaiRongQi.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-20)
        }

        daChupaiAnNiu.addTarget(self, action: #selector(daChuPai), for: .touchUpInside)
        tiaoGuoAnNiu.addTarget(self, action: #selector(tiaoGuoHuiHe), for: .touchUpInside)
    }

    // 初始化游戏
    private func chuShiHuaYouXi() {
        // 重置玩家血量
        youXiGuanLi.wanJia.chongZhiXueLiang()

        // 创建敌人列表
        chuangJianDiRenLieBiao()

        // 开始第一回合
        kaiShiXinHuiHe()
    }

    private func chuangJianDiRenLieBiao() {
        diRenLieBiao.removeAll()

        // 创建小怪
        for i in 1...diTu.xiaoGuaiShuLiang {
            let xiaoGuai = DiRenXinXi(
                mingCheng: "Minion \(i)",
                leiXing: .xiaoGuai,
                xueLiang: diTu.xiaoGuaiXueLiang,
                gongJiLi: diTu.xiaoGuaiGongJi
            )
            diRenLieBiao.append(xiaoGuai)
        }

        // 创建Boss
        let boss = DiRenXinXi(
            mingCheng: diTu.bossMingCheng,
            leiXing: .boss,
            xueLiang: diTu.bossXueLiang,
            gongJiLi: diTu.bossGongJi
        )
        diRenLieBiao.append(boss)

        // 设置当前敌人
        dangQianDiRen = diRenLieBiao.first
    }

    // 开始新回合
    private func kaiShiXinHuiHe() {
        huiHeShu += 1
        shiWanJiaHuiHe = true
        gengXinJieMian()
        chouQuXinShouPai()
        // 重新启用按钮
        qiYongAnNiu()
    }

    // 抽取新手牌
    private func chouQuXinShouPai() {
        // 清除旧手牌
        shouPaiShiTuShuZu.forEach { $0.removeFromSuperview() }
        shouPaiShiTuShuZu.removeAll()

        // 抽取6张牌并排序
        dangQianShouPai = youXiGuanLi.paiZuGuanLiQi.suiJiChouPai(shuLiang: 6).sorted()

        // 使用SnapKit布局手牌
        let paiKuanDu: CGFloat = 55
        let paiGaoDu: CGFloat = 80
        let paiShuLiang = dangQianShouPai.count
        let zongKuanDu = view.bounds.width - 40  // 减去左右边距
        let jianGe = (zongKuanDu - CGFloat(paiShuLiang) * paiKuanDu) / CGFloat(paiShuLiang + 1)

        for (suoYin, pai) in dangQianShouPai.enumerated() {
            let paiShiTu = MajiangPaiShiTu(pai: pai)
            shouPaiRongQi.addSubview(paiShiTu)

            paiShiTu.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(jianGe + CGFloat(suoYin) * (paiKuanDu + jianGe))
                make.centerY.equalToSuperview()
                make.width.equalTo(paiKuanDu)
                make.height.equalTo(paiGaoDu)
            }

            // 添加点击手势
            let dianjishoushi = UITapGestureRecognizer(target: self, action: #selector(dianJiPai(_:)))
            paiShiTu.addGestureRecognizer(dianjishoushi)
            paiShiTu.isUserInteractionEnabled = true

            shouPaiShiTuShuZu.append(paiShiTu)

            // 入场动画
            paiShiTu.alpha = 0
            paiShiTu.transform = CGAffineTransform(translationX: 0, y: 50)
            UIView.animate(withDuration: 0.3, delay: Double(suoYin) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                paiShiTu.alpha = 1
                paiShiTu.transform = .identity
            }
        }
    }

    // 更新界面
    private func gengXinJieMian() {
        huiHeShuLabel.text = "Turn \(huiHeShu)"

        // 更新回合提示标签
        gengXinHuiHeTiShi()

        // 更新玩家信息
        let wanJia = youXiGuanLi.wanJia
        wanJiaXinXiLabel.text = "Player\nATK: \(wanJia.gongJiLi) | DEF: \(wanJia.fangYuLi) | HEAL: \(wanJia.huiFuLiang)"
        wanJiaXueLiangTiao.gengXinJinDu(CGFloat(wanJia.dangQianXueLiang) / CGFloat(wanJia.zuiDaXueLiang), dongHua: true)
        wanJiaXueLiangTiao.sheZhiWenZi("\(wanJia.dangQianXueLiang) / \(wanJia.zuiDaXueLiang)")

        // 更新敌人信息
        if let diRen = dangQianDiRen {
            diRenXinXiLabel.text = "\(diRen.mingCheng) | ATK: \(diRen.gongJiLi)"
            diRenXueLiangTiao.gengXinJinDu(diRen.xueLiangBaiFenBi, dongHua: true)
            diRenXueLiangTiao.sheZhiWenZi("\(diRen.dangQianXueLiang) / \(diRen.zuiDaXueLiang)")

            // 根据敌人类型更换图标
            diRenTuXiang.text = diRen.leiXing == .boss ? "👺" : "👹"
        }
    }

    // 更新回合提示
    private func gengXinHuiHeTiShi() {
        if shiWanJiaHuiHe {
            huiHeTiShiLabel.text = "  🎴 Your Turn  "
            huiHeTiShiLabel.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 0.9)
            huiHeTiShiLabel.textColor = .white
        } else {
            huiHeTiShiLabel.text = "  ⚔️ Enemy Turn  "
            huiHeTiShiLabel.backgroundColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 0.9)
            huiHeTiShiLabel.textColor = .white
        }

        // 添加脉冲动画
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
            self.huiHeTiShiLabel.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: nil)

        // 1秒后停止动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.huiHeTiShiLabel.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.2) {
                self.huiHeTiShiLabel.transform = .identity
            }
        }
    }

    // 点击牌
    @objc private func dianJiPai(_ gesture: UITapGestureRecognizer) {
        guard let paiShiTu = gesture.view as? MajiangPaiShiTu else { return }
        let xuanZhong = !paiShiTu.huoQuXuanZhongZhuangTai
        paiShiTu.sheZhiXuanZhong(xuanZhong)
    }

    // 打出牌
    @objc private func daChuPai() {
        // 获取选中的牌和牌视图
        let xuanZhongPaiShiTu = shouPaiShiTuShuZu.filter { $0.huoQuXuanZhongZhuangTai }
        let xuanZhongPai = xuanZhongPaiShiTu.map { $0.pai }

        guard !xuanZhongPai.isEmpty else {
            xianShiTiShi(xiaoXi: "Please select cards!")
            return
        }

        // 检测组合
        let zuHeLieBiao = youXiGuanLi.paiZuGuanLiQi.jianCeKeYongZuHe(shouPai: xuanZhongPai)

        guard !zuHeLieBiao.isEmpty else {
            xianShiTiShi(xiaoXi: "Invalid combination!")
            return
        }

        // 禁用按钮，防止连续点击
        jinYongAnNiu()

        // 使用第一个组合
        let zuHe = zuHeLieBiao[0]
        let (shangHai, huiFu) = youXiGuanLi.paiZuGuanLiQi.jiSuanXiaoGuo(zuHe: zuHe, wanJia: youXiGuanLi.wanJia)

        // 移除打出的牌（带动画）
        yiChuDaChuDePai(paiShiTu: xuanZhongPaiShiTu)

        // 禁用剩余的牌，不能再选中
        jinYongShengYuDePai()

        if shangHai > 0 {
            // 对敌人造成伤害
            dangQianDiRen?.shouDaoShangHai(shangHai)
            xianShiShangHaiXiaoGuo(shangHai: shangHai)
        } else if huiFu > 0 {
            // 回复玩家血量
            youXiGuanLi.wanJia.huiFuXueLiang(huiFu)
            xianShiHuiFuXiaoGuo(huiFu: huiFu)
        }

        // 更新界面
        gengXinJieMian()

        // 检查敌人是否死亡
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.jianChaDiRenZhuangTai()
        }
    }

    // 禁用按钮
    private func jinYongAnNiu() {
        daChupaiAnNiu.isEnabled = false
        tiaoGuoAnNiu.isEnabled = false
    }

    // 启用按钮
    private func qiYongAnNiu() {
        daChupaiAnNiu.isEnabled = true
        tiaoGuoAnNiu.isEnabled = true
    }

    // 移除打出的牌
    private func yiChuDaChuDePai(paiShiTu: [MajiangPaiShiTu]) {
        for pai in paiShiTu {
            // 淡出动画
            UIView.animate(withDuration: 0.3, animations: {
                pai.alpha = 0
                pai.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { _ in
                pai.removeFromSuperview()
            }

            // 从数组中移除
            if let index = shouPaiShiTuShuZu.firstIndex(where: { $0.pai.id == pai.pai.id }) {
                shouPaiShiTuShuZu.remove(at: index)
            }
        }
    }

    // 禁用剩余的牌
    private func jinYongShengYuDePai() {
        for paiShiTu in shouPaiShiTuShuZu {
            paiShiTu.isUserInteractionEnabled = false
            paiShiTu.alpha = 0.5
        }
    }

    // 跳过回合
    @objc private func tiaoGuoHuiHe() {
        // 禁用按钮
        jinYongAnNiu()
        // 禁用所有手牌
        jinYongShengYuDePai()
        // 敌人攻击
        diRenGongJi()
    }

    // 敌人攻击
    private func diRenGongJi() {
        guard let diRen = dangQianDiRen else { return }

        shiWanJiaHuiHe = false
        youXiGuanLi.wanJia.shouDaoShangHai(diRen.gongJiLi)

        xianShiDiRenGongJiXiaoGuo(shangHai: diRen.gongJiLi)
        gengXinJieMian()

        // 检查玩家是否死亡
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.jianChaWanJiaZhuangTai()
        }
    }

    // 检查敌人状态
    private func jianChaDiRenZhuangTai() {
        guard let diRen = dangQianDiRen else { return }

        if !diRen.shiCunHuo {
            // 敌人死亡
            diRenLieBiao.removeFirst()

            if diRenLieBiao.isEmpty {
                // 所有敌人都被击败，游戏胜利
                youXiShengLi()
            } else {
                // 切换到下一个敌人
                dangQianDiRen = diRenLieBiao.first

                if dangQianDiRen?.leiXing == .boss {
                    xianShiBossChuXian()
                } else {
                    kaiShiXinHuiHe()
                }
            }
        } else {
            // 敌人还活着，敌人回合
            diRenGongJi()
        }
    }

    // 检查玩家状态
    private func jianChaWanJiaZhuangTai() {
        if !youXiGuanLi.wanJia.shiCunHuo {
            youXiShiBai()
        } else {
            kaiShiXinHuiHe()
        }
    }

    // 显示Boss出现
    private func xianShiBossChuXian() {
        let tanKuang = ZiDingYiTanKuang()
        tanKuang.xianShi(
            zaiShiTu: view,
            biaoTi: "⚠️ BOSS APPEARS!",
            xiaoXi: "\(diTu.bossMingCheng) has entered the battle!",
            anNius: [("Fight!", UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), { [weak self] in
                self?.kaiShiXinHuiHe()
            })]
        )
    }

    // 游戏胜利
    private func youXiShengLi() {
        // 奖励金币
        youXiGuanLi.wanJia.jinBi += diTu.jiangLiJinBi

        // 解锁下一个地图
        let dangQianDiTuSuoYin = diTu.id - 1
        if dangQianDiTuSuoYin + 1 == youXiGuanLi.wanJia.yiJieSuoDiTuShuLiang {
            youXiGuanLi.jieSuoXiaYiGeDiTu()
        }

        youXiGuanLi.baoCunWanJiaShuJu()

        let tanKuang = ZiDingYiTanKuang()
        tanKuang.xianShi(
            zaiShiTu: view,
            biaoTi: "🎉 VICTORY!",
            xiaoXi: "You defeated all enemies!\nReward: 💰 \(diTu.jiangLiJinBi)",
            anNius: [("Continue", UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0), { [weak self] in
                self?.dismiss(animated: true)
            })]
        )
    }

    // 游戏失败
    private func youXiShiBai() {
        let tanKuang = ZiDingYiTanKuang()
        tanKuang.xianShi(
            zaiShiTu: view,
            biaoTi: "💀 DEFEAT",
            xiaoXi: "You have been defeated...\nTry upgrading your stats!",
            anNius: [("Retry", UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), { [weak self] in
                self?.chuShiHuaYouXi()
            }), ("Exit", UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0), { [weak self] in
                self?.dismiss(animated: true)
            })]
        )
    }

    // 显示提示
    private func xianShiTiShi(xiaoXi: String) {
        let tanKuang = ZiDingYiTanKuang()
        tanKuang.xianShi(
            zaiShiTu: view,
            biaoTi: "Notice",
            xiaoXi: xiaoXi,
            anNius: [("OK", UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0), {})]
        )
    }

    // 显示伤害效果
    private func xianShiShangHaiXiaoGuo(shangHai: Int) {
        xiaoGuoLabel.text = "-\(shangHai) 💥"
        xiaoGuoLabel.textColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0)
        boFangXiaoGuoDongHua()

        // 敌人震动
        let zhendong = CAKeyframeAnimation(keyPath: "transform.translation.x")
        zhendong.values = [0, -10, 10, -10, 10, 0]
        zhendong.duration = 0.5
        diRenTuXiang.layer.add(zhendong, forKey: "zhendong")
    }

    // 显示回复效果
    private func xianShiHuiFuXiaoGuo(huiFu: Int) {
        xiaoGuoLabel.text = "+\(huiFu) ✨"
        xiaoGuoLabel.textColor = UIColor(red: 0.2, green: 1.0, blue: 0.5, alpha: 1.0)
        boFangXiaoGuoDongHua()
    }

    // 显示敌人攻击效果
    private func xianShiDiRenGongJiXiaoGuo(shangHai: Int) {
        let shiJiShangHai = max(0, shangHai - youXiGuanLi.wanJia.fangYuLi)
        xiaoGuoLabel.text = "Enemy Attack\n-\(shiJiShangHai) 💢"
        xiaoGuoLabel.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        xiaoGuoLabel.numberOfLines = 2
        boFangXiaoGuoDongHua()
    }

    // 播放效果动画
    private func boFangXiaoGuoDongHua() {
        xiaoGuoLabel.alpha = 0
        xiaoGuoLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseOut) {
            self.xiaoGuoLabel.alpha = 1
            self.xiaoGuoLabel.transform = .identity
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn) {
                self.xiaoGuoLabel.alpha = 0
                self.xiaoGuoLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        }
    }

    @objc private func tuiChuYouXi() {
        let tanKuang = ZiDingYiTanKuang()
        tanKuang.xianShi(
            zaiShiTu: view,
            biaoTi: "Exit Game?",
            xiaoXi: "Your progress will be lost.",
            anNius: [
                ("Cancel", UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0), {}),
                ("Exit", UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), { [weak self] in
                    self?.dismiss(animated: true)
                })
            ]
        )
    }
}
