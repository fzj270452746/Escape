//
//  DituXinXi.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 地图信息模型
struct DituXinXi {
    let id: Int
    let mingCheng: String
    let miaoshu: String
    let bossMingCheng: String
    let bossXueLiang: Int
    let bossGongJi: Int
    let xiaoGuaiShuLiang: Int
    let xiaoGuaiXueLiang: Int
    let xiaoGuaiGongJi: Int
    let jiangLiJinBi: Int

    static func chuangJianSuoYouDiTu() -> [DituXinXi] {
        return [
            DituXinXi(id: 1, mingCheng: "Bamboo Forest", miaoshu: "A peaceful bamboo grove, perfect for beginners", bossMingCheng: "Forest Guardian", bossXueLiang: 120, bossGongJi: 15, xiaoGuaiShuLiang: 3, xiaoGuaiXueLiang: 50, xiaoGuaiGongJi: 10, jiangLiJinBi: 100),

            DituXinXi(id: 2, mingCheng: "Misty Mountain", miaoshu: "Clouds shroud mysterious peaks", bossMingCheng: "Mountain Spirit", bossXueLiang: 300, bossGongJi: 20, xiaoGuaiShuLiang: 4, xiaoGuaiXueLiang: 100, xiaoGuaiGongJi: 13, jiangLiJinBi: 150),

            DituXinXi(id: 3, mingCheng: "Ancient Temple", miaoshu: "Sacred grounds filled with ancient power", bossMingCheng: "Temple Master", bossXueLiang: 400, bossGongJi: 25, xiaoGuaiShuLiang: 5, xiaoGuaiXueLiang: 120, xiaoGuaiGongJi: 16, jiangLiJinBi: 200),

            DituXinXi(id: 4, mingCheng: "Dragon Valley", miaoshu: "Where dragons once roamed freely", bossMingCheng: "Young Dragon", bossXueLiang: 500, bossGongJi: 30, xiaoGuaiShuLiang: 5, xiaoGuaiXueLiang: 140, xiaoGuaiGongJi: 19, jiangLiJinBi: 250),

            DituXinXi(id: 5, mingCheng: "Jade Palace", miaoshu: "Imperial palace of untold riches", bossMingCheng: "Jade Emperor", bossXueLiang: 650, bossGongJi: 35, xiaoGuaiShuLiang: 6, xiaoGuaiXueLiang: 160, xiaoGuaiGongJi: 22, jiangLiJinBi: 300),

            DituXinXi(id: 6, mingCheng: "Shadow Realm", miaoshu: "A dark dimension beyond reality", bossMingCheng: "Shadow Lord", bossXueLiang: 800, bossGongJi: 40, xiaoGuaiShuLiang: 6, xiaoGuaiXueLiang: 180, xiaoGuaiGongJi: 25, jiangLiJinBi: 350),

            DituXinXi(id: 7, mingCheng: "Thunder Plains", miaoshu: "Endless storms rage across the land", bossMingCheng: "Thunder God", bossXueLiang: 1000, bossGongJi: 45, xiaoGuaiShuLiang: 7, xiaoGuaiXueLiang: 200, xiaoGuaiGongJi: 28, jiangLiJinBi: 400),

            DituXinXi(id: 8, mingCheng: "Crystal Cave", miaoshu: "Glittering crystals hide deadly secrets", bossMingCheng: "Crystal Golem", bossXueLiang: 1200, bossGongJi: 50, xiaoGuaiShuLiang: 7, xiaoGuaiXueLiang: 220, xiaoGuaiGongJi: 31, jiangLiJinBi: 450),

            DituXinXi(id: 9, mingCheng: "Fire Peaks", miaoshu: "Volcanic fury threatens all who enter", bossMingCheng: "Flame Titan", bossXueLiang: 1400, bossGongJi: 55, xiaoGuaiShuLiang: 8, xiaoGuaiXueLiang: 240, xiaoGuaiGongJi: 34, jiangLiJinBi: 500),

            DituXinXi(id: 10, mingCheng: "Frozen Wastes", miaoshu: "Eternal winter freezes all hope", bossMingCheng: "Ice Queen", bossXueLiang: 1650, bossGongJi: 60, xiaoGuaiShuLiang: 8, xiaoGuaiXueLiang: 260, xiaoGuaiGongJi: 37, jiangLiJinBi: 550),

            DituXinXi(id: 11, mingCheng: "Celestial Tower", miaoshu: "A tower reaching into the heavens", bossMingCheng: "Sky Warden", bossXueLiang: 1900, bossGongJi: 65, xiaoGuaiShuLiang: 9, xiaoGuaiXueLiang: 280, xiaoGuaiGongJi: 40, jiangLiJinBi: 600),

            DituXinXi(id: 12, mingCheng: "Abyssal Depths", miaoshu: "Dark waters conceal ancient horrors", bossMingCheng: "Deep One", bossXueLiang: 2200, bossGongJi: 70, xiaoGuaiShuLiang: 9, xiaoGuaiXueLiang: 300, xiaoGuaiGongJi: 43, jiangLiJinBi: 650),

            DituXinXi(id: 13, mingCheng: "Demon Fortress", miaoshu: "Stronghold of demonic forces", bossMingCheng: "Demon King", bossXueLiang: 2500, bossGongJi: 75, xiaoGuaiShuLiang: 10, xiaoGuaiXueLiang: 320, xiaoGuaiGongJi: 46, jiangLiJinBi: 700),

            DituXinXi(id: 14, mingCheng: "Void Dimension", miaoshu: "Where reality ceases to exist", bossMingCheng: "Void Entity", bossXueLiang: 2850, bossGongJi: 80, xiaoGuaiShuLiang: 10, xiaoGuaiXueLiang: 350, xiaoGuaiGongJi: 49, jiangLiJinBi: 800),

            DituXinXi(id: 15, mingCheng: "Eternal Sanctum", miaoshu: "The final challenge awaits", bossMingCheng: "Eternal One", bossXueLiang: 3300, bossGongJi: 85, xiaoGuaiShuLiang: 10, xiaoGuaiXueLiang: 380, xiaoGuaiGongJi: 52, jiangLiJinBi: 1000)
        ]
    }
}
