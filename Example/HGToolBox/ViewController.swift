//
//  ViewController.swift
//  HGToolBox
//
//  Created by Alexander Ortiz on 08/15/2017.
//  Copyright (c) 2017 Alexander Ortiz. All rights reserved.
//

import UIKit
import HGToolBox

@available(iOS 9.1, *)
class ViewController: UIViewController {
    
    //@IBOutlet var btnHGRightDetailButton: HGRightDetailButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.btnHGRightDetailButton.addTarget(target: self, action: #selector(self.actionForHGRightDetailButton), foR: .touchUpInside)
        
        print(HGUtils.isSpanish)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func actionForHGRightDetailButton(){
        print("Hola btnHGRightDetailButton")
    }
 
    func esEspanol()->Bool{
        let pre = Locale.preferredLanguages[0]
        let idioma=pre.components(separatedBy: "-")
        ////print(idioma[0])
        if idioma[0] == "es" {
            return true
        }else{
            return false
        }
    }
    
}

