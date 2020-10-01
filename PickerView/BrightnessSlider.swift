//
//  BrightnessSlider.swift
//  PHColorPicker
//
//  Created by hph on 2020/9/29.
//  Copyright © 2020 hph. All rights reserved.
//

import UIKit

class BrightnessSlider: UIControl {
    //选中的颜色,供外界调用
    var colorSelected : UIColor?
    private var keyColor : UIColor?
    private var gradientLayer = CAGradientLayer.init()
    private var sliderAimingView :UIImageView?
    private var isHorizontal = true
    private var valueSlider : CGFloat = 0.0
    private let ainmingWidth : CGFloat = 20.0
    private var brightnessChange : ((CGFloat) -> Void)?
    
    //MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayer()
    }
     
    
    func setupSubViews()
    {
        let frame = self.frame
        isHorizontal = frame.size.width > frame.size.height
        sliderAimingView = UIImageView.init(image: UIImage.init(named: "targetLight"))
        self.addSubview(sliderAimingView!)
        self.isUserInteractionEnabled = true
        self.valueSlider = 0.0
    }
    
    private func resetValue(){
           valueSlider = 0.0
           setValue()
       }
    
    
    private func setValue() {
        //若是水平 则横坐标为视图 视图的宽*value
        //若是垂直 则横坐标为视图二分一
        let x = isHorizontal ? frame.size.width * valueSlider : frame.size.width / 2
        let y = isHorizontal ? frame.size.width / 2 : frame.size.height * valueSlider
        sliderAimingView?.center = CGPoint.init(x: x, y: y)
        getCurrentColor()
        sendActions(for: .valueChanged)
    }
    private  func mapPointToValue(_ point : CGPoint)
    {
        valueSlider = isHorizontal ? point.x / frame.size.width : point.y / frame.size.height
        setValue()
    }
    
    private func getCurrentColor()
    {
        var hue:CGFloat = 0.0
        var saturation:CGFloat = 0.0
        var brightness:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        //获取该颜色的几项值
        keyColor?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        //重新把几项值+新亮度重新组合成新颜色
        colorSelected = UIColor.init(hue: hue, saturation: saturation, brightness: 1 - valueSlider, alpha: alpha)
    }
    
    //MARK: - 监听事件
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
        _ = self.continueTracking(touch!, with: event)
    }
    override func didAddSubview(_ subview: UIView) {
        self.bringSubviewToFront(sliderAimingView!)
    }
    
    
    
    
    
    //MARK: - 渐变层设置
    private func setupLayer(){
        gradientLayer = CAGradientLayer.init()
        gradientLayer.bounds = bounds
        gradientLayer.position = CGPoint.init(x:frame.size.width * 0.5, y: frame.size.height * 0.5)
        if(isHorizontal){
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        }else{
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        }
        
        gradientLayer.cornerRadius = isHorizontal ? frame.size.height/2 : frame.size.width/2
        gradientLayer.borderWidth = 2
        gradientLayer.masksToBounds = true
        gradientLayer.borderColor = UIColor.clear.cgColor
        
        if (self.responds(to: #selector(getter: contentScaleFactor))){
            self.contentScaleFactor = UIScreen.main.scale
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
        setKeyColor(UIColor.blue)
        
    }
    
    //MARK: - 公开方法
    
   
    
    func setKeyColor(_ color: UIColor)
    {
        keyColor = color
        resetValue()
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        gradientLayer.colors = [color.cgColor,UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor]
        CATransaction.commit()
    }
    
    
    
}
