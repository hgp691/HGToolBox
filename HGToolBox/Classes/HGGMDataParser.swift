//
//  HGGMDataParser.swift
//  Alamofire
//
//  Created by Alexander Ortiz on 6/09/17.
//

import UIKit
import SwiftyJSON

public class HGGMDataParser: NSObject {
    
    
    public func retornaNombreCiudad(obj:JSON)->String{
        let data = retornaObjetoConId(arreglo: obj[0]["address_components"], cadena: "administrative_area_level_2")
        if data != JSON.null{
            return data["long_name"].stringValue
        }else{
            let data1 = self.retornaObjetoConId(arreglo: obj[0]["address_components"], cadena: "administrative_area_level_1")
            if data1 != JSON.null{
                return data1["long_name"].stringValue
            }else{
                return "NO SE ENCONTRO"
            }
        }
    }
    
    public func retornaCodigoPais(obj:JSON)->String{
        let aaa = self.retornaObjetoConId(arreglo: obj[0]["address_components"], cadena: "country")
        if aaa != JSON.null {
            return aaa["short_name"].stringValue
        }else{
            return "NO SE ENCONTRO"
        }
    }
    
    public func retornaNombrePais(obj:JSON)->String{
        let aaa = self.retornaObjetoConId(arreglo: obj[0]["address_components"], cadena: "country")
        if aaa != JSON.null {
            return aaa["long_name"].stringValue
        }else{
            return "NO SE ENCONTRO"
        }
    }
    
    public func retornaDireccionCompleta(obj:JSON)->String{
        if self.existeTypeEnArregloGeneral(obj: obj, cadena: "street_address") {
            let data = self.retornaObjetoConId(arreglo: obj, cadena: "street_address")
            return data["formatted_address"].stringValue
        }else if self.existeTypeEnArregloGeneral(obj: obj, cadena: "route"){
            let data = self.retornaObjetoConId(arreglo: obj, cadena: "route")
            return data["formatted_address"].stringValue
        }else{
            return "NO SE ENCONTRO"
        }
    }
    
    
    
    private func retornaObjetoConId(arreglo:JSON,cadena:String)->JSON{
        if arreglo != JSON.null && arreglo.count > 0{
            for i in 0...arreglo.count-1{
                if self.existeTypes(obj: arreglo[i]["types"], cadena: cadena){
                    return arreglo[i]
                }
            }
        }
        return JSON.null
    }
    
    private func existeTypeEnArregloGeneral(obj:JSON,cadena:String)->Bool{
        if obj != JSON.null && obj.count > 0{
            for i in 0...obj.count-1{
                if self.existeTypes(obj: obj[i]["types"], cadena: cadena){
                    return true
                }
            }
        }
        return false
    }
    
    private func existeTypes(obj:JSON,cadena:String)->Bool{
        if obj != JSON.null && obj.count > 0{
            for i in 0...obj.count-1{
                if obj[i].stringValue == cadena{
                    return true
                }
            }
        }
        return false
    }
}
