//
//  UIViewExtension.swift
//
//  Created by Pawarit Phrompuak on 4/26/16.
//  Copyright © 2016 - 2026. All rights reserved.
//

import UIKit

enum Position {
    case Horizontal
    case Vertical
}

extension CGRect {
    func randomPointInRect() -> CGPoint {
        let origin = self.origin
        return CGPoint(x: CGFloat(arc4random_uniform(UInt32(self.width))) + origin.x, y: CGFloat(arc4random_uniform(UInt32(self.height))) + origin.y)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView..., topPadding: CGFloat = 0, leftPadding: CGFloat = 0, bottomPadding: CGFloat = 0, rightPadding: CGFloat = 0) {
        var viewsDictionary = [String: UIView]()
        
        var metrics = [String: Any]()
        
        if #available(iOS 11.0, *) {
            metrics = [
                "top": safeAreaInsets.top + topPadding,
                "bottom": safeAreaInsets.bottom + bottomPadding,
                "left": safeAreaInsets.left + leftPadding,
                "right": safeAreaInsets.right + rightPadding,
            ]
            
        } else {
            metrics = [
                "top": topPadding,
                "bottom": bottomPadding,
                "left": leftPadding,
                "right": rightPadding,
            ]
        }
        
        let _ = views.enumerated().compactMap{
            (index, view) in
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: viewsDictionary))
    }
    
    func addConstraintsWithFormatAndOptions(_ format: String, views: UIView..., options: NSLayoutConstraint.FormatOptions, topPadding: CGFloat = 0, leftPadding: CGFloat = 0, bottomPadding: CGFloat = 0, rightPadding: CGFloat = 0) {
        var viewsDictionary = [String: UIView]()
        
        var metrics = [String: Any]()
        
        if #available(iOS 11.0, *) {
            metrics = [
                "top": safeAreaInsets.top + topPadding,
                "bottom": safeAreaInsets.bottom + bottomPadding,
                "left": safeAreaInsets.left + leftPadding,
                "right": safeAreaInsets.right + rightPadding,
            ]
            
        } else {
            metrics = [
                "top": topPadding,
                "bottom": bottomPadding,
                "left": leftPadding,
                "right": rightPadding,
            ]
        }
        
        let _ = views.enumerated().compactMap{
            (index, view) in
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: viewsDictionary))
    }
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    func setShadow(){
        self.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
    }
    
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    func setBorder(color: UIColor = .black,width: CGFloat = 1) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        
    }
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    var snapshot: UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func constraint(withIdentifier:String) -> NSLayoutConstraint? {
        return self.constraints.filter{ $0.identifier == withIdentifier }.first
    }
    
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 3.0, opacity: Float = 0.6, color: CGColor = UIColor.black.cgColor, cornerRadius: CGFloat = 5) {
        
        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity
            
            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.cornerRadius = cornerRadius
            self.layer.addSublayer(gradientLayer)
        }
    }
    
    func removeAllShadows() {
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    /* Usage Example
    * bgView.addBottomRoundedEdge(desiredCurve: 1.5)
    */
    func addBottomRoundedEdge(desiredCurve: CGFloat) {
         let offset: CGFloat = self.frame.width / desiredCurve
         let bounds: CGRect = self.bounds
         
         let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
         let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
         let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
         let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
         rectPath.append(ovalPath)
         
         // Create the shape layer and set its path
         let maskLayer: CAShapeLayer = CAShapeLayer()
         maskLayer.frame = bounds
         maskLayer.path = rectPath.cgPath

         // Set the newly created shape layer as the mask for the view's layer
         self.layer.mask = maskLayer
        
        //setup Border for Mask
//        let borderLayer = CAShapeLayer()
//        borderLayer.path = rectPath.cgPath
//        borderLayer.lineWidth = 6
//        borderLayer.strokeColor = UIColor.white.cgColor
//        borderLayer.fillColor = UIColor.clear.cgColor
//        borderLayer.opacity = 0.3
//        borderLayer.frame = bounds
//        layer.addSublayer(borderLayer)
        
     }
    
    func roundedTop(){
        let halfWidth = self.bounds.width * 0.35
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: halfWidth,
                                                        height: 5))

        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
       layer.mask = maskLayer
        
        //setup Border for Mask
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskPath.cgPath
        borderLayer.lineWidth = 10
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.opacity = 0.1
        borderLayer.frame = bounds
//        layer.addSublayer(borderLayer)
    }
    
    func semiCircle(desiredCurve:CGFloat){
        let offset = bounds.size.height / desiredCurve
        let circlePath = UIBezierPath(arcCenter: CGPoint(x:
            bounds.size.width / 2, y: bounds.size.height + offset), radius: bounds.size.width / 2, startAngle: .pi, endAngle: .pi * 2, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        layer.mask = circleShape
        
        //setup Border for Mask
        let borderLayer = CAShapeLayer()
        borderLayer.path = circlePath.cgPath
        borderLayer.lineWidth = 6
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.opacity = 0.3
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    struct Constants {
        static let ExternalBorderName = "externalBorder"
    }

    func addExternalBorder(borderWidth: CGFloat = 2.0, borderColor: UIColor = UIColor.white,cornerRadius:CGFloat) {
        let externalBorder = CALayer()
        externalBorder.frame = CGRect(x: -borderWidth-2, y: -borderWidth-1, width: frame.size.width + borderWidth * borderWidth, height: frame.size.height + borderWidth * borderWidth)
        externalBorder.borderColor = borderColor.cgColor
        externalBorder.borderWidth = borderWidth
        externalBorder.name = Constants.ExternalBorderName
        externalBorder.opacity = 0.3
        layer.insertSublayer(externalBorder, at: 0)
        layer.masksToBounds = false
        externalBorder.cornerRadius = cornerRadius
        self.layer.addSublayer(externalBorder)
    }

    func removeExternalBorders() {
        layer.sublayers?.filter() { $0.name == Constants.ExternalBorderName }.forEach() {
            $0.removeFromSuperlayer()
        }
    }

    func removeExternalBorder(externalBorder: CALayer) {
        guard externalBorder.name == Constants.ExternalBorderName else { return }
        externalBorder.removeFromSuperlayer()
    }
    
    func addGradient(color1:UIColor,color2:UIColor,position:Position = .Vertical){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
        if position == .Horizontal{
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        }
        layer.addSublayer(gradientLayer)
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
    
}
