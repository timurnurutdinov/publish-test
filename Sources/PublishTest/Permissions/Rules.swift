//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/27/22.
//

import Foundation

extension Queue {
    
    mutating func setDynamicRules() {
        self.restrict(byName: "2016-01-18 [ios] Beeline Music – Onboarding.framer", tillEnd: true)
    }
    
    func setFeatured() {
        self.feature(byName: "2015-10-01 [ios] 10tracks – Onboarding Swipes.framer")
        self.feature(byName: "2015-03-23 [ios] Adme – Pull to Refresh 1.framer")
        self.feature(byName: "2015-03-24 [ios] Adme – Pull to Refresh 2.framer")
        self.feature(byName: "2015-05-04 [ios] Social Parse – Edit.framer")
        
    }
    
    func setStaticRules() {
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
