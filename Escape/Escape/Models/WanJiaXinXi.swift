//
//  WanJiaXinXi.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 玩家信息模型
class WanJiaXinXi {
    var zuiDaXueLiang: Int      // 最大血量
    var dangQianXueLiang: Int   // 当前血量
    var gongJiLi: Int           // 攻击力
    var fangYuLi: Int           // 防御力
    var huiFuLiang: Int         // 回复量
    var jinBi: Int              // 金币

    // 升级等级记录
    var xueLiangShengJiCiShu: Int = 0
    var gongJiLiShengJiCiShu: Int = 0
    var fangYuLiShengJiCiShu: Int = 0
    var huiFuLiangShengJiCiShu: Int = 0

    // 已解锁地图数量
    var yiJieSuoDiTuShuLiang: Int = 1

    init() {
        self.zuiDaXueLiang = 200
        self.dangQianXueLiang = 200
        self.gongJiLi = 20
        self.fangYuLi = 5
        self.huiFuLiang = 20
        self.jinBi = 0
    }

    // 升级血量
    func shengJiXueLiang(jiGe: Int) -> Bool {
        if jinBi >= jiGe {
            jinBi -= jiGe
            xueLiangShengJiCiShu += 1
            zuiDaXueLiang += 50
            dangQianXueLiang = zuiDaXueLiang
            return true
        }
        return false
    }

    // 升级攻击力
    func shengJiGongJiLi(jiGe: Int) -> Bool {
        if jinBi >= jiGe {
            jinBi -= jiGe
            gongJiLiShengJiCiShu += 1
            gongJiLi += 10
            return true
        }
        return false
    }

    // 升级防御力
    func shengJiFangYuLi(jiGe: Int) -> Bool {
        if jinBi >= jiGe {
            jinBi -= jiGe
            fangYuLiShengJiCiShu += 1
            fangYuLi += 3
            return true
        }
        return false
    }

    // 升级回复量
    func shengJiHuiFuLiang(jiGe: Int) -> Bool {
        if jinBi >= jiGe {
            jinBi -= jiGe
            huiFuLiangShengJiCiShu += 1
            huiFuLiang += 10
            return true
        }
        return false
    }

    // 受到伤害
    func shouDaoShangHai(_ shangHaiZhi: Int) {
        let shiJiShangHai = max(0, shangHaiZhi - fangYuLi)
        dangQianXueLiang = max(0, dangQianXueLiang - shiJiShangHai)
    }

    // 回复血量
    func huiFuXueLiang(_ huiFuZhi: Int) {
        dangQianXueLiang = min(zuiDaXueLiang, dangQianXueLiang + huiFuZhi)
    }

    // 是否存活
    var shiCunHuo: Bool {
        return dangQianXueLiang > 0
    }

    // 重置血量到满
    func chongZhiXueLiang() {
        dangQianXueLiang = zuiDaXueLiang
    }
}
