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
let plistArray = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/HelloMyPlist.plist")//plist
var dataM: [(id: String, name: String)] = [] //SQLite
var coreDataArray:Array<String> = CoreDataManager().getData() //CoreData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sqliteContext = SQLiteManager()
        sqliteContext.createdsqlite3();
        dataM = sqliteContext.readData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        //回傳四種section
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            //SQLite
        return dataM.count-1
        }
        else if section == 3{
            //CoreData
            return coreDataArray.count
        }
        else{
            //userDefaults
            //plist
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    switch indexPath.section {
        case 0:
            //userDefaults
            cell.textLabel?.text = userDefaults.string(forKey:"key")
            break
        case 1:
            //plist
            let plistStr=plistArray?[0]
            cell.textLabel?.text = plistStr as! String?
            break
        case 2:
            //sqlite
            let dict = dataM[indexPath.row+1]
            //取得資料表中的name
            cell.textLabel?.text = dict.name
            //取得資料表中的id (主鍵)
            cell.detailTextLabel?.text = dict.id
            break
        case 3:
            //coreData
            //將CoreData中資料給cell Label
            cell.textLabel?.text = coreDataArray[indexPath.row]
            
            cell.detailTextLabel?.text = "\(indexPath.row+1)"
        break
        default:
            break
            }
           
            
      return cell
    
  
}
    //這方法回傳Header高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0;
    }
    
    //設定section title
    override func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        var title=""
        
        if section == 0 {
            title = "NSUserDefaults"
        }
        else if section == 1{
            title = "Plist"
        }
        else if section == 2{
            title = "SQLite"
        }
        else if section == 3{
            title = "CoreData"
        }
        
        return title
    }
}
