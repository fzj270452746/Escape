//
//  UserDefaultsManager.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import Foundation

// Centralized UserDefaults Manager
class UserDefaultsManager {

    // MARK: - Keys
    private enum Keys {
        static let maxHealth = "wanJiaZuiDaXueLiang"
        static let currentHealth = "wanJiaDangQianXueLiang"
        static let attackPower = "wanJiaGongJiLi"
        static let defensePower = "wanJiaFangYuLi"
        static let recoveryAmount = "wanJiaHuiFuLiang"
        static let coins = "wanJiaJinBi"
        static let healthUpgradeCount = "xueLiangShengJiCiShu"
        static let attackUpgradeCount = "gongJiLiShengJiCiShu"
        static let defenseUpgradeCount = "fangYuLiShengJiCiShu"
        static let recoveryUpgradeCount = "huiFuLiangShengJiCiShu"
        static let unlockedMapCount = "yiJieSuoDiTuShuLiang"
    }

    // MARK: - Save Methods
    static func savePlayerData(pemain: MaklumatPemain) {
        UserDefaults.standard.set(pemain.maksimumNyawa, forKey: Keys.maxHealth)
        UserDefaults.standard.set(pemain.nyawaSemasa, forKey: Keys.currentHealth)
        UserDefaults.standard.set(pemain.kuasaSerangan, forKey: Keys.attackPower)
        UserDefaults.standard.set(pemain.kuasaPertahanan, forKey: Keys.defensePower)
        UserDefaults.standard.set(pemain.jumlahPemulihan, forKey: Keys.recoveryAmount)
        UserDefaults.standard.set(pemain.syiling, forKey: Keys.coins)
        UserDefaults.standard.set(pemain.kaliNaikTarafNyawa, forKey: Keys.healthUpgradeCount)
        UserDefaults.standard.set(pemain.kaliNaikTarafSerangan, forKey: Keys.attackUpgradeCount)
        UserDefaults.standard.set(pemain.kaliNaikTarafPertahanan, forKey: Keys.defenseUpgradeCount)
        UserDefaults.standard.set(pemain.kaliNaikTarafPemulihan, forKey: Keys.recoveryUpgradeCount)
        UserDefaults.standard.set(pemain.jumlahPetaDibuka, forKey: Keys.unlockedMapCount)
    }

    // MARK: - Load Methods
    static func loadPlayerData() -> MaklumatPemain? {
        guard UserDefaults.standard.object(forKey: Keys.maxHealth) != nil else {
            return nil
        }

        let pemain = MaklumatPemain()
        pemain.maksimumNyawa = UserDefaults.standard.integer(forKey: Keys.maxHealth)
        pemain.nyawaSemasa = UserDefaults.standard.integer(forKey: Keys.currentHealth)
        pemain.kuasaSerangan = UserDefaults.standard.integer(forKey: Keys.attackPower)
        pemain.kuasaPertahanan = UserDefaults.standard.integer(forKey: Keys.defensePower)
        pemain.jumlahPemulihan = UserDefaults.standard.integer(forKey: Keys.recoveryAmount)
        pemain.syiling = UserDefaults.standard.integer(forKey: Keys.coins)
        pemain.kaliNaikTarafNyawa = UserDefaults.standard.integer(forKey: Keys.healthUpgradeCount)
        pemain.kaliNaikTarafSerangan = UserDefaults.standard.integer(forKey: Keys.attackUpgradeCount)
        pemain.kaliNaikTarafPertahanan = UserDefaults.standard.integer(forKey: Keys.defenseUpgradeCount)
        pemain.kaliNaikTarafPemulihan = UserDefaults.standard.integer(forKey: Keys.recoveryUpgradeCount)
        pemain.jumlahPetaDibuka = UserDefaults.standard.integer(forKey: Keys.unlockedMapCount)

        return pemain
    }

    // MARK: - Clear Methods
    static func clearAllData() {
        UserDefaults.standard.removeObject(forKey: Keys.maxHealth)
        UserDefaults.standard.removeObject(forKey: Keys.currentHealth)
        UserDefaults.standard.removeObject(forKey: Keys.attackPower)
        UserDefaults.standard.removeObject(forKey: Keys.defensePower)
        UserDefaults.standard.removeObject(forKey: Keys.recoveryAmount)
        UserDefaults.standard.removeObject(forKey: Keys.coins)
        UserDefaults.standard.removeObject(forKey: Keys.healthUpgradeCount)
        UserDefaults.standard.removeObject(forKey: Keys.attackUpgradeCount)
        UserDefaults.standard.removeObject(forKey: Keys.defenseUpgradeCount)
        UserDefaults.standard.removeObject(forKey: Keys.recoveryUpgradeCount)
        UserDefaults.standard.removeObject(forKey: Keys.unlockedMapCount)
    }

    // MARK: - Check Methods
    static func hasPlayerData() -> Bool {
        return UserDefaults.standard.object(forKey: Keys.maxHealth) != nil
    }
}
