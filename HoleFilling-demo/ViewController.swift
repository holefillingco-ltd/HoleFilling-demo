//
//  ViewController.swift
//  HoleFilling-demo
//
//  Created by 磯崎裕太 on 2019/05/06.
//  Copyright © 2019 HoleFillingCo.,Ltd. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    class Table {
        var id:Int
        var member:Int
        var type:TableType
        var status:Status
        
        init(id:Int, member:Int, type:TableType, status:Status) {
            self.id = id
            self.member = member
            self.type = type
            self.status = status
        }
        
        enum TableType:String {
            case table = "テーブル席", counter = "カウンター席", privateRoom = "個室", zasiki = "お座敷", sofa = "ソファー席"
        }
        enum Status:String {
            case vacan = "空席", fill = "在席中", accounting = "会計中", check = "会計済み"
        }

    }
    
    var Tables = [
        Table(id: 2, member: 2, type: Table.TableType.counter, status: Table.Status.vacan),
        Table(id: 4, member: 2, type: Table.TableType.counter, status: Table.Status.vacan),
        Table(id: 8, member: 2, type: Table.TableType.counter, status: Table.Status.vacan),
        Table(id: 10, member: 2, type: Table.TableType.counter, status: Table.Status.vacan),
        Table(id: 11, member: 8, type: Table.TableType.table, status: Table.Status.vacan),
        Table(id: 12, member: 4, type: Table.TableType.table, status: Table.Status.vacan),
        Table(id: 13, member: 4, type: Table.TableType.table, status: Table.Status.vacan),
        Table(id: 14, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 15, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 16, member: 4, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 17, member: 4, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 21, member: 2, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 22, member: 2, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 22, member: 2, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 23, member: 2, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 24, member: 2, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 25, member: 2, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 26, member: 6, type: Table.TableType.privateRoom, status: Table.Status.vacan),
        Table(id: 31, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 32, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 33, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 34, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 41, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 42, member: 4, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 43, member: 4, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 44, member: 6, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 45, member: 4, type: Table.TableType.zasiki, status: Table.Status.vacan),
        Table(id: 46, member: 4, type: Table.TableType.zasiki, status: Table.Status.vacan)
    ]
    

    @IBOutlet var tableCollection: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 各View(table)へtapGestureの付与
        var gestures = Array<UITapGestureRecognizer>()
        for _ in 0..<tableCollection.count {
            let tapgesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture(_:)))
            gestures.append(tapgesture)
        }
        for (index, table) in tableCollection.enumerated() {
            table.addGestureRecognizer(gestures[index])
        }
        
        self.createTextFromString(aString: "テスト", saveToDocumentsWithFileName: "TableLog.text")
    }
    
    func changeTableStatus(_ changeTable:Table, _ status:Table.Status, _ tableView:UIView, _ tableNoStr:String) {
        changeTable.status = status
        if let tableNo = Int(tableNoStr) {
            let tables = Tables.filter{$0.id == tableNo}
            let table = tables.first!
            switch table.status {
            case .vacan:
                tableView.backgroundColor = UIColor.lightGray
            case .fill:
                tableView.backgroundColor = UIColor.green
            case .accounting:
                tableView.backgroundColor = UIColor.orange
            case .check:
                tableView.backgroundColor = UIColor.red
            }
        }
    }

    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        let tableNo:String = sender.view?.restorationIdentifier ?? "error"
        if let str = Int(tableNo) {
            let tables = Tables.filter{$0.id == str}
            let table = tables.first!
            let tableMember = String(table.member)
            let tableType = table.type.rawValue
            let tableInfo = tableMember + "名 : " + tableType
            
            let alert = UIAlertController(title: tableInfo, message: table.status.rawValue, preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "空席", style: .default, handler: {(action) -> Void in self.changeTableStatus(table, ViewController.Table.Status.vacan, sender.view!, sender.view?.restorationIdentifier ?? "error")})
            )
            alert.addAction(
                UIAlertAction(title: "在席中", style: .default, handler: {(action) -> Void in
                    self.changeTableStatus(table, ViewController.Table.Status.fill, sender.view!, sender.view?.restorationIdentifier ?? "error")})
            )
            alert.addAction(
                UIAlertAction(title: "会計中", style: .default, handler: {(action) -> Void in self.changeTableStatus(table, ViewController.Table.Status.accounting, sender.view!, sender.view?.restorationIdentifier ?? "error")})
            )
            alert.addAction(
                UIAlertAction(title: "会計済み", style: .destructive, handler: {(action) -> Void in self.changeTableStatus(table, ViewController.Table.Status.check, sender.view!, sender.view?.restorationIdentifier ?? "error")})
            )
            alert.addAction(
                UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            )
            self.present(alert, animated: true)
        } else {
            return
        }
    }
    
    func createTextFromString(aString: String, saveToDocumentsWithFileName fileName: String) {
        
        if let documentDirectoryFileURL = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last {
            
            let targetTextFilePath = documentDirectoryFileURL + "/" + fileName
            
            do {
                try aString.write(toFile: targetTextFilePath, atomically: true, encoding: String.Encoding.utf8)
                print(targetTextFilePath)
            } catch let error as NSError {
                print("failed to write: \(error)")
            }
        }
    }
    

}

