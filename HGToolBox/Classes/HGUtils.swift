//
//  HGUtils.swift
//  Pods
//
//  Created by Alexander Ortiz on 18/08/17.
//
//

import Foundation


public struct HGUtils {
    
    let usr:String
    let pw:String
    
    public static let isSpanish: Bool = {
        let pre = Locale.preferredLanguages[0]
        let idioma=pre.components(separatedBy: "-")
        ////print(idioma[0])
        if idioma[0] == "es" {
            return true
        }else{
            return false
        }
    }()
    
    public static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
    
    /*
    public mutating func basicAuth(usr:String,pw:String)->String{
        let first=usr+":"+pw
        let plainData=first.data(using: String.Encoding.utf8)
        let base64=plainData?.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
        let head:String="Basic "+String(data: base64!, encoding: String.Encoding.utf8)!
        return String(head)
    }
 */
    
}
