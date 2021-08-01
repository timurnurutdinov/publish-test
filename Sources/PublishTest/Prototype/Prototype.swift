



import Foundation
import Files


// 00093 yandex [desktop] Force Update – Pulse 2

class Prototype: Hashable  {
    
    static var prototypes: [Prototype] = []
    
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
        
        Prototype.prototypes.append(self)
        
        
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
    
    static let queue = "~/Documents/testing-queue/"
//    static let queue = "~/Documents/Git/Prototyping-Queue/"
    
    static let outputFolderName = "output"
    static let outputPrototypesFolderName = "show"
    static let outputFolderPath = "~/Desktop/output/"
    
    static let app = "app.coffee"
    static let modules = "modules/"
    
}

