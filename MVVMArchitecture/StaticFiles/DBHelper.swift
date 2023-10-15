//
//  DBHelper.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import Foundation
import SQLite3

class DBHelper
{
    static let shared:DBHelper = DBHelper()
    init()
    {
        db = openDatabase()
    }
    
    let dbPath: String = "db.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            return nil
        }
        else
        {
            return db
        }
    }
    
    func readTutorialList() -> [TutorialsList]{
        let queryStatementString = "select * from table"
        var queryStatement: OpaquePointer? = nil
        var tutorialList: [TutorialsList] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let subid = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                tutorialList.append(TutorialsList(id: Int(id), title: name, sub_id: subid))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return tutorialList
    }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM table WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
