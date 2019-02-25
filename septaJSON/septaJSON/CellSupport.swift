//
//  CellSupport.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 2/24/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import Foundation
import UIKit

// Ref: https://www.raywenderlich.com/8549-self-sizing-table-view-cells
// https://www.raywenderlich.com/1752-unit-testing-tutorial-mocking-objects
class CellSupport {
  var bgVF: BgViewFactory
  var cellBounds: CGRect!
  var viewBounds: CGRect!
  var tvWorker: TVWorker!
  
  init(number: Int) {
    bgVF = BgViewFactory(number: number)
  }
  
  func setCellBounds(bounds: CGRect) {
    self.cellBounds = bounds
  }
  
  func setViewBounds(bounds: CGRect) {
    self.viewBounds = bounds
  }
  
  func fill(
    row: Int, text: String) -> UIView {
    
    bgVF.bgContainer0[row].frame = CGRect(x: 2, y: 0, width: cellBounds.width - 4, height: (cellBounds.height)-2)
    
    bgVF.bgContainer0[row].backgroundColor = UIColor(red: 0.9,
                                                     green: 0.9,
                                                     blue: 0.9,
                                                     alpha: 1)

    bgVF.bgContainer0[row].layer.borderWidth = 3
    bgVF.bgContainer0[row].alpha = 1
    bgVF.bgContainer0[row].layer.cornerRadius = 9
    bgVF.bgContainer0[row].tag = 100
    
    // For Animation
    bgVF.bgContainer0[row].center.x -=  viewBounds.width
    
    bgVF.labelContainer0[row].frame = CGRect(x: 15,
                                             y: 1,
                                             width: 365,
                                             height: 45)
    
    bgVF.labelContainer0[row].textAlignment = NSTextAlignment.left
    bgVF.labelContainer0[row].lineBreakMode = .byWordWrapping
    bgVF.labelContainer0[row].numberOfLines = 2

    bgVF.labelContainer0[row].textColor = UIColor.black
    bgVF.labelContainer0[row].backgroundColor = UIColor(red: 0.9,
                                                        green: 0.9,
                                                        blue: 0.9,
                                                        alpha: 1)
    
    //bgVF.labelContainer0[row].alpha = 1
    bgVF.labelContainer0[row].text = text
    bgVF.labelContainer0[row].font  = UIFont(name: "Avenir", size: 12.0)
    
    // For Animation
    UIView.animate(withDuration: 0.5) {
      self.bgVF.bgContainer0[row].center.x += self.viewBounds.width
    }
    
    return bgVF.bgContainer0[row]
    
  }
  
  open func exec() {
    
  }
}
