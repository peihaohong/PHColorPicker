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
    
    @IBInspectable var size:CGSize = CGSize.zero { didSet { setNeedsDisplay()} }
       @IBInspectable var sectors:Int = 360 { didSet { setNeedsDisplay()} }
    
    private var image:UIImage? = nil
    private var imageView:UIImageView? = nil
    private var paths = [ColorPath]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
    }
    
    func colorAtPoint ( point: CGPoint) -> UIColor {
           for colorPath in 0..<paths.count {
               if paths[colorPath].Path.contains(point) {
                   return paths[colorPath].Color
               }
           }
           return UIColor.clear
       }
    
    
    func addSubviews(){
        if(iVAiming == nil){
//            iVColorWheel = UIImageView.init(image: UIImage.init(named: "pickerColorWheel"));
//            iVColorWheel?.frame = self.bounds
//            iVColorWheel?.contentMode = .center
            
            iVAiming = UIImageView.init(image: UIImage.init(named: "targetLight"))
            iVAiming?.center = CGPoint.init(x: self.frame.width/2, y: self.frame.height/2)
            
//            self.addSubview(iVColorWheel!)
            self.addSubview(iVAiming!)
            bringSubviewToFront(iVAiming!)
            self.isUserInteractionEnabled = true
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
         
        let location = touch.location(in: self)
        let canMove = isInCircle(location)
        
        if canMove {
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
        let radius = CGFloat ( min(bounds.size.width, bounds.size.height) / 2.0 ) * 0.90
             
             let angle:CGFloat = CGFloat(2.0) *  (.pi) / CGFloat(sectors)
             
             var colorPath:ColorPath = ColorPath(Path:UIBezierPath(), Color:UIColor.clear)
             
             self.center = CGPoint(x: self.bounds.width - (self.bounds.width / 2.0),y: self.bounds.height - (self.bounds.height / 2.0) )
             UIGraphicsBeginImageContextWithOptions(CGSize(width: bounds.size.width, height: bounds.size.height), true, 0)
             
             UIColor.white.setFill()
             UIRectFill(frame)
             
             for sector in 0..<sectors {
                 let center = self.center
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
             guard let oc = superview?.center else { return }
             self.center = oc
         }
    
    
//    func colorAtPixel(_ point : CGPoint) -> UIColor
//    {
//        let RGBA : CGFloat = 4.0;
//        let pointX = trunc(point.x)
//        let pointY = trunc(point.y)
//        let cgImage = iVColorWheel?.image?.cgImage
//        let width = iVColorWheel?.image?.size.width
//        let height = iVColorWheel?.image?.size.height
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bytesPerPixel = RGBA
////        let bytesPerRow = bytesPerPixel * width
//        let bytesPerRow = bytesPerPixel * width!
//        let bitsPerCompnent = 8
//        let rawData = malloc(Int(width! * height! * CGFloat.init(MemoryLayout<CUnsignedChar>.size) *  RGBA))!.assumingMemoryBound(to: UInt8.self)
//        var pixelData = [0,0,0,0]
////        let bitmapInfo = CGBitmapInfo.init(<#T##sequence: Sequence##Sequence#>)
//        var context =   CGContext.init(data: rawData, width:Int.init(width!) , height: Int.init(height!), bitsPerComponent: bitsPerCompnent, bytesPerRow: Int.init(bytesPerRow), space: colorSpace, bitmapInfo:CGBitmapInfo.byteOrder32Big.rawValue )
//        ctm
//    }
    
   
}


//
//  ColorWheel.swift
//  ColorWheel
//
//  Created by Tommie N. Carter, Jr., MBA on 4/9/15.
//  Copyright (c) 2015 MING Technology. All rights reserved.
//

/*import UIKit


struct ColorPath {
    var Path:UIBezierPath
    var Color:UIColor
}


@IBDesignable
class ColorWheel: UIView {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        center = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        center = self.center
    }
    
    private var image:UIImage? = nil
    private var imageView:UIImageView? = nil
    private var paths = [ColorPath]()
    
    @IBInspectable var size:CGSize = CGSize.zero { didSet { setNeedsDisplay()} }
    @IBInspectable var sectors:Int = 360 { didSet { setNeedsDisplay()} }
    
    func colorAtPoint ( point: CGPoint) -> UIColor {
        for colorPath in 0..<paths.count {
            if paths[colorPath].Path.contains(point) {
                return paths[colorPath].Color
            }
        }
        return UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        
        let radius = CGFloat ( min(bounds.size.width, bounds.size.height) / 2.0 ) * 0.90
        
        let angle:CGFloat = CGFloat(2.0) *  (.pi) / CGFloat(sectors)
        
        var colorPath:ColorPath = ColorPath(Path:UIBezierPath(), Color:UIColor.clear)
        
        self.center = CGPoint(x: self.bounds.width - (self.bounds.width / 2.0),y: self.bounds.height - (self.bounds.height / 2.0) )
        UIGraphicsBeginImageContextWithOptions(CGSize(width: bounds.size.width, height: bounds.size.height), true, 0)
        
        UIColor.white.setFill()
        UIRectFill(frame)
        
        for sector in 0..<sectors {
            let center = self.center
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
        guard let oc = superview?.center else { return }
        self.center = oc
    }
}
*/


