//
//  ViewController.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/13/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let r = Request()
    let url = "https://www3.septa.org/hackathon/Arrivals/Elkins%20Park"
    r.getURL(url: url)
    // print("\(r.contents)")
  }


}

