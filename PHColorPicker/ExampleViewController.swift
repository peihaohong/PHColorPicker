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
    @IBOutlet weak var viewColorInput: UIView!
    @IBOutlet weak var viewColorChose: UIView!
    
    @IBOutlet weak var brightSlider: BrightnessSlider!
    @IBOutlet weak var brightSliderVertical: BrightnessSlider!
    
    @IBOutlet weak var textField: UITextField!
    
    var currentColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UIRectEdgeNone
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.navigationItem.title = "取色器示例"
        initColorWheel()  
    }
    
    func initColorWheel(){ 
        colorWheel.addTarget(self, action: #selector(colorWheelValueChanged), for: .valueChanged)
        brightSlider.addTarget(self, action: #selector(brightnessSliderChange), for: .valueChanged)
        
        brightSliderVertical.addTarget(self, action: #selector(brightnessSliderVerticalChange), for: .valueChanged)
    }
    @objc func brightnessSliderVerticalChange(){
            viewColorChose.backgroundColor = brightSliderVertical.colorSelected!
       }
    @objc func brightnessSliderChange(){
         viewColorChose.backgroundColor = brightSlider.colorSelected!
    }
    @objc func colorWheelValueChanged(){
         brightSlider.setKeyColor(colorWheel.colorSelected!)
         brightSliderVertical.setKeyColor(colorWheel.colorSelected!)
        }
    
 
    
    @IBAction func btnSureOnClick(_ sender: UIButton) {
        
        let color = UIColor.init(hexString: textField.text!)
        self.viewColorInput.backgroundColor = color
        
    }
    
    
    
}
