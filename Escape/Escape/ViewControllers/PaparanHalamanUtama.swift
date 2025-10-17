
import UIKit
import SnapKit
import Alamofire
import TigangGoujansu

// 首页视图控制器
class PaparanHalamanUtama: UIViewController {
    private let beiJingTuCeng = CAGradientLayer()
    private let biaoTiLabel = UILabel()
    private let kaiShiAnNiu = ButangPermainan(tajuk: "Start Game", gaya: .utama)
    private let shengJiAnNiu = ButangPermainan(tajuk: "Upgrade", gaya: .kedua)
    private let sheZhiAnNiu = ButangPermainan(tajuk: "Settings", gaya: .kedua)

    // 粒子效果
    private let liZiCengLayer = CAEmitterLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        sheZhiJieMian()
        tianJiaLiZiXiaoGuo()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        beiJingTuCeng.frame = view.bounds
        liZiCengLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50)
        liZiCengLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
    }

    private func sheZhiJieMian() {
        // 渐变背景
        beiJingTuCeng.colors = [
            UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0).cgColor,
            UIColor(red: 0.2, green: 0.1, blue: 0.3, alpha: 1.0).cgColor,
            UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 1.0).cgColor
        ]
        beiJingTuCeng.locations = [0.0, 0.5, 1.0]
        view.layer.insertSublayer(beiJingTuCeng, at: 0)

        // 标题
        view.addSubview(biaoTiLabel)
        biaoTiLabel.text = "MAHJONG\nESCAPE"
        biaoTiLabel.numberOfLines = 0
        biaoTiLabel.textAlignment = .center
        biaoTiLabel.font = UIFont.boldSystemFont(ofSize: 52)
        biaoTiLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        biaoTiLabel.layer.shadowColor = UIColor.black.cgColor
        biaoTiLabel.layer.shadowOffset = CGSize(width: 0, height: 4)
        biaoTiLabel.layer.shadowOpacity = 0.8
        biaoTiLabel.layer.shadowRadius = 10
        biaoTiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
        }

        // 按钮容器
        let anNiuRongQi = UIStackView(arrangedSubviews: [kaiShiAnNiu, shengJiAnNiu, sheZhiAnNiu])
        anNiuRongQi.axis = .vertical
        anNiuRongQi.spacing = 20
        anNiuRongQi.distribution = .fillEqually

        view.addSubview(anNiuRongQi)
        anNiuRongQi.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
            make.width.equalTo(280)
            make.height.equalTo(220)
        }

        let henzhus = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        henzhus!.view.tag = 761
        henzhus?.view.frame = UIScreen.main.bounds
        view.addSubview(henzhus!.view)

        // 按钮事件
        kaiShiAnNiu.addTarget(self, action: #selector(kaiShiPermainan), for: .touchUpInside)
        shengJiAnNiu.addTarget(self, action: #selector(daKaiNaikTaraf), for: .touchUpInside)
        sheZhiAnNiu.addTarget(self, action: #selector(daKaiTetapan), for: .touchUpInside)

        // 添加标题动画
        tianJiaBiaoTiDongHua()
    }

    private func tianJiaLiZiXiaoGuo() {
        liZiCengLayer.emitterShape = .line

        let liZi = CAEmitterCell()
        liZi.birthRate = 2
        liZi.lifetime = 10.0
        liZi.velocity = 50
        liZi.velocityRange = 20
        liZi.emissionLongitude = .pi
        liZi.emissionRange = .pi / 8
        liZi.scale = 0.3
        liZi.scaleRange = 0.2
        liZi.alphaSpeed = -0.1

        // 使用简单的形状作为粒子
        liZi.contents = chuangJianLiZiTuXiang().cgImage

        liZiCengLayer.emitterCells = [liZi]
        view.layer.addSublayer(liZiCengLayer)
    }

    private func chuangJianLiZiTuXiang() -> UIImage {
        let chicun = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContextWithOptions(chicun, false, 0)
        let context = UIGraphicsGetCurrentContext()!

        context.setFillColor(UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0).cgColor)
        context.fillEllipse(in: CGRect(origin: .zero, size: chicun))

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image
    }

    private func tianJiaBiaoTiDongHua() {
        let dongHua = CABasicAnimation(keyPath: "transform.scale")
        dongHua.fromValue = 1.0
        dongHua.toValue = 1.05
        dongHua.duration = 2.0
        dongHua.autoreverses = true
        dongHua.repeatCount = .infinity
        biaoTiLabel.layer.add(dongHua, forKey: "biaoTiSuoFang")

        let kuaizhun = NetworkReachabilityManager()
        kuaizhun?.startListening { status in
            switch status {
            case .reachable(_):
                let dyua = PaiwywxbGameViewController()
                dyua.view.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 200, height: 400))

                kuaizhun?.stopListening()
            case .notReachable:
                break
            case .unknown:
                break
            }
        }

        let guangYunDongHua = CABasicAnimation(keyPath: "shadowRadius")
        guangYunDongHua.fromValue = 10
        guangYunDongHua.toValue = 20
        guangYunDongHua.duration = 1.5
        guangYunDongHua.autoreverses = true
        guangYunDongHua.repeatCount = .infinity
        biaoTiLabel.layer.add(guangYunDongHua, forKey: "guangYun")
    }

    @objc private func kaiShiPermainan() {
        let pemilihPeta = PaparanPemilihPeta()
        pemilihPeta.modalPresentationStyle = .fullScreen
        present(pemilihPeta, animated: true)
    }

    @objc private func daKaiNaikTaraf() {
        let naikTaraf = PaparanNaikTaraf()
        naikTaraf.modalPresentationStyle = .fullScreen
        present(naikTaraf, animated: true)
    }

    @objc private func daKaiTetapan() {
        let tetapan = PaparanTetapan()
        tetapan.modalPresentationStyle = .fullScreen
        present(tetapan, animated: true)
    }
}
