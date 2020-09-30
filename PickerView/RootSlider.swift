//
//  RootSlider.swift
//  PHColorPicker
//
//  Created by hph on 2020/9/29.
//  Copyright © 2020 hph. All rights reserved.
//

import UIKit

class RootSlider: UIControl {
    var sliderAimingView :UIImageView?
    var  isHorizontal = true
    var valueSlider : CGFloat = 0.0
    let ainmingWidth : CGFloat = 40.0
    var brightnessChange : ((CGFloat) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        setupSubViews()
    }
    
    func setupSubViews()
    {
        let frame = self.frame
        isHorizontal = frame.size.width > frame.size.height
        
        sliderAimingView = UIImageView.init(image: UIImage.init(named: "targetLight"))
        self.addSubview(sliderAimingView!)
//        self.backgroundColor = UIColor.blue
        self.isUserInteractionEnabled = true
        self.valueSlider = 0.0
    }
    
    func setValue() {
        //若是水平 则横坐标为视图 视图的宽*value
        //若是垂直 则横坐标为视图二分一
        let x = isHorizontal ? frame.size.width * valueSlider : frame.size.width / 2
        let y = isHorizontal ? frame.size.height / 2 : frame.size.width * valueSlider
        sliderAimingView?.center = CGPoint.init(x: x, y: y)
    }
    
    
    func mapPointToValue(_ point : CGPoint)
    {
        valueSlider = isHorizontal ? point.x / frame.size.width : point.y / frame.size.height
        setValue()
        self.sendActions(for: .valueChanged)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        let   canMove = isHorizontal ? location.x < frame.size.width && location.x >= 0 : location.y  < frame.size.height && location.y >= 0
        
        if canMove {
            self.mapPointToValue(touch.location(in: self))
            return true
        }else{
            return false
        }
        
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let canMove = isHorizontal ? location.x < frame.size.width && location.x >= 0 : location.y  < frame.size.height && location.y >= 0
        
        if canMove {
            self.mapPointToValue(touch.location(in: self))
            return true
        }else{
            return false
        }
        
        
        
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.continueTracking(touch!, with: event)
    }
    override func didAddSubview(_ subview: UIView) {
        self.bringSubviewToFront(sliderAimingView!)
    }
}
