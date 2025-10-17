
import Foundation

// 游戏管理器（单例）
class PengurusPermainan {
    static let gongXiang = PengurusPermainan()

    var pemain: MaklumatPemain
    let pengurusGeladak: PengurusGeladak
    var suoYouDiTu: [MaklumatPeta]

    private init() {
        self.pemain = MaklumatPemain()
        self.pengurusGeladak = PengurusGeladak()
        self.suoYouDiTu = MaklumatPeta.chuangJianSuoYouDiTu()

        // 从UserDefaults加载玩家数据
        jiazaiWanJiaShujutake()
    }

    // 保存玩家数据
    func simpanData() {
        UserDefaultsManager.savePlayerData(pemain: pemain)
    }

    // 加载玩家数据
    private func jiazaiWanJiaShujutake() {
        if let loadedPemain = UserDefaultsManager.loadPlayerData() {
            pemain = loadedPemain
        }
    }

    // 解锁下一个地图
    func bukaPeta() {
        pemain.jumlahPetaDibuka += 1
        simpanData()
    }

    // 重置游戏数据
    func setelSemulakanPermainan() {
        UserDefaultsManager.clearAllData()
        pemain = MaklumatPemain()
    }
}
