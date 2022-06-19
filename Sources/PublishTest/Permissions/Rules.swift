//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/27/22.
//

import Foundation

extension Queue {
    
    mutating func setDynamicRules() {
//        self.restrict(byName: "2017-02-21 [abro] Password Manager – Generate Password 2.framer", tillEnd: true)
        
//        self.restrict(byName: "2016-12-08 [ibro] Browser 2017 – Flow 5 TODOTODOTODO.framer")
//        self.restrict(byName: "2016-12-07 [ibro] Browser 2017 – Flow 4 TODOTODOTODO.framer")
//        self.restrict(byName: "2016-12-04 [ibro] Browser 2017 – Flow 3 TODOTODOTODO.framer")
//        self.restrict(byName: "2016-12-03 [ibro] Browser 2017 – Flow 2 TODOTODOTODO.framer")
//        self.restrict(byName: "2016-11-30 [ibro] Browser 2017 – Flow 1 TODOTODOTODO.framer")
        
//        self.allow(byName: "2021-12-01 [pp] Fullscreen – Flow.framer", tillName: "2022-02-18 [pp] Fullscreen – Video 3.framer")
//        self.allow(byName: "2021-04-22 [pp] Yandex 2021 – Tooltips Playground.framer", tillName: "2021-07-20 [pp] Yandex 2021 – Inc for Plus.framer")
        
        
//        self.allow(byName: "2021-12-22 [pp] Fullscreen – Video 1.framer")
//        self.allow(byName: "2021-12-22 [pp] Fullscreen – Video 2.framer")
//        self.allow(byName: "2022-02-18 [pp] Fullscreen – Video 3.framer")
//        self.allow(byName: "2022-02-18 [pp] Fullscreen – Flow 2.framer")
//        self.allow(byName: "2022-01-10 [pp] Fullscreen – Resize.framer")
        
        
        
        
    }
    
    func setFeatured() {
        // 2022-03-31 [bro] Groups — Flow
        
        self.feature(byName: "2017-02-18 [abro] Browser 2017 – New Tab 9.framer")
        self.feature(byName: "2017-02-15 [abro] Browser 2017 – New Tab 7.framer")
        self.feature(byName: "2017-02-07 [abro] Onboarding 2017 – Flow 8.framer")
        self.feature(byName: "2016-11-19 [ibro] Browser 2017 – New Tab 6.framer")
        self.feature(byName: "2016-11-13 [ibro] Browser 2017 – Bottom View 5.framer")
        self.feature(byName: "2016-10-27 [ios] Dino – Game 3.framer")
        self.feature(byName: "2016-09-28 [android] Yamblz Team – Flow 3.framer")
        self.feature(byName: "2016-09-12 [android] Yamblz Team – Flow 1.framer")
        self.feature(byName: "2016-08-16 [android] Yamblz Start – Unlock Album 3.framer")
        self.feature(byName: "2016-01-18 [ios] Beeline Music – Onboarding.framer")
        self.feature(byName: "2015-10-01 [ios] 10tracks – Onboarding Swipes.framer")
    }
    
    func setStaticRules() {
//        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer", withURL: "size")
        self.allow(byName: "2022-02-08 [pp] Yandex 2022 – Flow.framer", withURL: "yandex-2022")
        self.allow(byName: "2022-03-31 [bro] Groups — Flow.framer", withURL: "bro-groups")
        self.allow(byName: "2022-04-20 [pp] Yandex Search 2022 — Flow 2.framer", withURL: "search-input")
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



