//
//  File.swift
//  
//
//  Created by tilllur on 24.03.2022.
//

import Foundation

class Timestamp {
    
    init() {        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        let timestamp = dateFormatter.string(from: Date())
        timestamp.writeFile("time.txt", toFolder: OutputFolder.path)
    }
}
