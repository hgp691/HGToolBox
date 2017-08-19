//
//  ProgressLottieViewController.swift
//  HGToolBox
//
//  Created by Alexander Ortiz on 18/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import HGToolBox

class ProgressLottieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let progress = HGLottieProgress(view: self.view, animationName: "location", loop: true, size: CGSize(width: 200, height: 200))
        progress.playProgress { (ok) in
            print("Termino")
        }
        
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
