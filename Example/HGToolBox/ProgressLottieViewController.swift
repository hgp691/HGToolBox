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
        
        let opts = ["lottieAnimationName":"location",
                    "lottieAnimationSize":CGSize(width: 200.0, height: 200.0),
                    "loop":true
                    ] as [String : Any]
        
        let progress = HGLottieProgress(view: self.view, configuration: opts, autoplay: true)

        
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
