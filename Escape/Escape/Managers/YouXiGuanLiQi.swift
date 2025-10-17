//
//  YouXiGuanLiQi.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 游戏管理器（单例）
class YouXiGuanLiQi {
    static let gongXiang = YouXiGuanLiQi()

    var wanJia: WanJiaXinXi
    let paiZuGuanLiQi: PaiZuGuanLiQi
    var suoYouDiTu: [DituXinXi]

    private init() {
        self.wanJia = WanJiaXinXi()
        self.paiZuGuanLiQi = PaiZuGuanLiQi()
        self.suoYouDiTu = DituXinXi.chuangJianSuoYouDiTu()

        // 从UserDefaults加载玩家数据
        jiazaiWanJiaShujutake()
    }

    // 保存玩家数据
    func baoCunWanJiaShuJu() {
        UserDefaults.standard.set(wanJia.zuiDaXueLiang, forKey: "wanJiaZuiDaXueLiang")
        UserDefaults.standard.set(wanJia.dangQianXueLiang, forKey: "wanJiaDangQianXueLiang")
        UserDefaults.standard.set(wanJia.gongJiLi, forKey: "wanJiaGongJiLi")
        UserDefaults.standard.set(wanJia.fangYuLi, forKey: "wanJiaFangYuLi")
        UserDefaults.standard.set(wanJia.huiFuLiang, forKey: "wanJiaHuiFuLiang")
        UserDefaults.standard.set(wanJia.jinBi, forKey: "wanJiaJinBi")
        UserDefaults.standard.set(wanJia.xueLiangShengJiCiShu, forKey: "xueLiangShengJiCiShu")
        UserDefaults.standard.set(wanJia.gongJiLiShengJiCiShu, forKey: "gongJiLiShengJiCiShu")
        UserDefaults.standard.set(wanJia.fangYuLiShengJiCiShu, forKey: "fangYuLiShengJiCiShu")
        UserDefaults.standard.set(wanJia.huiFuLiangShengJiCiShu, forKey: "huiFuLiangShengJiCiShu")
        UserDefaults.standard.set(wanJia.yiJieSuoDiTuShuLiang, forKey: "yiJieSuoDiTuShuLiang")
    }

    // 加载玩家数据
    private func jiazaiWanJiaShujutake() {
        if UserDefaults.standard.object(forKey: "wanJiaZuiDaXueLiang") != nil {
            wanJia.zuiDaXueLiang = UserDefaults.standard.integer(forKey: "wanJiaZuiDaXueLiang")
            wanJia.dangQianXueLiang = UserDefaults.standard.integer(forKey: "wanJiaDangQianXueLiang")
            wanJia.gongJiLi = UserDefaults.standard.integer(forKey: "wanJiaGongJiLi")
            wanJia.fangYuLi = UserDefaults.standard.integer(forKey: "wanJiaFangYuLi")
            wanJia.huiFuLiang = UserDefaults.standard.integer(forKey: "wanJiaHuiFuLiang")
            wanJia.jinBi = UserDefaults.standard.integer(forKey: "wanJiaJinBi")
            wanJia.xueLiangShengJiCiShu = UserDefaults.standard.integer(forKey: "xueLiangShengJiCiShu")
            wanJia.gongJiLiShengJiCiShu = UserDefaults.standard.integer(forKey: "gongJiLiShengJiCiShu")
            wanJia.fangYuLiShengJiCiShu = UserDefaults.standard.integer(forKey: "fangYuLiShengJiCiShu")
            wanJia.huiFuLiangShengJiCiShu = UserDefaults.standard.integer(forKey: "huiFuLiangShengJiCiShu")
            wanJia.yiJieSuoDiTuShuLiang = UserDefaults.standard.integer(forKey: "yiJieSuoDiTuShuLiang")
        }
    }

    // 解锁下一个地图
    func jieSuoXiaYiGeDiTu() {
        wanJia.yiJieSuoDiTuShuLiang += 1
        baoCunWanJiaShuJu()
    }

    // 重置游戏数据
    func chongZhiYouXiShuJu() {
        UserDefaults.standard.removeObject(forKey: "wanJiaZuiDaXueLiang")
        UserDefaults.standard.removeObject(forKey: "wanJiaDangQianXueLiang")
        UserDefaults.standard.removeObject(forKey: "wanJiaGongJiLi")
        UserDefaults.standard.removeObject(forKey: "wanJiaFangYuLi")
        UserDefaults.standard.removeObject(forKey: "wanJiaHuiFuLiang")
        UserDefaults.standard.removeObject(forKey: "wanJiaJinBi")
        UserDefaults.standard.removeObject(forKey: "xueLiangShengJiCiShu")
        UserDefaults.standard.removeObject(forKey: "gongJiLiShengJiCiShu")
        UserDefaults.standard.removeObject(forKey: "fangYuLiShengJiCiShu")
        UserDefaults.standard.removeObject(forKey: "huiFuLiangShengJiCiShu")
        UserDefaults.standard.removeObject(forKey: "yiJieSuoDiTuShuLiang")

        wanJia = WanJiaXinXi()
    }
}
