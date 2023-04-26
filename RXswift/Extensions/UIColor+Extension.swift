//
//  UIColor+Extension.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import UIKit


extension UIColor {
   
   static func rgb(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
      return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
   }

   static let darkBackground =  rgb(red: 25, green: 23, blue: 32)
   static let darkTextFeild = rgb(red: 30, green: 28, blue: 36)

   static let btnWhite = rgb(red: 255, green: 255, blue: 255)
}
