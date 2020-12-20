



import Foundation
import Files


// 00093 yandex [desktop] Force Update – Pulse 2

struct Prototype {
    var folder: Folder
    var creation: String = ""
    var lines: Int = -1
    
    struct FramerPath {
        var app = "app.coffee"
    }
    
    
    
    init(withFolder folder: Folder) {
        self.folder = folder
        self.creation = test()
        
    }
    
    func test() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "HH:mm E, d MMM y"
        return formatter4.string(from: self.folder.creationDate!)
    }
    
    
}

