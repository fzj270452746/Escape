//
//  MaklumatPemain.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 玩家信息模型
class MaklumatPemain {
    var maksimumNyawa: Int      // 最大血量
    var nyawaSemasa: Int   // 当前血量
    var kuasaSerangan: Int           // 攻击力
    var kuasaPertahanan: Int           // 防御力
    var jumlahPemulihan: Int         // 回复量
    var syiling: Int              // 金币

    // 升级等级记录
    var kaliNaikTarafNyawa: Int = 0
    var kaliNaikTarafSerangan: Int = 0
    var kaliNaikTarafPertahanan: Int = 0
    var kaliNaikTarafPemulihan: Int = 0

    // 已解锁地图数量
    var jumlahPetaDibuka: Int = 1

    init() {
        self.maksimumNyawa = 200
        self.nyawaSemasa = 200
        self.kuasaSerangan = 20
        self.kuasaPertahanan = 5
        self.jumlahPemulihan = 20
        self.syiling = 0
    }

    // 升级血量
    func naikTarafNyawa(harga: Int) -> Bool {
        if syiling >= harga {
            syiling -= harga
            kaliNaikTarafNyawa += 1
            maksimumNyawa += 50
            nyawaSemasa = maksimumNyawa
            return true
        }
        return false
    }

    // 升级攻击力
    func naikTarafSerangan(harga: Int) -> Bool {
        if syiling >= harga {
            syiling -= harga
            kaliNaikTarafSerangan += 1
            kuasaSerangan += 10
            return true
        }
        return false
    }

    // 升级防御力
    func naikTarafPertahanan(harga: Int) -> Bool {
        if syiling >= harga {
            syiling -= harga
            kaliNaikTarafPertahanan += 1
            kuasaPertahanan += 3
            return true
        }
        return false
    }

    // 升级回复量
    func naikTarafPemulihan(harga: Int) -> Bool {
        if syiling >= harga {
            syiling -= harga
            kaliNaikTarafPemulihan += 1
            jumlahPemulihan += 10
            return true
        }
        return false
    }

    // 受到伤害
    func terimaKerosakan(_ nilaiKerosakan: Int) {
        let shiJiShangHai = max(0, nilaiKerosakan - kuasaPertahanan)
        nyawaSemasa = max(0, nyawaSemasa - shiJiShangHai)
    }

    // 回复血量
    func pulihkanNyawa(_ nilaiPemulihan: Int) {
        nyawaSemasa = min(maksimumNyawa, nyawaSemasa + nilaiPemulihan)
    }

    // 是否存活
    var adakahHidup: Bool {
        return nyawaSemasa > 0
    }

    // 重置血量到满
    func setelSemulakanNyawa() {
        nyawaSemasa = maksimumNyawa
    }
}
