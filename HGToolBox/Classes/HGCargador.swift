//
//  HGCargador.swift
//  Pods
//
//  Created by Alexander Ortiz on 18/08/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON

public protocol HGCargadorDelegate{
    func HGCargadorInicioCarga(cargador:HGCargador)
    func HGCargadorTerminoCarga(cargador:HGCargador,respuesta:JSON)
    func HGCargadorTerminoCargaConError(cargador:HGCargador,error:UIAlertController)
}

public class HGCargador: NSObject {
    
    public var delegate:HGCargadorDelegate!
    
    public var tag:Int!
    
    init(endPoint:String,metodo:HTTPMethod,parametrosParaEnviar:[String:String]!,parametrosServidor:[String:String],viewParaTamanoCargador:UIView,viewParaPoner:UIView,debug:Bool){
        super.init()
        
    }
    
}
