
import Foundation

// 麻将牌类型
enum JenisKepingMahjong: String {
    case bulatan = "uisjye"  // 筒
    case karakter = "oape"      // 万
    case buluh = "ratte"    // 条
    case khas = "posue"    // 特殊牌
}

// 麻将牌模型
struct KepingMahjong: Equatable, Hashable {
    let jenis: JenisKepingMahjong
    let nilai: Int
    let id: UUID

    init(jenis: JenisKepingMahjong, nilai: Int) {
        self.jenis = jenis
        self.nilai = nilai
        self.id = UUID()
    }

    // 获取图片名称
    var namaGambar: String {
        return "\(jenis.rawValue)-\(nilai)"
    }

    // 是否是特殊牌
    var adakahKepingKhas: Bool {
        return jenis == .khas
    }

    // 是否是数值牌
    var adakahKepingNilai: Bool {
        return !adakahKepingKhas
    }

    static func == (lhs: KepingMahjong, rhs: KepingMahjong) -> Bool {
        return lhs.jenis == rhs.jenis && lhs.nilai == rhs.nilai
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(jenis)
        hasher.combine(nilai)
    }

    // 排序权重：用于排序
    var beratSusunan: Int {
        let beratJenis: Int
        switch jenis {
        case .karakter:    beratJenis = 0  // 万排第一
        case .bulatan:  beratJenis = 100  // 筒排第二
        case .buluh:   beratJenis = 200  // 条排第三
        case .khas:   beratJenis = 300  // 特殊牌排最后
        }
        return beratJenis + nilai
    }
}

// 扩展：实现Comparable协议以支持排序
extension KepingMahjong: Comparable {
    static func < (lhs: KepingMahjong, rhs: KepingMahjong) -> Bool {
        return lhs.beratSusunan < rhs.beratSusunan
    }
}

// 牌组合类型
enum JenisKombinasi {
    case pasangan([KepingMahjong])           // 对子（2张相同）
    case triple([KepingMahjong])        // 3张相同
    case kuad([KepingMahjong])            // 杠（4张相同）
    case lurus([KepingMahjong])          // 顺子

    var jumlahKeping: Int {
        switch self {
        case .pasangan(let kepings): return kepings.count
        case .triple(let kepings): return kepings.count
        case .kuad(let kepings): return kepings.count
        case .lurus(let kepings): return kepings.count
        }
    }

    var kepings: [KepingMahjong] {
        switch self {
        case .pasangan(let kepings): return kepings
        case .triple(let kepings): return kepings
        case .kuad(let kepings): return kepings
        case .lurus(let kepings): return kepings
        }
    }
}
