//
//  FormularioViewController.swift
//  HGToolBox
//
//  Created by Horacio Guzmán Parra on 17/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import HGToolBox

@available(iOS 9.0, *)
class FormularioViewController: HGFormViewController {
    
    @IBOutlet weak var distanciaAbajo: NSLayoutConstraint!
    
    @IBOutlet weak var campo: HGTextInputLeftView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurarConstraintAbajo(cons: self.distanciaAbajo)
        self.campo.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
