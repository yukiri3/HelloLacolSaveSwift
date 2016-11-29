//
//  TableViewController.swift
//  HelloLocalSaveSwift
//
//  Created by user on 2016/11/29.
//  Copyright © 2016年 HelloSwift. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
let userDefaults = UserDefaults.standard //userDefaults
let array = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/HelloMyPlist.plist")//plist
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            switch indexPath.row {
            case 0:
                //userDefaults
                cell.textLabel?.text = userDefaults.string(forKey:"key")
                
                break
            case 1:
                //plist
                let plistStr=array?[0]
                cell.textLabel?.text = plistStr as! String?
                break
                
            case 2:
                
                
               
            break
            case 3:
                
                
                break
            default:
                break;
            
    }
      return cell
    
  
}
}
