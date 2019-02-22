//
//  ViewController.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/13/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let stuff = ["one", "two", "three"]
  
  let cellSupport = CellSupport(number: 30)
  
  @IBOutlet weak var tableView0: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegates()
  }
  
  func delegates() {
    tableView0.delegate = self
    tableView0.dataSource = self
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if tableView == tableView0 {
      
      return stuff.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView == tableView0 {
      
      if let cell = tableView.dequeueReusableCell(withIdentifier: "cell0") {
        
        cellSupport.setCellBounds(bounds: cell.bounds)
        cellSupport.setViewBounds(bounds: view.bounds)
        
        cell.addSubview(cellSupport.fill(row: indexPath.row))
        
        return cell
      }
    }
      return tableView.dequeueReusableCell(withIdentifier: "cell0")!
    }
  
}
