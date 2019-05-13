//
//  Loader.swift
//  MyMovieApp
//
//  Created by Yan Rips on 31/03/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

class Loader: UIView {
    var shapeLayer:CAShapeLayer!
    var animating: Bool!
    private var rotate:CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    func initView(){
        shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: self.frame.width/2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        //mainView.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(shapeLayer)
    }
    func animateCircleRotation(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: self.rotateBy)}, completion:{ (bool) in
                if self.animating{
                    self.animateCircleRotation()
                }
        })
    }
    func animateCircleStroke(){
        shapeLayer.strokeEnd = 0
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            if self.animating{
                self.animateCircleStroke()
            }
        })
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fromValue = 0
        basicAnimation.autoreverses = true
        shapeLayer.add(basicAnimation, forKey: "basicAnim")
        CATransaction.commit()
    }
    func beginAnimate(){
        animating = true
        animateCircleRotation()
        animateCircleStroke()
        
    }
    var rotateBy: CGFloat{
        get{
            rotate -= 1
            return rotate
        }
    }
    func stopAnimate(){
        animating = false
        shapeLayer.removeAllAnimations()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
