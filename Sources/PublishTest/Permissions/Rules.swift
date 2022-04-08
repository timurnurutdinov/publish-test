//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/27/22.
//

import Foundation

extension Queue {
    
    mutating func closeForProduction() {
        self.restrict(byName: "2016-01-18 [ios] Beeline Music – Onboarding.framer", tillEnd: true)
    }
    
    func openForProduction() {
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer", withURL: "size")
        self.allow(byName: "2022-02-08 [pp] Yandex 2022 – Flow.framer", withURL: "yandex-2022")
        self.allow(byName: "2022-03-31 [bro] Groups — Flow.framer", withURL: "bro-groups")
    }
}



extension PresentQueue {
    func openForProduction() {
        self.allow(byName: "2022-03-19 [presentation] Navigation View — Demo.framer", withURL: "navigation-view")
    }
}
