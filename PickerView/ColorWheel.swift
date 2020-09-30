//
//  ColorWheel.swift
//  PHColorPicker
//
//  Created by hph on 2020/9/29.
//  Copyright © 2020 hph. All rights reserved.
//

import UIKit
import CoreGraphics.CGBitmapContext

struct ColorPath {
    var Path:UIBezierPath
    var Color:UIColor
}

class ColorWheel: UIControl {
    //取色盘
    var iVColorWheel : UIImageView?
    var iVAiming : UIImageView?
    var size = CGSize.zero
    var sectors = 360
    var WheelColorChange : ((UIColor) -> Void)?

    
    private var image:UIImage? = nil
    private var imageView:UIImageView? = nil
    private var paths = [ColorPath]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)   
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
    
    
    func colorChange(_ colorInput: UIColor ,fn: (_ color : UIColor ) -> Void)
    {
        fn(colorInput)
        
    }
    
    
    func colorAtPoint ( point: CGPoint) {
        for colorPath in 0..<paths.count {
            if paths[colorPath].Path.contains(point) {
                WheelColorChange!(paths[colorPath].Color)
//                return paths[colorPath].Color
            }
        }
//        return UIColor.clear
    }
    
    
    func addSubviews(){
        if(iVAiming == nil){
            
            iVAiming = UIImageView.init(image: UIImage.init(named: "targetLight"))
            iVAiming?.center = CGPoint.init(x: self.frame.width/2, y: self.frame.height/2)
            self.addSubview(iVAiming!)
            bringSubviewToFront(iVAiming!)
            self.isUserInteractionEnabled = true
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        let canMove = isInCircle(location)
        
        if canMove {
            colorAtPoint(point: location)
            iVAiming?.center = location
            print("在圆范围内")
            return true
        }else{
            print("在圆范围外")
            return false
        }
        
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let canMove = isInCircle(location)
        
        if canMove { 
            colorAtPoint(point: location)
            print("在圆范围内continue")
            iVAiming?.center = location
            return true
        }else{
            print("在圆范围外continue")
            return false
        }
        
        
        
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.continueTracking(touch!, with: event)
        
    }
    
    func isInCircle(_ point : CGPoint) -> Bool
    {
        let radius = frame.size.width/2.0;
        let center = CGPoint.init(x: radius, y: radius)
        let dx = abs(point.x - center.x);
        let dy = abs(point.y - center.y);
        let dis = hypot(dx, dy);
        return dis <= radius;
    }
    
    
    override func draw(_ rect: CGRect) {
        let radius = CGFloat ( min(bounds.size.width, bounds.size.height) / 2.0 ) 
        //基础参数
        let angle:CGFloat = CGFloat(2.0) *  (.pi) / CGFloat(sectors)
        var colorPath:ColorPath = ColorPath(Path:UIBezierPath(), Color:UIColor.clear)
        
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: bounds.size.width, height: bounds.size.height), true, 0)
        
        UIColor.white.setFill()
        UIRectFill(bounds )
        
        
        for sector in 0..<sectors {
            //这里的center是给imageview用的,它是子视图,所以应该使用bounds的参数做它的center
            let center = CGPoint(x: bounds.width - (bounds.width / 2.0),y: bounds.height - (bounds.height / 2.0) )
            colorPath.Path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(sector) * angle, endAngle: (CGFloat(sector) + CGFloat(1)) * angle, clockwise: true)
            colorPath.Path.addLine(to: center)
            colorPath.Path.close()
            
            let color = UIColor(hue: CGFloat(sector)/CGFloat(sectors), saturation: CGFloat(1), brightness: CGFloat(1), alpha: CGFloat(1))
            color.setFill()
            color.setStroke()
            
            colorPath.Path.fill()
            colorPath.Path.stroke()
            colorPath.Color = color
            
            paths.append(colorPath)
        }
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard image != nil else { return }
        let imageView = UIImageView (image: image)
        self.addSubview(imageView)
        self.addSubviews()
        
    }
    
    
    
    
}





