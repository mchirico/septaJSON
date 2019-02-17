//
//  ViewTimes.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/14/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class ViewTimes: UIViewController {
  
  @IBOutlet weak var tableView0: UITableView!
  
  @IBOutlet weak var tableView1: UITableView!
  
  @IBOutlet weak var label0: UILabel!
  
  let travel = Travel()
  
  var timer: Timer!
  
  let bgVF = BgViewFactory(number: 30)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    delegates()
    startTimer()
    refreshData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    stopTimer()
  }
  
  func delegates() {
    tableView0.delegate = self
    tableView1.delegate = self
    
    tableView0.dataSource = self
    tableView1.dataSource = self
  }
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    timer.fire()
  }
  
  func stopTimer() {
    if timer != nil {
      timer.invalidate()
    }
    timer = nil
  }
  
  @objc func refreshData() {
    
    travel.refresh()
    
    //  Ref: https://ru-clip.net/video/whbyVPFFh4M/contacts-animations-reload-rows-in-uitableview-ep-2.html
    //  Ref: https://www.hackingwithswift.com/articles/80/how-to-find-and-fix-memory-leaks-using-instruments
    
    if travel.count(index: 0) != tableView0.numberOfRows(inSection: 0) ||
      travel.count(index: 1) != tableView1.numberOfRows(inSection: 0) {
      tableView0.reloadData()
      tableView1.reloadData()
      return
      
    }
    
    for i in 0..<travel.count(index: 0) {
      let indexPath = IndexPath(row: i, section: 0)
      tableView0.reloadRows(at: [indexPath], with: .left)
    }
    
    for i in 0..<travel.count(index: 1) {
      let indexPath = IndexPath(row: i, section: 0)
      tableView1.reloadRows(at: [indexPath], with: .bottom)
    }
    
    // tableView0.reloadData()
    // tableView1.reloadData()
    
    label0.text = "\(travel.getMinutes()) \t \(travel.nextStations())"
    
  }
  
}

