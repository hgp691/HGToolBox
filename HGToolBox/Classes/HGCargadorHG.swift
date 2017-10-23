//
//  HGCargadorHG.swift
//  Alamofire
//
//  Created by Alexander Ortiz on 19/10/17.
//

import UIKit
import SwiftyJSON

public protocol HGCargadorHGDelegate{
    func HGCargadorHGInicioCarga(cargador:HGCargadorHG)
    func HGCargadorHGTerminoCarga(cargador:HGCargadorHG,respuesta:JSON)
    func HGCargadorHGTerminoCargaConError(cargador:HGCargadorHG,error:UIAlertController)
}

public class HGCargadorHG: NSObject {
    public var delegate:HGCargadorHGDelegate!
    public var tag:Int!
    
    public init(endPoint:String,metodo:HGHttpMethod,parametrosParaEnviar:[String:String]!,configuration:[String:Any],viewParaCargador:UIView!,debug:Bool){
        super.init()
        
        var progress:HGLottieProgress!
        
        if viewParaCargador != nil{
            let animationConfs = configuration["lottieAnimation"] as! [String:Any]
            progress = HGLottieProgress(view: viewParaCargador, configuration: animationConfs, autoplay: true)
            viewParaCargador.addSubview(progress)
        }
        
        if self.delegate != nil{
            self.delegate.HGCargadorHGInicioCarga(cargador: self)
        }
        
        let url = URL(string: configuration["dominio"] as! String + endPoint)!
        
        if debug{
            print("EMPEZO SERVICIO: \(configuration["dominio"] as! String + endPoint) ==================================================")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = metodo.metodo()
        
        request.setValue(self.AuthorizationHeader(usr: configuration["API_USER"] as! String, pw: configuration["API_PW"] as! String), forHTTPHeaderField: "Authorization")
        
        if parametrosParaEnviar != nil && metodo != .get{
            //let jsonData = try? JSONSerialization.data(withJSONObject: parametrosParaEnviar)
            request.httpBody = self.prepareData(params: parametrosParaEnviar)//jsonData
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, respuesta, error) in
            
            if progress != nil{
                DispatchQueue.main.async {
                    progress.removeFromSuperview()
                }
            }
            
            guard let data = data, error == nil else {
                if debug{
                    print("\(String(describing: error?.localizedDescription))")
                }
                if self.delegate != nil{
                    let alerta = UIAlertController(title: "Error",
                                                   message: error?.localizedDescription,
                                                   preferredStyle: .alert);
                    self.delegate.HGCargadorHGTerminoCargaConError(cargador: self, error: alerta)
                }
                return
            }
            self.procesarDatos(json: JSON(data), debug: debug)
        }
        task.resume()
        
    }
    
    private func procesarDatos(json:JSON,debug:Bool){
        if json["error"] == JSON.null{
            if debug{
                print(json)
                print("TERMINO SERVICIO BIEN ========================================")
            }
            if self.delegate != nil{
                self.delegate.HGCargadorHGTerminoCarga(cargador: self, respuesta: json)
            }
        }else{
            if self.delegate != nil{
                
                if debug{
                    print(json["errorMessage"])
                    print("TERMINO SERVICIO ERROR ========================================")
                }
                
                if HGUtils.isSpanish{
                    let alerta = UIAlertController(title: "Error",
                                                   message: json["errorMessage"].stringValue,
                                                   preferredStyle: .alert)
                    self.delegate.HGCargadorHGTerminoCargaConError(cargador: self, error: alerta)
                }else{
                    let alerta = UIAlertController(title: "Error",
                                                   message: json["errorMessage_en"].stringValue,
                                                   preferredStyle: .alert)
                    self.delegate.HGCargadorHGTerminoCargaConError(cargador: self, error: alerta)
                }
            }
        }
    }
    
    private func prepareData(params:[String:String])->Data{
        var cadena = ""
        
        params.keys.forEach { (key) in
            cadena += key
            cadena += "="
            cadena += params[key]!
            cadena += "&"
        }
        
        print("Cadena parametros HGCargadorHG: \(cadena)")
        return cadena.data(using: .utf8)!
    }
    
    private func AuthorizationHeader(usr:String,pw:String)->String{
        let first = "\(usr):\(pw)"
        let plainData=first.data(using: String.Encoding.utf8)
        let base64=plainData?.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
        let head:String = "Basic "+String(data: base64!, encoding: String.Encoding.utf8)!
        return head
    }
}

public enum HGHttpMethod{
    case post
    case get
    public func metodo()->String{
        switch self {
        case .post:
            return "POST"
        case .get:
            return "GET"
        }
    }
}
