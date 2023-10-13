//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 10.10.2023.
//

import Foundation
import Files





public struct tempJSONItem: Codable, Hashable {
    public var url: String
}


extension Queue {
    
    public mutating func tempUPDATE() {
        self.read()
        
        let openArray = tempSTARRED()
        
        self.prototypes.reversed().enumerated().forEach { (index, prototype) in
            if (openArray.array.contains(prototype.json.seed)) {
                prototype.json.star = true
            }
//            prototype.json.save(prototype)
            prototype.json.save(json: prototype.json, withName: "tilllur.json", toFolder: prototype.jsonFolder())
        }
        
        
    }
    
    public mutating func tempReadOldJSON() {
        self.read()

        self.prototypes.reversed().enumerated().forEach { (index, prototype) in
            prototype.readOldJSON()
        }
    }
}


public struct tempOPENED {
    public var array = ["atatxayn", "edcxtpos", "jcokqikq", "oddvdlom", "igyfxubo", "kltvxxth", "rfpcxniw", "lofhzwrm", "choiggok", "knrlhyzz", "urcpukgk", "lgxnzfcr", "smzmiosa", "lrtvmtct", "zsuwgzhv", "agnmfvrh", "vatnahkn", "jtpkupzm", "syfdetlr", "wjghltvw", "mqzvnzjh", "csfsvqwl", "qlxiqqhl", "mrjcajrf", "seivqdrl", "fqzeatpa", "vqstrhya", "mxpiuuog", "dqpvsned", "rsqgqecq", "tibogtmw", "pumjkira", "vjbqjtmx", "alpvlluv", "sldywdoy", "yitnhhef", "kihkqlqu", "fyfifcuj", "cwvoncoz", "aubtorbe", "wuznvdnm", "ycpigqxk", "rcmynuvn", "bcaybmzk", "lrewxqjc", "gpklunqb", "tynpwbag", "wecatypf", "sqdnyfnr", "rhxkkqax", "qopajkcb", "cqmbtkag", "idqnlffj", "kynqusjr", "rtegijbt", "wukoutws", "jbsrtsyu", "nzcizjkk", "rkmzfmgx", "onvllepd", "ixeecawh", "nuhtbdjs", "xczejcnk", "nuaespxz", "uyexxhca", "uwtrlafh", "idxeconb", "fjbyztcy", "elispbjj", "pailqgfm", "tbxldheo", "epjwpdhx", "ybdamjhy", "tpkwaagp", "mgtqirdu", "qcogfbcx", "nsmjpzin", "zrblhzsw", "ouectxza", "olvdomlc", "vxycucip", "tjbrdmue", "zpkxgpug", "cfqdniuy", "qgziquij", "dwpudzdc", "gpxpwpsv", "zsordctq", "aqbftybr", "alhnycjo", "cmztzvjk", "rifgejrl", "kmbjqhdj", "qqgaayxp", "jiecsufn", "vdvmozsy", "krpdlsyw", "uyrkjwyq", "cckhgsru", "usdsbrjp", "lkpionpn", "qodiowfp", "bezjysjp", "nsnniahl", "oeqopvzq", "kdfqqdpw", "lwkiqfwt", "rlzdqbiu", "dgfnobcs", "glbkjcwy", "fsmikgnd", "iaotbctt", "ceubadyp", "higjjiye", "apmdpunq", "cxbkowdt", "uohdbmjh", "dmaaxkag", "ekpcurgv", "qyaywrlu", "etvgxras", "prktfcqr", "agvyrahs", "blvjeixo", "lgvnjglh", "itqerwoa", "xumazifr", "wusvgdso", "hbkxaksi", "nhllvkun", "fayfhxvi", "vnhdujek", "oirkzjxa", "frnpqmag", "kmyfjfye", "qcabdswb", "plwpmbec", "imkygvax", "lfnmvzww", "gatbrhkc", "ucenadhy", "erkaosqg", "cgmwzuss", "kojelghh", "nsoudvjf", "dkhctbrd", "gbaalgpm", "zrvtzfkw", "bjpiiose", "jhwgwzzi", "ynaarwon", "qcztovow", "pbckrqro", "vxlbzgrw", "krpetqzi", "yewlfrvd", "kmwetcqb", "yoondkyu", "kktwdivu", "vfdwamfm", "lkgzlcrn", "gobdujcf", "lxdrpqzp", "unjaquhi", "xzlqlgme", "veaiklai", "ivwxzlwc", "awsihdqw", "hazpbvay", "wmhrckxs", "wsvmbhyl", "jytafuze", "kvtajtxy", "pfstxejc", "zbserirx", "jlgjymte", "jipocfxq", "hhujwpxy", "iqqrlzqr", "qibqwedv", "dbutejyd", "bksqnviy", "uamiwgym", "hquulryp", "ckairhxu", "rrrlhqnr", "pyclzygo", "wbccjiiv", "jtmlmyhy", "cytneyoz", "fwssazzp", "qjqeiwxs", "hwxneihc", "romtbdqx", "ihxchwkr", "pwvxtxda", "ktofcdqa", "ffhpotub", "npwstqdt", "fmyajjld", "mlesrjlm", "kdhhstak", "qzxerzgh", "kczhyqoy", "aulhxjpv", "qtiawwzx", "hwcsedlz", "rkquzqik", "fpynybbo", "yazadygw", "pqyqmdmp", "vchuezqr", "adjyonwo", "btsktvfm", "unmtpndx", "owqxefia", "chyiezpa", "eyweeust", "thunsach", "reqnheta", "gjbdxymk", "brugzind", "steenyhj", "mesqtmvj", "aihlpylr", "pbqgzedn", "zifqfruo", "qpiwpife", "haqycckg", "tpycijax", "zuhdcxuj", "ysromlxg", "ouydgyvp", "sdeuqqlh", "vwomiaos", "rfbqsfgt", "zepvukbh", "ekjangaf", "umhrawte", "botzanjy", "iscmkmzu", "ycnevwkc", "vfkglzhd", "nqhkidpg", "wtrzuews", "bsldkjkq", "otonvdzs", "sexguaxo", "qgpcgsev", "jckcokld", "pwfdapmc", "shuyydnp", "pqffzciy", "xkcgtvwe", "kvgrdqee", "padcujtb", "tlwbwlgs", "isxyeuth", "vtevrxgb", "ewgclwqq", "nrlospld", "bqxctwis", "jndwyonh", "yqunthfd", "zivpmill", "mrkvrjnv", "tyyqvnpy", "olqcbcis", "svytvfzi", "smyeelgz", "oyzeysrw", "lzfrtmmb", "waeutarb", "ngpwafeu", "vjuwnzae", "ikwsxeyw", "kbwhtdxw", "hfcdgjvb", "kmgmtdxh", "tzyjzwwp", "uergdwhv", "hfmcpvqc", "spmkiiol", "wgzghtiv", "xktpkllk", "dizeoyeu", "peaoyinc", "qhqbaqhj", "jkqqaqvn", "psrpdksw", "pkofseii", "cwdudtvy", "mtyhenye", "bqyvoeit", "rctdqjwn", "oazflfmt", "btvtlbpr", "lofxacjt", "jksirbns", "jgapbcsh", "zpfucoii", "plpcsmqs", "sicmywzv", "sxfmsbog", "xrcifwud", "luzfmzod", "lqrzmtvc", "tehgabuv", "aepopykf", "etmlwgzw", "mxziktfq", "mrkvqept", "hzoeyojj", "zaxgghbw", "qaluqjko", "ujxzwmfd", "ktkdudkg", "vyvdpntf", "cifuoqvu", "mxrcnywa", "aliipymd", "druqvihn", "nsqdlygi", "ajuraozo"]
}

