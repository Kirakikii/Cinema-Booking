//
//  DataBase.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/13/24.
//

import SQLite3

class DatabaseManager {
    var db: OpaquePointer?

    init() {
        openDatabase()
    }

    func openDatabase() {
        let fileUrl = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false).appendingPathComponent("bookings.sqlite")

        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
    }

    func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS bookings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filmName TEXT,
        cinema TEXT,
        date TEXT,
        time TEXT,
        seat TEXT);
        """

        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Bookings table created.")
            } else {
                print("Bookings table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    // Example to insert data
    func insertBooking(detail: BookingDetailModel) {
        let insertStatementString = "INSERT INTO bookings (filmName, cinema, date, time, seat) VALUES (?, ?, ?, ?, ?);"

        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (detail.filmName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (detail.cinema as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (detail.date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (detail.time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (detail.seat as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
}
