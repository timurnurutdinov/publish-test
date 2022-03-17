//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/27/22.
//

import Foundation

extension Queue {
    
    mutating func closeForProduction() {
        self.restrict(byName: "2015-02-20 [ios] Trailsee – Sync.framer", tillEnd: true)
    }
    
    func openForProduction() {
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer", withURL: "size")
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer", withURL: "size-copy")
        self.allow(byName: "2022-02-08 [pp] Yandex 2022 – Flow.framer", withURL: "yandex-2022")
    }
}