public struct tempSTARRED {
    public var array = ["rfpcxniw", "urcpukgk", "smzmiosa", "lrtvmtct", "wjghltvw", "mrjcajrf", "rsqgqecq", "tibogtmw", "vjbqjtmx", "alpvlluv", "sldywdoy", "yitnhhef", "cwvoncoz", "wuznvdnm", "bcaybmzk", "sqdnyfnr", "qopajkcb", "cqmbtkag", "rtegijbt", "nuhtbdjs", "uyexxhca", "pailqgfm", "ybdamjhy", "mgtqirdu", "nsmjpzin", "ouectxza", "vxycucip", "tjbrdmue", "qgziquij", "dwpudzdc", "zsordctq", "krpdlsyw", "uyrkjwyq", "fsmikgnd", "cxbkowdt", "etvgxras", "frnpqmag", "ucenadhy", "erkaosqg", "dkhctbrd", "gbaalgpm", "yewlfrvd", "yoondkyu", "kktwdivu", "awsihdqw", "wsvmbhyl", "kvtajtxy", "jlgjymte", "hquulryp", "jtmlmyhy", "thunsach", "aihlpylr", "ekjangaf", "sexguaxo", "padcujtb", "jndwyonh", "pkofseii", "sicmywzv"]
}

extension Prototype {
    
    
    public func readOldJSON() {
        
        do {

            let seedFolder = try Folder(path: folder.path)
            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
            
            let file = try Folder(path: folder.path + "tilllur/").file(at: "static.json")
            let decoder = JSONDecoder()

            do {
                let temp = try decoder.decode(tempJSONItem.self, from: file.readData())
                if (temp.url != "") { self.json.url = temp.url }
 
            } catch { print("Failed to decode JSON State") }
            
            self.json.save(json: self.json, withName: "tilllur.json", toFolder: self.jsonFolder())
//            self.json.save(self)

        }
        catch { print(error) }
    }
}
