//
//  PaiZuGuanLiQi.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 牌组管理器
class PaiZuGuanLiQi {
    private var wanZhengPaiZu: [MajiangPai] = []

    init() {
        chuangJianPaiZu()
    }

    // 创建完整牌组 (3种花色 x 9个数值 x 4份 + 4种特殊牌 x 4份 = 124张)
    private func chuangJianPaiZu() {
        wanZhengPaiZu.removeAll()

        // 数值牌：筒、万、条
        let shuZhiPaiLeiXing: [MajiangPaiLeiXing] = [.uisjye, .oape, .ratte]
        for leiXing in shuZhiPaiLeiXing {
            for shuZhi in 1...9 {
                for _ in 1...4 {
                    wanZhengPaiZu.append(MajiangPai(leiXing: leiXing, shuZhi: shuZhi))
                }
            }
        }

        // 特殊牌
        for shuZhi in 1...4 {
            for _ in 1...4 {
                wanZhengPaiZu.append(MajiangPai(leiXing: .posue, shuZhi: shuZhi))
            }
        }
    }

    // 随机抽取指定数量的牌
    func suiJiChouPai(shuLiang: Int) -> [MajiangPai] {
        var linShiPaiZu = wanZhengPaiZu
        var chouQuDePai: [MajiangPai] = []

        for _ in 0..<min(shuLiang, linShiPaiZu.count) {
            let suiJiSuoYin = Int.random(in: 0..<linShiPaiZu.count)
            chouQuDePai.append(linShiPaiZu.remove(at: suiJiSuoYin))
        }

        return chouQuDePai
    }

    // 检测所有可能的组合
    func jianCeKeYongZuHe(shouPai: [MajiangPai]) -> [PaiZuHeLeiXing] {
        var keYongZuHe: [PaiZuHeLeiXing] = []

        // 检测杠（4张相同）
        let gangZuHe = jianCeGang(shouPai: shouPai)
        keYongZuHe.append(contentsOf: gangZuHe)

        // 检测三张（3张相同）
        let sanZhangZuHe = jianCeSanZhang(shouPai: shouPai)
        keYongZuHe.append(contentsOf: sanZhangZuHe)

        // 检测对子（2张相同）
        let duiZiZuHe = jianCeDuiZi(shouPai: shouPai)
        keYongZuHe.append(contentsOf: duiZiZuHe)

        // 检测顺子
        let shunZiZuHe = jianCeShunZi(shouPai: shouPai)
        keYongZuHe.append(contentsOf: shunZiZuHe)

        return keYongZuHe
    }

    // 检测杠
    private func jianCeGang(shouPai: [MajiangPai]) -> [PaiZuHeLeiXing] {
        var zuHe: [PaiZuHeLeiXing] = []
        let paiJiShu = jiSuanPaiShuLiang(shouPai: shouPai)

        for (pai, shuLiang) in paiJiShu {
            if shuLiang >= 4 {
                let xiangTongPai = shouPai.filter { $0 == pai }.prefix(4)
                zuHe.append(.gang(Array(xiangTongPai)))
            }
        }

        return zuHe
    }

    // 检测三张
    private func jianCeSanZhang(shouPai: [MajiangPai]) -> [PaiZuHeLeiXing] {
        var zuHe: [PaiZuHeLeiXing] = []
        let paiJiShu = jiSuanPaiShuLiang(shouPai: shouPai)

        for (pai, shuLiang) in paiJiShu {
            if shuLiang >= 3 {
                let xiangTongPai = shouPai.filter { $0 == pai }.prefix(3)
                zuHe.append(.sanZhang(Array(xiangTongPai)))
            }
        }

        return zuHe
    }

    // 检测对子
    private func jianCeDuiZi(shouPai: [MajiangPai]) -> [PaiZuHeLeiXing] {
        var zuHe: [PaiZuHeLeiXing] = []
        let paiJiShu = jiSuanPaiShuLiang(shouPai: shouPai)

        for (pai, shuLiang) in paiJiShu {
            if shuLiang >= 2 {
                let xiangTongPai = shouPai.filter { $0 == pai }.prefix(2)
                zuHe.append(.duiZi(Array(xiangTongPai)))
            }
        }

        return zuHe
    }

    // 检测顺子
    private func jianCeShunZi(shouPai: [MajiangPai]) -> [PaiZuHeLeiXing] {
        var zuHe: [PaiZuHeLeiXing] = []

        // 顺子只能由数值牌组成
        let leiXingList: [MajiangPaiLeiXing] = [.uisjye, .oape, .ratte]

        for leiXing in leiXingList {
            let tongLeiXingPai = shouPai.filter { $0.leiXing == leiXing }

            // 检测所有可能的顺子
            for qiShiShuZhi in 1...7 {
                let xu1 = tongLeiXingPai.first { $0.shuZhi == qiShiShuZhi }
                let xu2 = tongLeiXingPai.first { $0.shuZhi == qiShiShuZhi + 1 }
                let xu3 = tongLeiXingPai.first { $0.shuZhi == qiShiShuZhi + 2 }

                if let p1 = xu1, let p2 = xu2, let p3 = xu3 {
                    zuHe.append(.shunZi([p1, p2, p3]))
                }
            }
        }

        return zuHe
    }

    // 计算每种牌的数量
    private func jiSuanPaiShuLiang(shouPai: [MajiangPai]) -> [MajiangPai: Int] {
        var jiShu: [MajiangPai: Int] = [:]

        for pai in shouPai {
            jiShu[pai, default: 0] += 1
        }

        return jiShu
    }

    // 计算伤害或回复
    func jiSuanXiaoGuo(zuHe: PaiZuHeLeiXing, wanJia: WanJiaXinXi) -> (shangHai: Int, huiFu: Int) {
        let pais = zuHe.pais
        guard let diYiZhangPai = pais.first else {
            return (0, 0)
        }

        var shangHai = 0
        var huiFu = 0

        if diYiZhangPai.shiTeShuPai {
            // 特殊牌：回复血量
            let jiChuHuiFu = wanJia.huiFuLiang

            switch zuHe {
            case .duiZi:
                huiFu = jiChuHuiFu
            case .sanZhang:
                huiFu = jiChuHuiFu * 2
            case .gang:
                huiFu = jiChuHuiFu * 3
            case .shunZi:
                huiFu = 0  // 特殊牌不能组成顺子
            }
        } else {
            // 数值牌：造成伤害
            let jiChuShangHai = wanJia.gongJiLi

            switch zuHe {
            case .duiZi:
                shangHai = jiChuShangHai
            case .sanZhang:
                shangHai = jiChuShangHai * 2
            case .gang:
                shangHai = jiChuShangHai * 3
            case .shunZi:
                shangHai = Int(Double(jiChuShangHai) * 1.5)
            }
        }

        return (shangHai, huiFu)
    }
}
