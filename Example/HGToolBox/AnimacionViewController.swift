//
//  AnimacionViewController.swift
//  HGToolBox_Example
//
//  Created by Horacio Guzman on 1/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Lottie

class AnimacionViewController: UIViewController {

    @IBOutlet weak var contenedorNivel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.configurarNivel()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configurarNivel(){
        
        let animacionNivel = LOTAnimationView(name: "niveles")
        self.contenedorNivel.addSubview(animacionNivel)
        
        animacionNivel.translatesAutoresizingMaskIntoConstraints = false
        
        animacionNivel.topAnchor.constraint(equalTo: self.contenedorNivel.topAnchor).isActive = true
        animacionNivel.bottomAnchor.constraint(equalTo: self.contenedorNivel.bottomAnchor).isActive = true
        animacionNivel.leadingAnchor.constraint(equalTo: self.contenedorNivel.leadingAnchor).isActive = true
        animacionNivel.trailingAnchor.constraint(equalTo: self.contenedorNivel.trailingAnchor).isActive = true
        
        
        
        
        //animacionNivel.play(toProgress: CGFloat(caso1)) { (ok) in
        //print("OK: \(ok)")
        //}
        animacionNivel.play(fromProgress: 0.0, toProgress: 0.5) { (ok) in
            print("Piner caso")
        }
    }
}
