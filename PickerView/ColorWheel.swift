//
//  ColorWheel.swift
//  PHColorPicker
//
//  Created by hph on 2020/9/29.
//  Copyright © 2020 hph. All rights reserved.
//

import UIKit

class ColorWheel: UIControl {
    //取色盘
    var iVColorWheel : UIImageView?
    var iVAiming : UIImageView?

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
    }
     
    
    func addSubviews(){
        if(iVAiming == nil && iVColorWheel == nil){
            iVColorWheel = UIImageView.init(image: UIImage.init(named: "pickerColorWheel"));
            iVColorWheel?.frame = self.bounds
            iVColorWheel?.contentMode = .center
            
            iVAiming = UIImageView.init(image: UIImage.init(named: "targetLight"))
            
            self.addSubview(iVColorWheel!)
            self.addSubview(iVAiming!)
            bringSubviewToFront(iVAiming!)
            self.isUserInteractionEnabled = true
        }
    }
}
