//
//  ViewController.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/13/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var execTimer: ExecTimer!
  var tvWorker =  TVWorker()
  
  let cellSupport = CellSupport(number: 70)
  
  @IBOutlet weak var tableView0: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    delegates()
    execTimer = ExecTimer(execForTimer: tvWorker, view: self)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    execTimer.startTimer()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    execTimer.stopTimer()
  }
  
  func delegates() {
    tableView0.delegate = self
    tableView0.dataSource = self
  }
  
}

extension ViewController: UITableViewDelegate,
UITableViewDataSource, ExecInView {
  
  func viewExec() {
    //print("\n ** HERE **\n")
    
    DispatchQueue.main.async { [unowned self] in
      
      if self.execTimer.count != self.tableView0.numberOfRows(inSection: 0) {
        self.tableView0.reloadData()
      } else {
        for i in 0..<self.execTimer.count {
          let indexPath = IndexPath(row: i, section: 0)
          self.tableView0.reloadRows(at: [indexPath], with: .left)
        }
      }
      
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return execTimer.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView == tableView0 {

      if let cell = tableView.dequeueReusableCell(withIdentifier: "cell0") {
        
        cellSupport.setCellBounds(bounds: cell.bounds)
        cellSupport.setViewBounds(bounds: view.bounds)
        
         if let records = execTimer.records {
          var lateString = " ✅"
          
          let trainno = records.tv[indexPath.row].trainno
          let late = records.tv[indexPath.row].late
          if late != 0 {
            lateString = "\(late)"
          }
          if late >= 6 {
            lateString = "❌ \(late)"
          }
          let line = records.tv[indexPath.row].line
          let next = records.tv[indexPath.row].nextstop
          
          let data = "\(trainno):\t \(lateString)\t \(line)\t -->\(next)\nhere"
           DispatchQueue.main.async { [unowned self] in
            cell.addSubview(self.cellSupport.fill(row: indexPath.row, text: data))
          }
          
        }
        
        return cell
      }
    }
    return tableView.dequeueReusableCell(withIdentifier: "cell0")!
  }
  
}
