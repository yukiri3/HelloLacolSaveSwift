//
//  CoreDataManager.swift
//  HelloLocalSaveSwift
//
//  Created by user on 2016/11/30.
//  Copyright © 2016年 HelloSwift. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager: NSObject {
    

    
/*----------------------------------------------------------------------------------------*/
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
/*---------------------------------------儲存數據------------------------------------------*/
    
    func saveData(name:String){
        let context = getContext()
      
        //定義一個entity 與 ____.xcdatamodeld裡的同名稱
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let obj = NSManagedObject(entity: entity!, insertInto: context)
        obj.setValue(name, forKey: "name")
        do {
            try context.save()
        }catch{
            print(error)
        }
    }
    
    
/*-------------------------------獲取entity中的所有資料-----------------------------------------*/
    //回傳陣列
    func getData() -> Array<String>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        var array:Array<String> = []
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                //將資料加入陣列
               array.append(p.value(forKey: "name")! as! String)
            }
        } catch  {
            print(error)
        }
       return array
    }
    
/*----------------------------刪除CoreData所有的資料-----------------------------------------*/    

    func clearAllData(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        do {
            let dele = try getContext().fetch(fetchRequest)
            for p in (dele as! [NSManagedObject]){
                //將資料全部刪除
                getContext().delete(p)
            }
        } catch  {
            print(error)
        }
    
}
}
