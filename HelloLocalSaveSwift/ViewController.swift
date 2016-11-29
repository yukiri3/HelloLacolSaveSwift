//
//  ViewController.swift
//  HelloLocalSaveSwift
//
//  Created by user on 2016/11/29.
//  Copyright © 2016年 HelloSwift. All rights reserved.
//

/*
    iOS中local儲存資料的幾種方式
    未完
 
 */
import UIKit

class ViewController: UIViewController {
    let userDefaults = UserDefaults.standard //創立一個UserDefaults 註：為單例物件
    
    
    @IBOutlet var userDefaultsText: UITextField!
    @IBOutlet var sqliteText: UITextField!
    @IBOutlet var plistText: UITextField!
    @IBOutlet var coreDataText: UITextField!
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //送出按鈕
    @IBAction func submit(_ sender: UIButton) {
        
        
        /*NSUserDefaults 用來儲存輕量級資料
         譬如app設定...等等
         其底層為plist
         */
        if (userDefaultsText.text != nil){
            //value - key
            userDefaults.set(userDefaultsText.text, forKey:"key")
            //同步
            userDefaults.synchronize()
        }
        
        /*Plist 
        儲存目錄：Documents
        可儲存NSDictionary、NSArray、Boolean、NSData、NSDate、NSNumber、NSString
        其類型就是XML
         */
        if(plistText.text != nil){
            let plistStr = plistText.text
            let array = NSArray(objects:plistStr!)
            let filePath:String = NSHomeDirectory() + "/Documents/HelloMyPlist.plist"
            array.write(toFile: filePath, atomically: true)
            

        }
        
        
        //Sqlite
        if(sqliteText.text != nil){
            
            
            
        }

        //coreData
        if(coreDataText.text != nil){
            
            
           
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

}

