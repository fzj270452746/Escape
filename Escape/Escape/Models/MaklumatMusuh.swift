//
//  MaklumatMusuh.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 敌人类型
enum JenisMusuh {
    case xiaoGuai    // 小怪
    case boss        // Boss
}

// 敌人信息模型
class MaklumatMusuh {
    let nama: String
    let leiXing: JenisMusuh
    var maksimumNyawa: Int
    var nyawaSemasa: Int
    var kuasaSerangan: Int

    init(nama: String, leiXing: JenisMusuh, xueLiang: Int, kuasaSerangan: Int) {
        self.nama = nama
        self.leiXing = leiXing
        self.maksimumNyawa = xueLiang
        self.nyawaSemasa = xueLiang
        self.kuasaSerangan = kuasaSerangan
    }

    // 受到伤害
    func terimaKerosakan(_ nilaiKerosakan: Int) {
        nyawaSemasa = max(0, nyawaSemasa - nilaiKerosakan)
    }

    // 是否存活
    var adakahHidup: Bool {
        return nyawaSemasa > 0
    }

    // 血量百分比
    var xueLiangBaiFenBi: CGFloat {
        return CGFloat(nyawaSemasa) / CGFloat(maksimumNyawa)
    }
}
