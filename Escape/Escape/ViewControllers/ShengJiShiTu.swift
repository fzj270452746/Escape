//
//  ShengJiShiTu.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit
import SnapKit

// 升级视图控制器
class ShengJiShiTu: UIViewController {
    private let beiJingTuCeng = CAGradientLayer()
    private let biaoTiLabel = UILabel()
    private let fanHuiAnNiu = YouXiAnNiu(biaoTi: "← Back", yangShi: .ciYao)
    private let jinBiLabel = UILabel()

    private let xueLiangKa = ShengJiKaPian()
    private let gongJiKa = ShengJiKaPian()
    private let fangYuKa = ShengJiKaPian()
    private let huiFuKa = ShengJiKaPian()

    private let youXiGuanLi = YouXiGuanLiQi.gongXiang

    override func viewDidLoad() {
        super.viewDidLoad()
        sheZhiJieMian()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gengXinJieMian()
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
        biaoTiLabel.text = "UPGRADE"
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

        // 金币显示
        view.addSubview(jinBiLabel)
        jinBiLabel.textAlignment = .center
        jinBiLabel.font = UIFont.boldSystemFont(ofSize: 24)
        jinBiLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        jinBiLabel.snp.makeConstraints { make in
            make.top.equalTo(biaoTiLabel.snp.bottom).offset(20)
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
                return self?.youXiGuanLi.wanJia.zuiDaXueLiang ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.shengJiXueLiang()
            }
        )

        gongJiKa.peiZhi(
            biaoTi: "ATTACK",
            tubiao: "⚔️",
            miaoShu: "+10 ATK",
            jiGe: 100,
            dangQianZhi: { [weak self] in
                return self?.youXiGuanLi.wanJia.gongJiLi ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.shengJiGongJi()
            }
        )

        fangYuKa.peiZhi(
            biaoTi: "DEFENSE",
            tubiao: "🛡",
            miaoShu: "+3 DEF",
            jiGe: 100,
            dangQianZhi: { [weak self] in
                return self?.youXiGuanLi.wanJia.fangYuLi ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.shengJiFangYu()
            }
        )

        huiFuKa.peiZhi(
            biaoTi: "RECOVERY",
            tubiao: "✨",
            miaoShu: "+10 HEAL",
            jiGe: 100,
            dangQianZhi: { [weak self] in
                return self?.youXiGuanLi.wanJia.huiFuLiang ?? 0
            },
            shengJiHuiDiao: { [weak self] in
                self?.shengJiHuiFu()
            }
        )
    }

    private func gengXinJieMian() {
        jinBiLabel.text = "💰 Coins: \(youXiGuanLi.wanJia.jinBi)"
        xueLiangKa.gengXin()
        gongJiKa.gengXin()
        fangYuKa.gengXin()
        huiFuKa.gengXin()
    }

    // 升级方法
    private func shengJiXueLiang() {
        if youXiGuanLi.wanJia.shengJiXueLiang(jiGe: 100) {
            youXiGuanLi.baoCunWanJiaShuJu()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Max HP upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func shengJiGongJi() {
        if youXiGuanLi.wanJia.shengJiGongJiLi(jiGe: 100) {
            youXiGuanLi.baoCunWanJiaShuJu()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Attack upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func shengJiFangYu() {
        if youXiGuanLi.wanJia.shengJiFangYuLi(jiGe: 100) {
            youXiGuanLi.baoCunWanJiaShuJu()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Defense upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func shengJiHuiFu() {
        if youXiGuanLi.wanJia.shengJiHuiFuLiang(jiGe: 100) {
            youXiGuanLi.baoCunWanJiaShuJu()
            gengXinJieMian()
            xianShiChengGongTiShi(xiaoXi: "Recovery upgraded!")
        } else {
            xianShiShiBaiTiShi()
        }
    }

    private func xianShiChengGongTiShi(xiaoXi: String) {
        let tanKuang = ZiDingYiTanKuang()
        tanKuang.xianShi(
            zaiShiTu: view,
            biaoTi: "Success!",
            xiaoXi: xiaoXi,
            anNius: [("OK", UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0), {})]
        )
    }

    private func xianShiShiBaiTiShi() {
        let tanKuang = ZiDingYiTanKuang()
        tanKuang.xianShi(
            zaiShiTu: view,
            biaoTi: "Insufficient Coins",
            xiaoXi: "You need more coins to upgrade!",
            anNius: [("OK", UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), {})]
        )
    }

    @objc private func fanHui() {
        dismiss(animated: true)
    }
}

// MARK: - 升级卡片
class ShengJiKaPian: UIView {
    private let biaoTiLabel = UILabel()
    private let tubiaoLabel = UILabel()
    private let dangQianZhiLabel = UILabel()
    private let miaoShuLabel = UILabel()
    private let shengJiAnNiu = YouXiAnNiu(biaoTi: "Upgrade", yangShi: .chenggong)
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
        backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 0.9)
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0).cgColor

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
        biaoTiLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        biaoTiLabel.textAlignment = .center
        biaoTiLabel.snp.makeConstraints { make in
            make.top.equalTo(tubiaoLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
        }

        // 当前值
        addSubview(dangQianZhiLabel)
        dangQianZhiLabel.font = UIFont.boldSystemFont(ofSize: 24)
        dangQianZhiLabel.textColor = .white
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
        jiGeLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
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
