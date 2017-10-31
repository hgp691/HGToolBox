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
    
    public init() {
        self.usr = ""
        self.pw = ""
    }
    
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
    
    public func colorRandom()->UIColor{
        return UIColor(red: CGFloat(arc4random()) / CGFloat(UInt32.max), green: CGFloat(arc4random()) / CGFloat(UInt32.max), blue: CGFloat(arc4random()) / CGFloat(UInt32.max), alpha: 1.0)
    }
    
    public func precioAString(precio:Int,moneda:String,undmiles:String,undmillones:String)->String{
        var cadena = "\(moneda)"
        if precio < 1000 {
            cadena += self.obtenerUnidades(precio: precio)
            return cadena
        }else if precio >= 1000 && precio < 1000000{
            cadena += self.obtenerMiles(precio: precio)
            cadena += undmiles
            cadena += self.obtenerUnidades(precio: precio)
            return cadena
        }else{
            cadena += self.obtenerMillones(precio: precio)
            cadena += undmillones
            cadena += self.obtenerMiles(precio: precio)
            cadena += undmiles
            cadena += self.obtenerUnidades(precio: precio)
            return cadena
        }
    }
    
    private func obtenerUnidades(precio:Int)->String{
        let unidades = precio % 1000
        if unidades < 10{
            return "00\(unidades)"
        }else if unidades >= 10 && unidades < 100{
            return "0\(unidades)"
        }else{
            return "\(unidades)"
        }
    }
    private func obtenerMiles(precio:Int)->String{
        if precio >= 1000000{
            let mill = precio / 1000000
            let prec = precio - (mill * 1000000)
            let miles = prec / 1000
            print("los miles de \(precio): \(miles)")
            if miles < 10{
                return "00\(miles)"
            }else if miles >= 10 && miles < 100{
                return "0\(miles)"
            }else{
                return "\(miles)"
            }
        }else if precio >= 1000 && precio < 1000000{
            let miles = precio / 1000
            print("los miles de \(precio): \(miles)")
            if miles < 10{
                return "00\(miles)"
            }else if miles >= 10 && miles < 100{
                return "0\(miles)"
            }else{
                return "\(miles)"
            }
        }else{
            return ""
        }
    }
    private func obtenerMillones(precio:Int)->String{
        if precio >= 1000000{
            let mill = precio / 1000000
            return "\(mill)"
        }else{
            return ""
        }
    }
    
}
