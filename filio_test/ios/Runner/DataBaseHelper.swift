import Foundation
import SQLite

class DatabaseHelper {
  static let shared = DatabaseHelper()
  private let dbPath: String = "counter.db"

  private func getDB() -> Database? {
    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let path = URL(fileURLWithPath: documentsDirectory).appendingPathComponent(dbPath)
    do {
      let db = try Database(path: path.path)
      return db
    } catch {
      print("Error opening database: \(error.localizedDescription)")
      return nil
    }
  }

  func createTable() {
    guard let db = getDB() else { return }
    let sql = """
      CREATE TABLE IF NOT EXISTS counter (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        count INTEGER NOT NULL DEFAULT 0
      )
    """
    do {
      try db.run(sql)
    } catch {
      print("Error creating table: \(error.localizedDescription)")
    }
  }

  func incrementCounter() {
    guard let db = getDB() else { return }
    createTable() // Ensure table exists
    var count = 0
    do {
      let statement = try db.prepare("SELECT count FROM counter")
      if let row = try statement.next() {
        count = Int(row[named: "count"] as! Int64)
      }
    } catch {
      print("Error fetching count: \(error.localizedDescription)")
    }
    count += 1
    do {
      try db.run("UPDATE counter SET count = ?", count)
    } catch {
      print("Error updating count: \(error.localizedDescription)")
    }
  }
}
