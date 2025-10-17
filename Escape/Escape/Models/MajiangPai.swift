
import Foundation

// 麻将牌类型
enum MajiangPaiLeiXing: String {
    case uisjye = "uisjye"  // 筒
    case oape = "oape"      // 万
    case ratte = "ratte"    // 条
    case posue = "posue"    // 特殊牌
}

// 麻将牌模型
struct MajiangPai: Equatable, Hashable {
    let leiXing: MajiangPaiLeiXing
    let shuZhi: Int
    let id: UUID

    init(leiXing: MajiangPaiLeiXing, shuZhi: Int) {
        self.leiXing = leiXing
        self.shuZhi = shuZhi
        self.id = UUID()
    }

    // 获取图片名称
    var tuPianMingCheng: String {
        return "\(leiXing.rawValue)-\(shuZhi)"
    }

    // 是否是特殊牌
    var shiTeShuPai: Bool {
        return leiXing == .posue
    }

    // 是否是数值牌
    var shiShuZhiPai: Bool {
        return !shiTeShuPai
    }

    static func == (lhs: MajiangPai, rhs: MajiangPai) -> Bool {
        return lhs.leiXing == rhs.leiXing && lhs.shuZhi == rhs.shuZhi
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(leiXing)
        hasher.combine(shuZhi)
    }

    // 排序权重：用于排序
    var paiXuQuanZhong: Int {
        let leiXingQuanZhong: Int
        switch leiXing {
        case .oape:    leiXingQuanZhong = 0  // 万排第一
        case .uisjye:  leiXingQuanZhong = 100  // 筒排第二
        case .ratte:   leiXingQuanZhong = 200  // 条排第三
        case .posue:   leiXingQuanZhong = 300  // 特殊牌排最后
        }
        return leiXingQuanZhong + shuZhi
    }
}

// 扩展：实现Comparable协议以支持排序
extension MajiangPai: Comparable {
    static func < (lhs: MajiangPai, rhs: MajiangPai) -> Bool {
        return lhs.paiXuQuanZhong < rhs.paiXuQuanZhong
    }
}

// 牌组合类型
enum PaiZuHeLeiXing {
    case duiZi([MajiangPai])           // 对子（2张相同）
    case sanZhang([MajiangPai])        // 3张相同
    case gang([MajiangPai])            // 杠（4张相同）
    case shunZi([MajiangPai])          // 顺子

    var paiShuLiang: Int {
        switch self {
        case .duiZi(let pais): return pais.count
        case .sanZhang(let pais): return pais.count
        case .gang(let pais): return pais.count
        case .shunZi(let pais): return pais.count
        }
    }

    var pais: [MajiangPai] {
        switch self {
        case .duiZi(let pais): return pais
        case .sanZhang(let pais): return pais
        case .gang(let pais): return pais
        case .shunZi(let pais): return pais
        }
    }
}
