
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
        UserDefaults.standard.set(pemain.maksimumNyawa, forKey: "wanJiaZuiDaXueLiang")
        UserDefaults.standard.set(pemain.nyawaSemasa, forKey: "wanJiaDangQianXueLiang")
        UserDefaults.standard.set(pemain.kuasaSerangan, forKey: "wanJiaGongJiLi")
        UserDefaults.standard.set(pemain.kuasaPertahanan, forKey: "wanJiaFangYuLi")
        UserDefaults.standard.set(pemain.jumlahPemulihan, forKey: "wanJiaHuiFuLiang")
        UserDefaults.standard.set(pemain.syiling, forKey: "wanJiaJinBi")
        UserDefaults.standard.set(pemain.kaliNaikTarafNyawa, forKey: "xueLiangShengJiCiShu")
        UserDefaults.standard.set(pemain.kaliNaikTarafSerangan, forKey: "gongJiLiShengJiCiShu")
        UserDefaults.standard.set(pemain.kaliNaikTarafPertahanan, forKey: "fangYuLiShengJiCiShu")
        UserDefaults.standard.set(pemain.kaliNaikTarafPemulihan, forKey: "huiFuLiangShengJiCiShu")
        UserDefaults.standard.set(pemain.jumlahPetaDibuka, forKey: "yiJieSuoDiTuShuLiang")
    }

    // 加载玩家数据
    private func jiazaiWanJiaShujutake() {
        if UserDefaults.standard.object(forKey: "wanJiaZuiDaXueLiang") != nil {
            pemain.maksimumNyawa = UserDefaults.standard.integer(forKey: "wanJiaZuiDaXueLiang")
            pemain.nyawaSemasa = UserDefaults.standard.integer(forKey: "wanJiaDangQianXueLiang")
            pemain.kuasaSerangan = UserDefaults.standard.integer(forKey: "wanJiaGongJiLi")
            pemain.kuasaPertahanan = UserDefaults.standard.integer(forKey: "wanJiaFangYuLi")
            pemain.jumlahPemulihan = UserDefaults.standard.integer(forKey: "wanJiaHuiFuLiang")
            pemain.syiling = UserDefaults.standard.integer(forKey: "wanJiaJinBi")
            pemain.kaliNaikTarafNyawa = UserDefaults.standard.integer(forKey: "xueLiangShengJiCiShu")
            pemain.kaliNaikTarafSerangan = UserDefaults.standard.integer(forKey: "gongJiLiShengJiCiShu")
            pemain.kaliNaikTarafPertahanan = UserDefaults.standard.integer(forKey: "fangYuLiShengJiCiShu")
            pemain.kaliNaikTarafPemulihan = UserDefaults.standard.integer(forKey: "huiFuLiangShengJiCiShu")
            pemain.jumlahPetaDibuka = UserDefaults.standard.integer(forKey: "yiJieSuoDiTuShuLiang")
        }
    }

    // 解锁下一个地图
    func bukaPeta() {
        pemain.jumlahPetaDibuka += 1
        simpanData()
    }

    // 重置游戏数据
    func setelSemulakanPermainan() {
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

        pemain = MaklumatPemain()
    }
}
