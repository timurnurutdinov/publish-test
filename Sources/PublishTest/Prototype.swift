



import Foundation
import Files


// 00093 yandex [desktop] Force Update – Pulse 2

struct Prototype {
    var folder: Folder
    var creation: String = ""
    var lines: Int = -1
    
    static var app = "app.coffee"
    
    
    
    init(withFolder folder: Folder) {
        self.folder = folder
        self.creation = test()
        
        if folder.containsFile(named: Prototype.app) {
            do {
                let appURL = URL(string: Prototype.app, relativeTo: self.folder.url)
//                let appCode = try String(contentsOf: appURL!, encoding: .utf8)
//                print(appCode.split(separator: "\n", omittingEmptySubsequences: false).count)
                let str = try Data(contentsOf: appURL!).withUnsafeBytes { String(decoding: $0, as: UTF8.self) }
                self.lines = str.utf8.split(separator: UInt8(ascii: "\n"), omittingEmptySubsequences: false).count
            }
            catch {/* error handling here */}
        }
    }
    
    func test() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "HH:mm E, d MMM y"
        return formatter4.string(from: self.folder.creationDate!)
    }
    
    static func writeCSV(ofPrototypes prototypes:[String], withName name:String = "test.txt") {
        do {
            let folder = try Folder(path: "~/Desktop/output/")
            let file = try folder.createFile(named: name)
            try file.write(prototypes.joined(separator: ":"))
            
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
