//
//  MaklumatPeta.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// 地图信息模型
struct MaklumatPeta {
    let id: Int
    let nama: String
    let penerangan: String
    let namaBoss: String
    let nyawaBoss: Int
    let seranganBoss: Int
    let jumlahMinion: Int
    let nyawaMinion: Int
    let seranganMinion: Int
    let syilingGanjaran: Int

    static func chuangJianSuoYouDiTu() -> [MaklumatPeta] {
        return [
            MaklumatPeta(id: 1, nama: "Bamboo Forest", penerangan: "A peaceful bamboo grove, perfect for beginners", namaBoss: "Forest Guardian", nyawaBoss: 120, seranganBoss: 15, jumlahMinion: 3, nyawaMinion: 50, seranganMinion: 10, syilingGanjaran: 100),

            MaklumatPeta(id: 2, nama: "Misty Mountain", penerangan: "Clouds shroud mysterious peaks", namaBoss: "Mountain Spirit", nyawaBoss: 300, seranganBoss: 20, jumlahMinion: 4, nyawaMinion: 100, seranganMinion: 13, syilingGanjaran: 150),

            MaklumatPeta(id: 3, nama: "Ancient Temple", penerangan: "Sacred grounds filled with ancient power", namaBoss: "Temple Master", nyawaBoss: 400, seranganBoss: 25, jumlahMinion: 5, nyawaMinion: 120, seranganMinion: 16, syilingGanjaran: 200),

            MaklumatPeta(id: 4, nama: "Dragon Valley", penerangan: "Where dragons once roamed freely", namaBoss: "Young Dragon", nyawaBoss: 500, seranganBoss: 30, jumlahMinion: 5, nyawaMinion: 140, seranganMinion: 19, syilingGanjaran: 250),

            MaklumatPeta(id: 5, nama: "Jade Palace", penerangan: "Imperial palace of untold riches", namaBoss: "Jade Emperor", nyawaBoss: 650, seranganBoss: 35, jumlahMinion: 6, nyawaMinion: 160, seranganMinion: 22, syilingGanjaran: 300),

            MaklumatPeta(id: 6, nama: "Shadow Realm", penerangan: "A dark dimension beyond reality", namaBoss: "Shadow Lord", nyawaBoss: 800, seranganBoss: 40, jumlahMinion: 6, nyawaMinion: 180, seranganMinion: 25, syilingGanjaran: 350),

            MaklumatPeta(id: 7, nama: "Thunder Plains", penerangan: "Endless storms rage across the land", namaBoss: "Thunder God", nyawaBoss: 1000, seranganBoss: 45, jumlahMinion: 7, nyawaMinion: 200, seranganMinion: 28, syilingGanjaran: 400),

            MaklumatPeta(id: 8, nama: "Crystal Cave", penerangan: "Glittering crystals hide deadly secrets", namaBoss: "Crystal Golem", nyawaBoss: 1200, seranganBoss: 50, jumlahMinion: 7, nyawaMinion: 220, seranganMinion: 31, syilingGanjaran: 450),

            MaklumatPeta(id: 9, nama: "Fire Peaks", penerangan: "Volcanic fury threatens all who enter", namaBoss: "Flame Titan", nyawaBoss: 1400, seranganBoss: 55, jumlahMinion: 8, nyawaMinion: 240, seranganMinion: 34, syilingGanjaran: 500),

            MaklumatPeta(id: 10, nama: "Frozen Wastes", penerangan: "Eternal winter freezes all hope", namaBoss: "Ice Queen", nyawaBoss: 1650, seranganBoss: 60, jumlahMinion: 8, nyawaMinion: 260, seranganMinion: 37, syilingGanjaran: 550),

            MaklumatPeta(id: 11, nama: "Celestial Tower", penerangan: "A tower reaching into the heavens", namaBoss: "Sky Warden", nyawaBoss: 1900, seranganBoss: 65, jumlahMinion: 9, nyawaMinion: 280, seranganMinion: 40, syilingGanjaran: 600),

            MaklumatPeta(id: 12, nama: "Abyssal Depths", penerangan: "Dark waters conceal ancient horrors", namaBoss: "Deep One", nyawaBoss: 2200, seranganBoss: 70, jumlahMinion: 9, nyawaMinion: 300, seranganMinion: 43, syilingGanjaran: 650),

            MaklumatPeta(id: 13, nama: "Demon Fortress", penerangan: "Stronghold of demonic forces", namaBoss: "Demon King", nyawaBoss: 2500, seranganBoss: 75, jumlahMinion: 10, nyawaMinion: 320, seranganMinion: 46, syilingGanjaran: 700),

            MaklumatPeta(id: 14, nama: "Void Dimension", penerangan: "Where reality ceases to exist", namaBoss: "Void Entity", nyawaBoss: 2850, seranganBoss: 80, jumlahMinion: 10, nyawaMinion: 350, seranganMinion: 49, syilingGanjaran: 800),

            MaklumatPeta(id: 15, nama: "Eternal Sanctum", penerangan: "The final challenge awaits", namaBoss: "Eternal One", nyawaBoss: 3300, seranganBoss: 85, jumlahMinion: 10, nyawaMinion: 380, seranganMinion: 52, syilingGanjaran: 1000)
        ]
    }
}
