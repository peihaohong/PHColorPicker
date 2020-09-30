//
//  BrightnessSlider.swift
//  PHColorPicker
//
//  Created by hph on 2020/9/29.
//  Copyright © 2020 hph. All rights reserved.
//

import UIKit

class BrightnessSlider: RootSlider {
    
    var gradientLayer = CAGradientLayer.init()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
     
   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayer()
    }
    
    func setupLayer(){
        gradientLayer = CAGradientLayer.init()
        gradientLayer.bounds = bounds
        gradientLayer.position = CGPoint.init(x:frame.size.width * 0.5, y: frame.size.height * 0.5)
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 8.0
        gradientLayer.borderWidth = 2
        gradientLayer.masksToBounds = true
        gradientLayer.borderColor = UIColor.red.cgColor
        
        if (self.responds(to: #selector(getter: contentScaleFactor))){
            self.contentScaleFactor = UIScreen.main.scale
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        setKeyColor(UIColor.blue)
        
    }
    
    func setKeyColor(_ color: UIColor)
    {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        gradientLayer.colors = [color.cgColor,UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor]
        CATransaction.commit()
    }

}
