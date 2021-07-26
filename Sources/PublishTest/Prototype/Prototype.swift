



import Foundation
import Files


// 00093 yandex [desktop] Force Update – Pulse 2

class Prototype: Hashable  {
    
    var folder: Folder
    var name: Name
    
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
        
        self.countLines()
        
        Prototype.prototypes.append(self)
    }
    
    
    static func == (lhs: Prototype, rhs: Prototype) -> Bool {
        return lhs.name.origin == rhs.name.origin
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name.origin)
    }
    
}



extension Prototype {
    
    static var prototypes: [Prototype] = []
    
//    static let queue = "~/Documents/testing-queue/"
    static let queue = "~/Documents/Git/Prototyping-Queue/"
    
    static let outputFolderName = "output"
    static let outputFolderPath = "~/Desktop/output/"
    
    static let app = "app.coffee"
    static let modules = "modules/"
    
}

