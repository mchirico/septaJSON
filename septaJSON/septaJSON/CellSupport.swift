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
            row: Int) -> UIView {
    
    bgVF.bgContainer0[row].frame = CGRect(x: 2, y: 0, width: cellBounds.width - 4, height: (cellBounds.height)-2)
    
    bgVF.bgContainer0[row].backgroundColor = UIColor.gray
    bgVF.bgContainer0[row].layer.borderWidth = 3
    bgVF.bgContainer0[row].alpha = 1
    bgVF.bgContainer0[row].layer.cornerRadius = 9
    bgVF.bgContainer0[row].tag = 100
    
    bgVF.bgContainer0[row].center.x -=  viewBounds.width
    
    bgVF.labelContainer0[row].frame = CGRect(x: 35,
                                                       y: 12,
                                                       width: 297,
                                                       height: 15)
    
    bgVF.labelContainer0[row].textAlignment = NSTextAlignment.left
    
    bgVF.labelContainer0[row].textColor = UIColor.black
    bgVF.labelContainer0[row].backgroundColor = UIColor.clear
    bgVF.labelContainer0[row].alpha = 10
    
    bgVF.labelContainer0[row].text = "stuff"
    
    UIView.animate(withDuration: 0.5) {
      self.bgVF.bgContainer0[row].center.x += self.viewBounds.width
    }
    
    return bgVF.bgContainer0[row]

  }
  
  open func exec() {
    
  }
}
