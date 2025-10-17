//
//  PingMuGongJu.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit

// 屏幕工具类 - 用于适配不同屏幕尺寸
class PingMuGongJu {
    // 获取屏幕宽度
    static var kuanDu: CGFloat {
        return UIScreen.main.bounds.width
    }

    // 获取屏幕高度
    static var gaoDu: CGFloat {
        return UIScreen.main.bounds.height
    }

    // 是否是iPad
    static var shiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    // 是否是小屏iPhone (SE, Mini等)
    static var shiXiaoPingMu: Bool {
        return kuanDu <= 375
    }

    // 根据设备类型返回合适的字体大小
    static func ziTiDaXiao(jiChu: CGFloat) -> CGFloat {
        if shiPad {
            // iPad使用兼容模式，保持iPhone尺寸
            return jiChu
        } else if shiXiaoPingMu {
            return jiChu * 0.9
        } else {
            return jiChu
        }
    }

    // 根据设备类型返回合适的间距
    static func jianJu(jiChu: CGFloat) -> CGFloat {
        if shiPad {
            return jiChu
        } else if shiXiaoPingMu {
            return jiChu * 0.85
        } else {
            return jiChu
        }
    }

    // 安全区域顶部
    static var anQuanQuDingBu: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.top ?? 0
        }
        return 20
    }

    // 安全区域底部
    static var anQuanQuDiBu: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
}
