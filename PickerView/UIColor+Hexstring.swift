//
//  UIColor+Hexstring.swift
//  ColorTestApp
//
//  Created by hph on 2020/9/4.
//  Copyright © 2020 hph. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString:String){
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt64 = 0,g:UInt64 = 0,b:UInt64 = 0
        //进行转换
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
     
    
    var hexString: String? {
          var red: CGFloat = 0
          var green: CGFloat = 0
          var blue: CGFloat = 0
          var alpha: CGFloat = 0
           
          let multiplier = CGFloat(255.999999)
           
          guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
              return nil
          }
           
          if alpha == 1.0 {
              return String(
                  format: "#%02lX%02lX%02lX",
                  Int(red * multiplier),
                  Int(green * multiplier),
                  Int(blue * multiplier)
              )
          }
          else {
              return String(
                  format: "#%02lX%02lX%02lX%02lX",
                  Int(red * multiplier),
                  Int(green * multiplier),
                  Int(blue * multiplier),
                  Int(alpha * multiplier)
              )
          }
      }
 
}
