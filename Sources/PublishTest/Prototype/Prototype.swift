



import Foundation
import Files


// 00093 yandex [desktop] Force Update – Pulse 2

class Prototype: Hashable  {
    
    var folder: Folder
    var name: Name
    var id: Int = -1
    
    
    // +Complexity
    var zScore: Double = 0.0
    var difficulty = 0.0
    
    // Lines Count
    var appLines: Int = 0
    var moduleLines: Int = 0
    var lines: Int = 0
    
    
    init(withFolder folder: Folder) {
        self.folder = folder
        
        self.name = Name(folder.name)
        if self.name.parseFailed() { return }
        
        self.id = Prototype.getID()
        
        self.countLines()
        
    }
    
    
    
    
    static var staticID = -1
    
    static func getID() -> Int {
        Prototype.staticID += 1
        return Prototype.staticID
    }
    
    static func == (lhs: Prototype, rhs: Prototype) -> Bool {
        return lhs.name.origin == rhs.name.origin
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name.origin)
    }
    
}


extension Prototype {
    static let app = "app.coffee"
    static let moduleFolder = "modules/"
}
