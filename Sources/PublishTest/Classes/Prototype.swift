



import Foundation
import Files


public class Prototype: Hashable, Identifiable  {
    
    public var folder: Folder
    public var name: Name
    
    
    // +Complexity
    var zScore: Double = 0.0
    var difficulty = 0.0
    
    // Lines Count
    var appLines: Int = 0
    var moduleLines: Int = 0
    var lines: Int = 0
    
    var status: Status = .nda
    var featured: Featured = .none
    
    var dynamicURL = ""
    var staticURL = ""
    
    var iconIndex = -1
    
    
    
    init(withFolder folder: Folder) {
        self.folder = folder
        self.name = Name(folder.name)
        
        // TODO
        self.countLines()
        
    }
    
    
    
    
    public static func == (lhs: Prototype, rhs: Prototype) -> Bool {
        return lhs.name.origin == rhs.name.origin
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name.origin)
    }
    
//    func setID(_ id: Int) { self.id = id }
    func setStatus(_ status:Status) { self.status = status }
    func setStaticURL(_ url:String) { self.staticURL = url }
    func setDynamicURL(_ url:String) { self.dynamicURL = url }
    func setIndex(_ index:Int) { self.iconIndex = index }
    
}



//enum RestrictionReason: Int, Codable {
//    case nda = 0
//    case api = 1
//}

enum Status: Int, Codable {
    case nda = 0
    case opened = 1
    case api = 2
}

enum Featured: Int, Codable {
    case none = 0
    case starred = 1
}


struct PrototypeConfig: Codable, Hashable, Comparable {
    
    var originName: String
    var url: String
    
    static func == (lhs: PrototypeConfig, rhs: PrototypeConfig) -> Bool {
        return lhs.originName == rhs.originName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(originName)
    }
    
    static func < (lhs: PrototypeConfig, rhs: PrototypeConfig) -> Bool {
        return lhs.originName < rhs.originName
    }
}




extension Prototype {
    static let app = "app.coffee"
    static let moduleFolder = "modules/"
}
