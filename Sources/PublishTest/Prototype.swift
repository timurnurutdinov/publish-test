



import Foundation
import Files


// 00093 yandex [desktop] Force Update – Pulse 2

class Prototype {
    var folder: Folder
    var name: Name
    
    var lines: Int = -1
    var moduleLines: Int = -1
    
    var zScore: Double = 0.0
    var difficulty = 0.0
    
    static var app = "app.coffee"
    static var modules = "modules/"
    var appCreation: Date = Date()
    
    
    
    init(withFolder folder: Folder) {
        self.folder = folder
        self.name = Name(folder.name)
        
        if !self.name.isValid() { print("🛑: Invalid name"); return }
        
//        let appFile = try? File(path: self.folder.path + Prototype.app)
//        if let tempDate = appFile?.creationDate { self.appCreation = tempDate }
//        else { print("🛑 Folder without app.coffee file: \(self.folder)"); return }
        
        if folder.containsFile(named: Prototype.app) {
            do {
                let appURL = URL(string: Prototype.app, relativeTo: self.folder.url)
                let str = try Data(contentsOf: appURL!).withUnsafeBytes { String(decoding: $0, as: UTF8.self) }
                self.lines = str.utf8.split(separator: UInt8(ascii: "\n"), omittingEmptySubsequences: false).count
                
//                print(self.lines)
                if self.lines < 10 { print("\(self.getID())") }
                
                
                let modulesURL = folder.path + Prototype.modules
                try Folder(path: modulesURL).files.enumerated().forEach { (index, folder) in
                    if (folder.name == "myModule.coffee") { print("-") }
                    else { print(folder.name) }
                }
                
//                if let modulesURL = URL(string: Prototype.modules, relativeTo: self.folder.url) {
//                    try Folder(path: modulesURL.absoluteString).files.enumerated().forEach { (index, folder) in
//                        print(folder.name)
//                    }
//                }
                
            }
            catch { print("🛑 Failed to count lines in app.coffee") }
        }
    }
    
    
    func getLowestDates() -> [Date] {
//        if self.folder.creationDate! < self.appCreation { return [self.folder.creationDate!, self.appCreation] }
        return [self.folder.creationDate!]
    }
    
    func getLowestDateString() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "yyyy-MM-dd"
        let dates = self.getLowestDates()
        return "\(self.getID()): \(formatter4.string(from: dates[0]))"
    }
    
    
    
    func getDate() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "HH:mm E, d MMM y"
        return formatter4.string(from: self.folder.creationDate!)
    }
    
    func getDateCompact() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "d MMM y"
        return formatter4.string(from: self.folder.creationDate!)
    }
    
    func setZScore(withAverage average:Double, andVariation variation: Double) {
        self.zScore = (Double(self.lines) - average) / variation
        self.difficulty = min(Double(self.lines) / (average * 2.0), 1.0)
        
//        if self.zScore < -2 || self.zScore > 2 { print("L: \(self.lines) \(self.getID())") }
//        if self.difficulty < 0.03 { print("Check: \(self.getID())") }
    }
    
    func getID() -> String {
        return String(self.folder.name.split(separator: " ").first!)
    }
    
    
    
    // MOVE
    static func writeCSV(ofPrototypes prototypes:[String], withName name:String = "test.txt", separatedBy separator:String = ",") {
        do {
            let folder = try Folder(path: "~/Desktop/output/")
            let file = try folder.createFile(named: name)
            try file.write(prototypes.joined(separator: separator))
            
        }
        catch { }
    }
}



extension Optional {
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            throw errorExpression()
        }
    }
}
