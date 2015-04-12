//
//  ViewController.swift
//  SQLTest
//
//  Created by Leon Zhang on 15/3/29.
//  Copyright (c) 2015年 Leon Zhang. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dbinit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dbinit() {
        
//        db.totalChanges // 2
//        db.lastChanges  // {Some 1}
//        db.lastID       // {Some 2}
//        
//        for row in db.prepare("SELECT id, email FROM users") {
//            println(row)
//            // [Optional(1), Optional("betsy@example.com")]
//            // [Optional(2), Optional("alice@example.com")]
//        }
    }

    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!

    @IBAction func test(sender: AnyObject) {
        let db = Database("path/to/db.sqlite3")
        
        db.execute(
            "CREATE TABLE users (" +
                "id INTEGER PRIMARY KEY, " +
                "email TEXT NOT NULL UNIQUE, " +
                "manager_id INTEGER, " +
                "FOREIGN KEY(manager_id) REFERENCES users(id)" +
            ")"
        )
        
        //
        let stmt = db.prepare("INSERT INTO users (email) VALUES (?)")
        for email in ["alice@example.com", "betsy@example.com"] {
            stmt.run(emailLabel.text)
        }

    }
}

