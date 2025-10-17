//
//  DiRenXinXi.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 敌人类型
enum DiRenLeiXing {
    case xiaoGuai    // 小怪
    case boss        // Boss
}

// 敌人信息模型
class DiRenXinXi {
    let mingCheng: String
    let leiXing: DiRenLeiXing
    var zuiDaXueLiang: Int
    var dangQianXueLiang: Int
    var gongJiLi: Int

    init(mingCheng: String, leiXing: DiRenLeiXing, xueLiang: Int, gongJiLi: Int) {
        self.mingCheng = mingCheng
        self.leiXing = leiXing
        self.zuiDaXueLiang = xueLiang
        self.dangQianXueLiang = xueLiang
        self.gongJiLi = gongJiLi
    }

    // 受到伤害
    func shouDaoShangHai(_ shangHaiZhi: Int) {
        dangQianXueLiang = max(0, dangQianXueLiang - shangHaiZhi)
    }

    // 是否存活
    var shiCunHuo: Bool {
        return dangQianXueLiang > 0
    }

    // 血量百分比
    var xueLiangBaiFenBi: CGFloat {
        return CGFloat(dangQianXueLiang) / CGFloat(zuiDaXueLiang)
    }
}
