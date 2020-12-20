



import Foundation


// 00093 yandex [desktop] Force Update – Pulse 2
struct ParsePrototype {
    private var name = ""
    private var lineCount = 0
    
    private var indexName: String = "-1"
    private var companyName = "none"
    private var projectName = "none"
    private var prototypeName = "none"

    init(name: String = .init()) {
        self.name = name
        parseName()
        printName()
    }
    
    func printName() {
        if self.isCorrect() {
            print(self.prototypeName)
        }
        else { print("Error with \(self.name)") }
    }
    
    func isCorrect() -> Bool {
        return self.indexName != "-1"
    }
    
    private mutating func parseName() {
        let wsArray = self.name.components(separatedBy: " ")
        if wsArray.count <= 3 { return }
        
        self.indexName = wsArray[0]
        self.companyName = wsArray[1]
        self.prototypeName = wsArray[2].replacingOccurrences(of: "[", with: "")
                                       .replacingOccurrences(of: "]", with: "")
        
        let nameParts = wsArray[3...]
        print(nameParts)
        self.prototypeName = nameParts.reduce("") { text, part in " \(part)" }
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
