//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/27/22.
//

import Foundation

extension Queue {
    
    mutating func setDynamicRules() {
        self.restrict(byName: "2016-10-04 [ios] Dino – Start Buttons.framer", tillEnd: true)
//        self.allow(byName: "2021-12-01 [pp] Fullscreen – Flow.framer")
    }
    
    func setFeatured() {
        self.feature(byName: "2016-09-28 [android] yamblz team – Flow 3.framer")
        self.feature(byName: "2016-09-12 [android] yamblz team – Flow 1.framer")
        self.feature(byName: "2016-01-18 [ios] Beeline Music – Onboarding.framer")
        self.feature(byName: "2015-10-01 [ios] 10tracks – Onboarding Swipes.framer")
    }
    
    func setStaticRules() {
//        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer", withURL: "size")
        self.allow(byName: "2022-02-08 [pp] Yandex 2022 – Flow.framer", withURL: "yandex-2022")
        self.allow(byName: "2022-03-31 [bro] Groups — Flow.framer", withURL: "bro-groups")
    }
}



extension PresentQueue {
    func openForProduction() {
        self.allow(byName: "2022-03-19 [presentation] Navigation View — Demo.framer", withURL: "navigation-view")
    }
}




//2016-09-22 [android] yamblz team – Onboarding.framer
//2016-08-16 [android] yamblz start – Unlock Album 3.framer
//2016-08-15 [android] yamblz start – Album Stats 3.framer
//2016-04-04 [ios] Twiage – Unlock Phone.framer



