//
//  SqlLiteViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 2/11/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit
import SQLite3

class SqlLiteViewController: UIViewController {
    var db: OpaquePointer?


    @IBOutlet weak var txtNom: UITextField!
    @IBOutlet weak var txtPasw: UITextField!
    @IBOutlet weak var PickFecha: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectSqlLite()
        

        // Do any additional setup after loading the view.
    }
    func ConnectSqlLite(){
        let filerUrl = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TestG.sqlite")
        
        if sqlite3_open(filerUrl.path, &db) != SQLITE_OK{
            print("ERR")
            return
        }
        
        let query = "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, cedula TEXT, fecha DATE, password, TEXT)"
        
        if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK{
            print("ERR")
            return
        }
        
        print("ALL")
        
        
    }
    
    @IBAction func buttonSave(_ sender: Any) {
        let nom = txtNom.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let pasw = txtPasw.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cedula = "12222"
        let fecha = PickFecha.date
        
        print("NOMBRE", nom ,"CEDULA", cedula,"FECHA", pasw)
        
        var stmt: OpaquePointer?
        let insquer = "INSERT INTO Test (nombre,cedula,fecha,password) VALUES (?,?,?,?)"
        
        if sqlite3_prepare(db, insquer, -1 , &stmt, nil) != SQLITE_OK{
            print("ERROR Binding")
        }
        
        if sqlite3_bind_text(stmt, 1, nom, -1,nil) != SQLITE_OK{
            print("ER Name")
        }
        if sqlite3_bind_text(stmt, 2, cedula, -1,nil) != SQLITE_OK{
            print("ER Cedula")
        }
        if sqlite3_bind_double(stmt, 3, fecha.timeIntervalSinceReferenceDate) != SQLITE_OK{
            print("ER fech")
        }
        if sqlite3_bind_text(stmt, 4, pasw, -1,nil) != SQLITE_OK{
            print("ER pasw")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            print("Done", stmt)
        }
    }
    
    
    @IBAction func ReadData(_ sender: Any) {
    
        allDATA()
    }
    
    func allDATA(){
        let queryStatementString = "SELECT * FROM Test;"

        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db,queryStatementString,-1,&queryStatement,nil) == SQLITE_OK {
            print("\n")
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                let id = sqlite3_column_int(queryStatement, 0)
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
                    print("Query result is nil.")
                    return
                }
                let name = String(cString: queryResultCol1)
                guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
                    print("Query result is nil.")
                    return
                }
                let cedula = String(cString: queryResultCol2)
            
                guard let queryResultCol3 = sqlite3_column_text(queryStatement, 3) else {
                    print("Query result is nil.")
                    return
                }
                let pass = String(cString: queryResultCol3)
                

                print("Query Result:")
                print("\(id) | \(name)| \(cedula)| \(pass)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
    

    }
    
    func UnData(){
        
        let queryStatementString = "SELECT * FROM Test;"
        var queryStatement: OpaquePointer?
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // 3
                let id = sqlite3_column_int(queryStatement, 0)
                // 4
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 2) else {
                    print("Query result is nil")
                    return
                }
                let name = String(cString: queryResultCol1)
                // 5
                print("\nQuery Result:")
                print("\(id) | \(name)")
            } else {
                print("\nQuery returned no results.")
            }
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
    }
    
    func isStringOnlyNumbers(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    func isStringOnlyLetters(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrsuvwxyzABCDEFGHIJKLMNOPQRSTVUWXYZ").inverted) == nil
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
