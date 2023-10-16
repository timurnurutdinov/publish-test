



import Foundation
import Files

public class Prototype: Hashable, Identifiable  {
    public typealias DataType = Prototype?
    
    public static var nextID: Int = 0
    
    public var id: Int
    public var folder: Folder
    public var name: Name
    
    // +Complexity
    var zScore: Double = 0.0
    var difficulty = 0.0
    
    // Lines Count
    var appLines: Int = 0
    var moduleLines: Int = 0
    var lines: Int = 0
    
    public var json: PrototypeJSON = PrototypeJSON(seed: "", url: "", open: false, star: false)
    
    var iconIndex = -1
    
    init(withFolder folder: Folder) {
        self.id = Prototype.nextID
        Prototype.nextID = Prototype.nextID + 1
        
        self.folder = folder
        self.name = Name(folder.name)
        
        self.json = PrototypeJSON(jsonFile: self.jsonFile())
        
        // TODO
        self.countLines()
        
    }
    
    public static func == (lhs: Prototype, rhs: Prototype) -> Bool { return lhs.name.origin == rhs.name.origin }
    public func hash(into hasher: inout Hasher) { hasher.combine(name.origin) }
    func setIndex(_ index:Int) { self.iconIndex = index }
    
}



public enum Status: String, Codable {
    case nda = "closed"
    case opened = "open"
    case api = "api"
}

public enum Featured: String, Codable, Hashable {
    case none = "false"
    case starred = "true"
}




public struct PrototypeConfig: Codable, Hashable, Comparable {
    
    public var originName: String
    public var url: String
    
    public static func == (lhs: PrototypeConfig, rhs: PrototypeConfig) -> Bool {
        return lhs.originName == rhs.originName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(originName)
    }
    
    public static func < (lhs: PrototypeConfig, rhs: PrototypeConfig) -> Bool {
        return lhs.originName < rhs.originName
    }
}




extension Prototype {
    static let app = "app.coffee"
    static let moduleFolder = "modules/"
}


extension Prototype {
    public func updateURL(to url: String) { self.json.url = url }
}
