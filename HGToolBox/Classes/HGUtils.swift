//
//  HGUtils.swift
//  Pods
//
//  Created by Alexander Ortiz on 18/08/17.
//
//

import Foundation


public struct HGUtils {
    
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
    
}
