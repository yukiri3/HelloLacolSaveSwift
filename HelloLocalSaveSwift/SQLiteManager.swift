//
//  SQLiteManager.swift
//  HelloLocalSaveSwift
//
//  Created by user on 2016/11/30.
//  Copyright © 2016年 HelloSwift. All rights reserved.
//

import UIKit
import SQLite
class SQLiteManager: NSObject {
    
        private var db: Connection!
        private let users = Table("users") //Table name
        private let id = Expression<Int64>("id")      //主鍵
        private let name = Expression<String>("name")  //列表1
/*-----------------------------------創建資料庫-------------------------------------------------*/
         func createdsqlite3(filePath: String = "/Documents")  {
            
            let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
            do {
                db = try Connection(sqlFilePath)
                try db.run(users.create { t in
                    t.column(id, primaryKey: true)
                    t.column(name)
                })
            } catch { print(error) }
        }
/*-----------------------------------插入資料--------------------------------------------------*/
        func insertData(_name: String){
            do {
                let insert = users.insert(name <- _name)
                try db.run(insert)
            } catch {
                print(error)
            }
        }
/*-------------------------------------讀取資料-----------------------------------------------*/
        func readData() -> [(id: String, name: String)] {
            var userData = (id: "", name: "")
            var userDataArr = [userData]
            for user in try! db.prepare(users) {
                userData.id = String(user[id])
                userData.name = user[name]
                userDataArr.append(userData)
            }
            return userDataArr
        }
/*------------------------------------更新數據-------------------------------------------------*/
    
        func updateData(userId: Int64, old_name: String, new_name: String) {
            let currUser = users.filter(id == userId)
            do {
                try db.run(currUser.update(name <- name.replace(old_name, with: new_name)))
            } catch {
                print(error)
            }
        }
/*-------------------------------------刪除數據------------------------------------------------*/
    
        func delData(userId: Int64) {
            let currUser = users.filter(id == userId)
            do {
                try db.run(currUser.delete())
            } catch {
                print(error)
            }
        }
}