extension ViewTimes: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if tableView == tableView0 {
      return travel.count(index: 0)
    }
    
    if tableView == tableView1 {
      return travel.count(index: 1)
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView == tableView0 {
      
      if let cell = tableView.dequeueReusableCell(withIdentifier: "cell0") {
        
        bgVF.bgContainer0[indexPath.row].frame = CGRect(x: 2, y: 0, width: cell.bounds.width - 4, height: (cell.bounds.height)-2)
        
        bgVF.bgContainer0[indexPath.row].backgroundColor = UIColor.gray
        bgVF.bgContainer0[indexPath.row].layer.borderWidth = 3
        bgVF.bgContainer0[indexPath.row].alpha = 1
        bgVF.bgContainer0[indexPath.row].layer.cornerRadius = 9
        bgVF.bgContainer0[indexPath.row].tag = 100
        
        bgVF.bgContainer0[indexPath.row].center.x -=  view.bounds.width
        
        bgVF.labelContainer0[indexPath.row].frame = CGRect(x: 35,
                                                           y: 12,
                                                           width: 297,
                                                           height: 15)
        
        //label.center = CGPointMake(160, 284)
        bgVF.labelContainer0[indexPath.row].textAlignment = NSTextAlignment.left
        
        bgVF.labelContainer0[indexPath.row].textColor = UIColor.black
        bgVF.labelContainer0[indexPath.row].backgroundColor = UIColor.clear
        bgVF.labelContainer0[indexPath.row].alpha = 10
        
        bgVF.labelContainer0[indexPath.row].text = travel.msg(index: 0, row: indexPath.row)
        
        if  indexPath.row == 0 {
          switch travel.getMinutes()[0] {
          case let x where x < 10 && x >= 8:
            bgVF.bgContainer0[indexPath.row].backgroundColor = UIColor.blue
          case let x where x < 8 && x >= 6:
            bgVF.bgContainer0[indexPath.row].backgroundColor = UIColor.green
          case let x where x < 6 && x >= 5:
            bgVF.bgContainer0[indexPath.row].backgroundColor = UIColor.yellow
          case let x where x < 5:
            bgVF.bgContainer0[indexPath.row].backgroundColor = UIColor.red
          default:
            bgVF.bgContainer0[indexPath.row].backgroundColor = UIColor.lightGray
          }
        } else {
          bgVF.bgContainer0[indexPath.row].backgroundColor = UIColor.lightGray
        }
        
        //label.text = "title: \(indexPath.row)"
        bgVF.labelContainer0[indexPath.row].tag = 101
        bgVF.labelContainer0[indexPath.row].font  = UIFont(name: "Avenir", size: 17.0)
        
        cell.addSubview(bgVF.bgContainer0[indexPath.row])
        
        UIView.animate(withDuration: 0.5) {
          self.bgVF.bgContainer0[indexPath.row].center.x += self.view.bounds.width
        }
        return cell
      }
      
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
    
    bgVF.bgContainer1[indexPath.row].frame = CGRect(x: 15, y: 0, width: cell!.bounds.width - 20, height: 40)
    
    bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.green
    bgVF.bgContainer1[indexPath.row].layer.borderWidth = 1
    bgVF.bgContainer1[indexPath.row].alpha = 1
    bgVF.bgContainer1[indexPath.row].layer.cornerRadius = 9
    
    bgVF.bgContainer1[indexPath.row].tag = 100
    
    bgVF.bgContainer1[indexPath.row].center.x -=  view.bounds.width
    
    bgVF.bgM[indexPath.row].frame = CGRect(x: 12, y: 3.7, width: 305, height: 31)
    bgVF.bgM[indexPath.row].backgroundColor = UIColor.white
    bgVF.bgM[indexPath.row].layer.borderWidth = 1
    bgVF.bgM[indexPath.row].alpha = 1
    bgVF.bgM[indexPath.row].layer.cornerRadius = 9
    bgVF.bgM[indexPath.row].tag = 300
    
    bgVF.labelContainer1[indexPath.row].frame = CGRect(x: 10,
                                                       y: 10,
                                                       width: 288,
                                                       height: 15)
    bgVF.labelContainer1[indexPath.row].textAlignment = NSTextAlignment.left
    
    bgVF.labelContainer1[indexPath.row].textColor = UIColor.black
    bgVF.labelContainer1[indexPath.row].backgroundColor = UIColor.clear
    bgVF.labelContainer1[indexPath.row].alpha = 10
    
//    bgVF.labelContainer1[indexPath.row].text = travel.msg(index: 1,row: indexPath.row)
//
     bgVF.labelContainer1[indexPath.row].text = travel.msgTrack(index: 1, row: indexPath.row, nextstop: "Suburban Station")
    
    if  indexPath.row == 0 {
      switch travel.getMinutes()[1] {
      case let x where x <= 12 && x > 10:
        bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.magenta
      case let x where x <= 10 && x > 8:
        bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.blue
      case let x where x <= 8 && x >= 6:
        bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.green
      case let x where x < 6 && x >= 5:
        bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.yellow
      case let x where x < 5:
        bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.red
      default:
        bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.lightGray
      }
    } else {
      bgVF.bgContainer1[indexPath.row].backgroundColor = UIColor.lightGray
    }
    
    bgVF.labelContainer1[indexPath.row].tag = 102
    bgVF.labelContainer1[indexPath.row].font  = UIFont(name: "Avenir", size: 14.0)
    
    UIView.animate(withDuration: 0.5) {
      self.bgVF.bgContainer1[indexPath.row].center.x += self.view.bounds.width
    }
    
    cell!.addSubview(bgVF.bgContainer1[indexPath.row])
    
    return cell!
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if tableView.dequeueReusableCell(withIdentifier: "cell1") != nil {
        print("here: \(indexPath.row)")
      
      jump(row: indexPath.row)
      
    }

  }
  
  func jump(row: Int) {
    
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomID0") as? ViewCtrFromSelect
    
    vc?.row = row
    if let train = travel.sts[1].records?.sts[row].orig_train {
      vc?.data = train
    }
    self.navigationController?.pushViewController(vc!, animated: true)

  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.destination is ViewCtrFromSelect {
      let vc = segue.destination as? ViewCtrFromSelect
      
      vc?.mainViewController = self
    }
  }
  
}
