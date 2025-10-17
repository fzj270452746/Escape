//
//  AnimationHelper.swift
//  Escape
//
//  Created by Hades on 10/17/25.
//

import UIKit

// Animation Helper - Centralized animation utilities
class AnimationHelper {

    // MARK: - Scale Animations
    static func addPulseAnimation(to layer: CALayer, duration: Double = 2.0, fromScale: CGFloat = 1.0, toScale: CGFloat = 1.05) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = fromScale
        animation.toValue = toScale
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "pulseAnimation")
    }

    static func addButtonPressAnimation(to view: UIView, scale: CGFloat = 0.95, duration: Double = 0.1) {
        UIView.animate(withDuration: duration) {
            view.transform = CGAffineTransform(scaleX: scale, y: scale)
            view.alpha = 0.8
        }
    }

    static func addButtonReleaseAnimation(to view: UIView, duration: Double = 0.1) {
        UIView.animate(withDuration: duration) {
            view.transform = .identity
            view.alpha = 1.0
        }
    }

    // MARK: - Shadow Animations
    static func addGlowAnimation(to layer: CALayer, duration: Double = 1.5, fromRadius: CGFloat = 10, toRadius: CGFloat = 20) {
        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.fromValue = fromRadius
        animation.toValue = toRadius
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "glowAnimation")
    }

    // MARK: - Fade Animations
    static func fadeIn(view: UIView, duration: Double = 0.3, completion: (() -> Void)? = nil) {
        view.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1.0
        }, completion: { _ in
            completion?()
        })
    }

    static func fadeOut(view: UIView, duration: Double = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }, completion: { _ in
            completion?()
        })
    }

    // MARK: - Slide Animations
    static func slideIn(view: UIView, from direction: SlideDirection, duration: Double = 0.3, completion: (() -> Void)? = nil) {
        let originalTransform = view.transform

        switch direction {
        case .left:
            view.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        case .right:
            view.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        case .top:
            view.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height)
        case .bottom:
            view.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
        }

        UIView.animate(withDuration: duration, animations: {
            view.transform = originalTransform
        }, completion: { _ in
            completion?()
        })
    }

    // MARK: - Shake Animation
    static func shake(view: UIView, duration: Double = 0.5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [-10, 10, -8, 8, -5, 5, 0]
        view.layer.add(animation, forKey: "shake")
    }

    // MARK: - Bounce Animation
    static func bounce(view: UIView, duration: Double = 0.5) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: duration) {
                view.transform = .identity
            }
        }
    }

    // MARK: - Particle Effect
    static func createParticleLayer(bounds: CGRect, particleColor: UIColor, birthRate: Float = 2) -> CAEmitterLayer {
        let particleLayer = CAEmitterLayer()
        particleLayer.emitterShape = .line
        particleLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: -50)
        particleLayer.emitterSize = CGSize(width: bounds.width, height: 0)

        let particle = CAEmitterCell()
        particle.birthRate = birthRate
        particle.lifetime = 10.0
        particle.velocity = 50
        particle.velocityRange = 20
        particle.emissionLongitude = .pi
        particle.emissionRange = .pi / 8
        particle.scale = 0.3
        particle.scaleRange = 0.2
        particle.alphaSpeed = -0.1
        particle.contents = createParticleImage(color: particleColor).cgImage

        particleLayer.emitterCells = [particle]
        return particleLayer
    }

    private static func createParticleImage(color: UIColor) -> UIImage {
        let size = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: - Rotation Animation
    static func addRotationAnimation(to layer: CALayer, duration: Double = 2.0) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = duration
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "rotationAnimation")
    }

    // MARK: - Supporting Types
    enum SlideDirection {
        case left, right, top, bottom
    }
}
