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
    
    public init(endPoint:String,metodo:HTTPMethod,parametrosParaEnviar:[String:String]!,configuration:[String:Any],viewParaTamanoCargador:UIView,viewParaPoner:UIView,debug:Bool){
        super.init()
        
        let animationConfs = configuration["lottieAnimation"] as! [String:Any]
       
        let progress = HGLottieProgress(view: viewParaPoner, configuration: animationConfs, autoplay: true)
        if self.delegate != nil{
            self.delegate.HGCargadorInicioCarga(cargador: self)
        }
        
        let headers = self.basicAuth(appUSR: configuration["API_USER"] as! String, appPWD: configuration["API_PW"] as! String)
        
        
        let url = "\(configuration["dominio"] as! String)\(endPoint)"
        
        
        Alamofire.request(url, method: metodo, parameters: parametrosParaEnviar, encoding: URLEncoding.default, headers: headers).responseJSON { (respuesta) in
            
            progress.removeFromSuperview()
            
            switch respuesta.result{
            case .success(let data):
                self.procesarDatos(json: JSON(data), debug: debug)
                break
            case .failure(let error):
                if debug{
                    print("Error string serivicio: \(error.localizedDescription)")
                }
                if self.delegate != nil{
                    let alerta = UIAlertController(title: "Error conexión",
                                                   message: error.localizedDescription,
                                                   preferredStyle: .alert);
                    self.delegate.HGCargadorTerminoCargaConError(cargador: self, error: alerta)
                }
                break
            }
        
        }.responseString { (respuesta) in
                if debug{
                    print("Respuesta string servicio: \(respuesta)")
                }
                
        }
        
    }
    
    private func procesarDatos(json:JSON,debug:Bool){
        if debug {
            print(json)
        }
        if json["error"] == JSON.null{
            if self.delegate != nil{
                self.delegate.HGCargadorTerminoCarga(cargador: self, respuesta: json)
            }
        }else{
            if self.delegate != nil{
                let alerta = UIAlertController(title: "Error",
                                               message: json["errorMessage"].stringValue,
                                               preferredStyle: .alert)
                self.delegate.HGCargadorTerminoCargaConError(cargador: self, error: alerta)
            }
        }
    }
    
    private func basicAuth(appUSR:String,appPWD:String)->[String:String]{
        let first=appUSR+":"+appPWD
        let plainData=first.data(using: String.Encoding.utf8)
        let base64=plainData?.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
        let head:String="Basic "+String(data: base64!, encoding: String.Encoding.utf8)!
        let headers = [
            "Authorization": head
        ]
        return headers
    }
    
}
