//
//  PengurusGeladak.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 牌组管理器
class PengurusGeladak {
    private var wanZhengPaiZu: [KepingMahjong] = []

    init() {
        chuangJianPaiZu()
    }

    // 创建完整牌组 (3种花色 x 9个数值 x 4份 + 4种特殊牌 x 4份 = 124张)
    private func chuangJianPaiZu() {
        wanZhengPaiZu.removeAll()

        // 数值牌：筒、万、条
        let shuZhiPaiLeiXing: [JenisKepingMahjong] = [.bulatan, .karakter, .buluh]
        for leiXing in shuZhiPaiLeiXing {
            for shuZhi in 1...9 {
                for _ in 1...4 {
                    wanZhengPaiZu.append(KepingMahjong(jenis: leiXing, nilai: shuZhi))
                }
            }
        }

        // 特殊牌
        for shuZhi in 1...4 {
            for _ in 1...4 {
                wanZhengPaiZu.append(KepingMahjong(jenis: .khas, nilai: shuZhi))
            }
        }
    }

    // 随机抽取指定数量的牌
    func cabutRawak(jumlah: Int) -> [KepingMahjong] {
        var linShiPaiZu = wanZhengPaiZu
        var chouQuDePai: [KepingMahjong] = []

        for _ in 0..<min(jumlah, linShiPaiZu.count) {
            let suiJiSuoYin = Int.random(in: 0..<linShiPaiZu.count)
            chouQuDePai.append(linShiPaiZu.remove(at: suiJiSuoYin))
        }

        return chouQuDePai
    }

    // 检测所有可能的组合
    func kesanKombinasi(shouPai: [KepingMahjong]) -> [JenisKombinasi] {
        var keYongZuHe: [JenisKombinasi] = []

        // 检测杠（4张相同）
        let gangZuHe = kesanKuad(shouPai: shouPai)
        keYongZuHe.append(contentsOf: gangZuHe)

        // 检测三张（3张相同）
        let sanZhangZuHe = kesanTriple(shouPai: shouPai)
        keYongZuHe.append(contentsOf: sanZhangZuHe)

        // 检测对子（2张相同）
        let duiZiZuHe = kesanPasangan(shouPai: shouPai)
        keYongZuHe.append(contentsOf: duiZiZuHe)

        // 检测顺子
        let shunZiZuHe = kesanLurus(shouPai: shouPai)
        keYongZuHe.append(contentsOf: shunZiZuHe)

        return keYongZuHe
    }

    // 检测杠
    private func kesanKuad(shouPai: [KepingMahjong]) -> [JenisKombinasi] {
        var zuHe: [JenisKombinasi] = []
        let paiJiShu = jiSuanPaiShuLiang(shouPai: shouPai)

        for (pai, shuLiang) in paiJiShu {
            if shuLiang >= 4 {
                let xiangTongPai = shouPai.filter { $0 == pai }.prefix(4)
                zuHe.append(.kuad(Array(xiangTongPai)))
            }
        }

        return zuHe
    }

    // 检测三张
    private func kesanTriple(shouPai: [KepingMahjong]) -> [JenisKombinasi] {
        var zuHe: [JenisKombinasi] = []
        let paiJiShu = jiSuanPaiShuLiang(shouPai: shouPai)

        for (pai, shuLiang) in paiJiShu {
            if shuLiang >= 3 {
                let xiangTongPai = shouPai.filter { $0 == pai }.prefix(3)
                zuHe.append(.triple(Array(xiangTongPai)))
            }
        }

        return zuHe
    }

    // 检测对子
    private func kesanPasangan(shouPai: [KepingMahjong]) -> [JenisKombinasi] {
        var zuHe: [JenisKombinasi] = []
        let paiJiShu = jiSuanPaiShuLiang(shouPai: shouPai)

        for (pai, shuLiang) in paiJiShu {
            if shuLiang >= 2 {
                let xiangTongPai = shouPai.filter { $0 == pai }.prefix(2)
                zuHe.append(.pasangan(Array(xiangTongPai)))
            }
        }

        return zuHe
    }

    // 检测顺子
    private func kesanLurus(shouPai: [KepingMahjong]) -> [JenisKombinasi] {
        var zuHe: [JenisKombinasi] = []

        // 顺子只能由数值牌组成
        let leiXingList: [JenisKepingMahjong] = [.bulatan, .karakter, .buluh]

        for leiXing in leiXingList {
            let tongLeiXingPai = shouPai.filter { $0.jenis == leiXing }

            // 检测所有可能的顺子
            for qiShiShuZhi in 1...7 {
                let xu1 = tongLeiXingPai.first { $0.nilai == qiShiShuZhi }
                let xu2 = tongLeiXingPai.first { $0.nilai == qiShiShuZhi + 1 }
                let xu3 = tongLeiXingPai.first { $0.nilai == qiShiShuZhi + 2 }

                if let p1 = xu1, let p2 = xu2, let p3 = xu3 {
                    zuHe.append(.lurus([p1, p2, p3]))
                }
            }
        }

        return zuHe
    }

    // 计算每种牌的数量
    private func jiSuanPaiShuLiang(shouPai: [KepingMahjong]) -> [KepingMahjong: Int] {
        var jiShu: [KepingMahjong: Int] = [:]

        for pai in shouPai {
            jiShu[pai, default: 0] += 1
        }

        return jiShu
    }

    // 计算伤害或回复
    func jiSuanXiaoGuo(zuHe: JenisKombinasi, wanJia: MaklumatPemain) -> (shangHai: Int, huiFu: Int) {
        let pais = zuHe.kepings
        guard let diYiZhangPai = pais.first else {
            return (0, 0)
        }

        var shangHai = 0
        var huiFu = 0

        if diYiZhangPai.adakahKepingKhas {
            // 特殊牌：回复血量
            let jiChuHuiFu = wanJia.jumlahPemulihan

            switch zuHe {
            case .pasangan:
                huiFu = jiChuHuiFu
            case .triple:
                huiFu = jiChuHuiFu * 2
            case .kuad:
                huiFu = jiChuHuiFu * 3
            case .lurus:
                huiFu = 0  // 特殊牌不能组成顺子
            }
        } else {
            // 数值牌：造成伤害
            let jiChuShangHai = wanJia.kuasaSerangan

            switch zuHe {
            case .pasangan:
                shangHai = jiChuShangHai
            case .triple:
                shangHai = jiChuShangHai * 2
            case .kuad:
                shangHai = jiChuShangHai * 3
            case .lurus:
                shangHai = Int(Double(jiChuShangHai) * 1.5)
            }
        }

        return (shangHai, huiFu)
    }
}
