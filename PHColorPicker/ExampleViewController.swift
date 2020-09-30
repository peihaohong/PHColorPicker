//
//  ExampleViewController.swift
//  PHColorPicker
//
//  Created by hph on 2020/9/29.
//  Copyright © 2020 hph. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    
    @IBOutlet weak var colorWheel: ColorWheel!
    @IBOutlet weak var colorChose: UIView!
    @IBOutlet weak var brightSlider: BrightnessSlider!
    
    var currentColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UIRectEdgeNone
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.navigationItem.title = "取色器示例"
        initColorWheel()
    }
    
    func initColorWheel(){
        colorWheel.WheelColorChange = {
            ( color : UIColor ) -> Void in
            self.colorChose.backgroundColor = color
            self.brightSlider.setKeyColor(color)
            self.currentColor = color
        }
        
        brightSlider.addTarget(self, action: #selector(brightnessSliderChange), for: .valueChanged)
    }
    
    @objc func brightnessSliderChange(){
         setColorBrightness(brightSlider.valueSlider)
        print(brightSlider.valueSlider)
    }
    
    func setColorBrightness(_ brightnessNew : CGFloat)
    {
        var hue:CGFloat = 0.0
        var saturation:CGFloat = 0.0
        var brightness:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        //获取该颜色的几项值
        currentColor?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
         
        //重新把几项值+新亮度重新组合成新颜色
        let newColor = UIColor.init(hue: hue, saturation: saturation, brightness: 1 - brightnessNew, alpha: alpha)
        self.colorChose.backgroundColor = newColor
    }
    
    
    
    
}
