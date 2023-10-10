



import Foundation
import Files

public class Prototype: Hashable, Identifiable  {
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
    
    public var status: Status = .nda
    public var featured: Featured = .none
    
//    var dynamicURL = ""
//    var staticURL = ""
    
    public var dynamicSeed: Seed = Seed(url: "")
    public var staticSeed: Seed = Seed(url: "")
    
    var iconIndex = -1
    
    init(withFolder folder: Folder) {
        self.id = Prototype.nextID
        Prototype.nextID = Prototype.nextID + 1
        
        
        self.folder = folder
        self.name = Name(folder.name)
        
        self.readURLDynamic()
        self.readURLStatic()
        
//        self.readTag()
//        if (self.staticSeed.url != "") { print("Public ——> \(self.name.origin)") }
        
//        self.getPermissionByTag() // TODO
//        self.updateTags()  // TODO
        
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
//    func setStatus(_ status:Status) { self.status = status }
//    func setStaticURL(_ url:String) { self.staticSeed.url = url }
//    func setDynamicURL(_ url:String) { self.dynamicSeed.url = url }
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
