//
//  BgViewFactory.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 11/28/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class BgViewFactory {
  
  var bgContainer0: [UIView] = []
  var bgContainer1: [UIView] = []
  var bgM: [UIView] = []
  
  var labelContainer0: [UILabel] = []
  var labelContainer1: [UILabel] = []
  
  var number = 0
  
  init(number: Int) {
    
    self.number = number
    for _ in 0...number {
      let  bgView0: UIView = UIView(frame: CGRect(x: 2, y: 0, width: 200, height: 200))
      let  bgView1: UIView = UIView(frame: CGRect(x: 2, y: 0, width: 200, height: 200))
      let  bgViewM: UIView = UIView(frame: CGRect(x: 2, y: 0, width: 200, height: 200))
      
      let label0 = UILabel(frame: CGRect(x: 0, y: 10, width: 200, height: 15))
      let label1 = UILabel(frame: CGRect(x: 0, y: 10, width: 200, height: 15))
      
      bgView0.addSubview(label0)
      bgViewM.addSubview(label1)
      bgView1.addSubview(bgViewM)
      
      bgContainer0.append(bgView0)
      bgContainer1.append(bgView1)
      bgM.append(bgViewM)
      
      labelContainer0.append(label0)
      labelContainer1.append(label1)
      
    }
    
  }
  
}
