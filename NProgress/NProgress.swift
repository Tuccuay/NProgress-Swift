//
//  NProgress.swift
//  NProgress
//
//  Created by 洪朔 on 2017/2/7.
//  Copyright © 2017年 Tuccuay. All rights reserved.
//

import UIKit

public class NProgress: UIView {
    
    public var isProgressing: Bool = false
    public var minimum: Double = 0.08
    public var progress: Double?
    public var speed: Double = 200
    public var trickle: Bool = true
    public var trickleSpeed: Double = 200
    
    
    public var height: Double = 3
    public var color: UIColor = UIColor(red:0.16, green:0.87, blue:0.57, alpha:1.0)
    
    private var progressLayer: CAShapeLayer?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let shared = NProgress()
    
    public func start() {
        
        set(minimum)
    }
    
    public func inc(_ amount: Double? = nil) {
        
        guard let progress = progress else {
            start()
            return
        }
        
        if progress > 1 { return }
        
        let n: Double = {
            
            if let amount = amount {
                return amount
            }
            
            switch progress {
            case 0..<0.2: return 0.1
            case 0.2..<0.5: return 0.04
            case 0.5..<0.8: return 0.02
            case 0.8..<0.99: return 0.005
            default: return 0
            }
        }()
        
        let value = clamp(n: n + progress, min: 0, max: 0.994)
        
        set(value)
    }
    
    public func set(_ progress: Double) {
        
        if progressLayer == nil {
            prepareProgressLayer()
        }
        
        let lineY = height / 2.0
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: lineY))
        path.addLine(to: CGPoint(x: progress * Double(bounds.width), y: lineY))
        
        let anim = CABasicAnimation(keyPath: "path")
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        anim.duration = speed * 0.001
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.toValue = path.cgPath
        
        progressLayer?.add(anim, forKey: nil)
        
        self.progress = progress
    }
    
    public func done() {
        set(1)
        
        
        
        remove()
    }
    
    private func remove() {
        
    }
    
    private func prepareProgressLayer() {
        let prepareLayer = CAShapeLayer()
        //        prepareLayer.frame = bounds
        prepareLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 10)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 1))
        path.addLine(to: CGPoint(x: 0, y: 1))
        
        prepareLayer.path = path.cgPath
        prepareLayer.strokeColor = color.cgColor
        prepareLayer.lineWidth = CGFloat(height)
        
        prepareLayer.shadowColor = UIColor.black.cgColor
        prepareLayer.shadowRadius = 4
        prepareLayer.shadowOpacity = 1
        prepareLayer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.addSublayer(prepareLayer)
        self.progressLayer = prepareLayer
    }
    
    
}

private extension NProgress {
    
    func clamp(n: Double, min: Double, max: Double) -> Double {
        if (n < min) { return min }
        if (n > max) { return max }
        return n;
    }
}
