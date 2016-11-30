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
import SQLite
import UIKit
/*----------------------------------------------------------------------------------------*/
class ViewController: UIViewController,UITextFieldDelegate {
    let userDefaults = UserDefaults.standard //創立一個UserDefaults 註：為單例物件
    let sqliteContext = SQLiteManager()
    let coreDataContext = CoreDataManager()
    @IBOutlet var userDefaultsText: UITextField!
    @IBOutlet var sqliteText: UITextField!
    @IBOutlet var plistText: UITextField!
    @IBOutlet var coreDataText: UITextField!
/*----------------------------------------------------------------------------------------*/
    override func viewDidLoad() {
         super.viewDidLoad()
        //設定return鍵
        userDefaultsText.returnKeyType = UIReturnKeyType.send
        plistText.returnKeyType = UIReturnKeyType.send
        sqliteText.returnKeyType = UIReturnKeyType.send
        coreDataText.returnKeyType = UIReturnKeyType.send
       
        //設定textField delegate
        userDefaultsText.delegate = self
        plistText.delegate = self
        sqliteText.delegate = self
        coreDataText.delegate = self
        
        sqliteContext.createdsqlite3()
    }
/*----------------------------------------------------------------------------------------*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
/*----------------------------------------------------------------------------------------*/
    //清除按鈕 - CoreData
@IBAction func clearCoreData(_ sender: UIBarButtonItem) {
    //coreData刪除資料
    self.coreDataContext.clearAllData();
    }
   //清除按鈕 - SQLite
@IBAction func clearLocalData(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: "您確定要刪除資料嗎？",
            message: "輸入你要刪除的ID欄位",
            preferredStyle: .alert)
        // 建立輸入框
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "SQLite"
            textField.keyboardType = UIKeyboardType.numberPad
        }
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelAction)
        // 建立確定按鈕
        let okAction = UIAlertAction(
            title: "確定",
            style: .default) {
                (action: UIAlertAction!) -> Void in
                let sqliteDel = (alertController.textFields?.first)?.text
                //假如字串不為空 輸入框資料
                if (!(sqliteDel?.isEqual(""))!){
                    self.sqliteContext.delData(userId:Int64(sqliteDel!)!)
                }
    }
        alertController.addAction(okAction)
        // 顯示提示框
        self.present(alertController, animated: true, completion: nil)
    }
/*----------------------------------------------------------------------------------------*/
    //送出按鈕
@IBAction func submit(_ sender: UIButton) {
        
/*----------------------------------------------------------------------------------------*/
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
/*----------------------------------------------------------------------------------------*/
    
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
/*----------------------------------------------------------------------------------------*/
        //Sqlite
        if(sqliteText.text != nil){
           
            let str:String = sqliteText.text!
            //插入數據
            sqliteContext.insertData(_name:str)
        }
/*----------------------------------------------------------------------------------------*/
        //coreData
        //底層依然是SQLite
        if(coreDataText.text != nil){
            let coreDataStr = String(coreDataText.text!)
            coreDataContext.saveData(name: coreDataStr!)
        }        
    }

    
/*----------------------------------------------------------------------------------------*/
    //當按下Return時 收起鍵盤
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        return true;
    }
    
}





