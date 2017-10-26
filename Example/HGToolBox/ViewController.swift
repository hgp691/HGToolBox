//
//  ViewController.swift
//  HGToolBox
//
//  Created by Alexander Ortiz on 08/15/2017.
//  Copyright (c) 2017 Alexander Ortiz. All rights reserved.
//

import UIKit
import SwiftyJSON
import HGToolBox

@available(iOS 9.1, *)
class ViewController: UIViewController {
    
    //@IBOutlet var btnHGRightDetailButton: HGRightDetailButton!
    @IBOutlet var latitud: UITextField!
    @IBOutlet var longitud: UITextField!
    @IBOutlet var resultado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //14.079110,-87.189372
        
        self.latitud.text = "14.079110"
        self.longitud.text = "-87.189372"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func actionForHGRightDetailButton(){
        print("Hola btnHGRightDetailButton")
    }
    @IBAction func efectuar(_ sender: Any) {
        
        let lat = Double(self.latitud.text!)
        let lng = Double(self.longitud.text!)
        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat!),\(lng!)&language=es&key=AIzaSyD3dXuwi2WQx4iOkZuxqfd-UOsiHAzIr8w"
        print("Enviar Request \(urlString)")
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, err) in
            guard let data = data,err == nil else{
                DispatchQueue.main.async {
                    self.resultado.text = err?.localizedDescription
                }
                return
            }
            
            let json = JSON(data)
            print(json)
            let dataparser = HGGMDataParser()
            
            DispatchQueue.main.async {
                self.resultado.text = dataparser.retornaNombreCiudad(obj: json["results"])
            }
            
            
        }.resume()
        
    }
    
}

