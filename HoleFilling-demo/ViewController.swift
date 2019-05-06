//
//  ViewController.swift
//  HoleFilling-demo
//
//  Created by 磯崎裕太 on 2019/05/06.
//  Copyright © 2019 HoleFillingCo.,Ltd. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    enum TableType:Int {
        case テーブル席 = 1, カウンター席, 個室, お座敷, ソファー席 = 5
    }
    
    enum Status:Int {
        case 空席 = 1, 在席, 会計中, 会計済み = 4
    }
    
    struct Table {
        var id:Int
        var member:Int
        var type:TableType
        var status:Status
    }
    
    let Tables = [
        Table(id: 2, member: 2, type: TableType.カウンター席, status: Status.空席),
        Table(id: 4, member: 2, type: TableType.カウンター席, status: Status.空席),
        Table(id: 8, member: 2, type: TableType.カウンター席, status: Status.空席),
        Table(id: 10, member: 2, type: TableType.カウンター席, status: Status.空席),
        Table(id: 11, member: 8, type: TableType.テーブル席, status: Status.空席),
        Table(id: 12, member: 4, type: TableType.テーブル席, status: Status.空席),
        Table(id: 13, member: 4, type: TableType.テーブル席, status: Status.空席),
        Table(id: 14, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 15, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 16, member: 4, type: TableType.個室, status: Status.空席),
        Table(id: 17, member: 4, type: TableType.個室, status: Status.空席),
        Table(id: 21, member: 2, type: TableType.個室, status: Status.空席),
        Table(id: 22, member: 2, type: TableType.個室, status: Status.空席),
        Table(id: 22, member: 2, type: TableType.個室, status: Status.空席),
        Table(id: 23, member: 2, type: TableType.個室, status: Status.空席),
        Table(id: 24, member: 2, type: TableType.個室, status: Status.空席),
        Table(id: 25, member: 2, type: TableType.個室, status: Status.空席),
        Table(id: 26, member: 6, type: TableType.個室, status: Status.空席),
        Table(id: 31, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 32, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 33, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 34, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 41, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 42, member: 4, type: TableType.お座敷, status: Status.空席),
        Table(id: 43, member: 4, type: TableType.お座敷, status: Status.空席),
        Table(id: 44, member: 6, type: TableType.お座敷, status: Status.空席),
        Table(id: 45, member: 4, type: TableType.お座敷, status: Status.空席),
        Table(id: 46, member: 4, type: TableType.お座敷, status: Status.空席)
    ]
    


    @IBOutlet var tableCollection: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        var gestures = Array<UITapGestureRecognizer>()
        for _ in 0..<tableCollection.count {
            let tapgesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture(_:)))
            gestures.append(tapgesture)
        }

        for (index, table) in tableCollection.enumerated() {
            table.addGestureRecognizer(gestures[index])
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        let tableNo = sender.view?.restorationIdentifier
        print(tableNo ?? "error")
    }

    

}

