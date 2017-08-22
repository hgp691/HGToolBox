//
//  HGLottieProgress.swift
//  Pods
//
//  Created by Alexander Ortiz on 18/08/17.
//
//

import UIKit
import Lottie

public class HGLottieProgress: UIView {
    
    private var animacion:LOTAnimationView!
    
    public init(view:UIView,configuration:[String:Any],autoplay:Bool){
        super.init(frame: view.frame)
        
        self.backgroundColor = configuration["lottieAnimationBackGroundColor"] as? UIColor
        
        self.animacion = LOTAnimationView(name: configuration["lottieAnimationName"] as! String)
        self.animacion.frame = CGRect(origin: CGPoint.zero, size: configuration["lottieAnimationSize"] as! CGSize)
        self.animacion.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.animacion.loopAnimation = configuration["loop"] as! Bool
        self.addSubview(self.animacion)
        view.addSubview(self)
        if autoplay{
            self.animacion.play()
        }
    }
    
    public func playProgress(completion: LOTAnimationCompletionBlock?){
        self.animacion.play(completion: completion)
    }
    
    public func playProgress(toProgress: CGFloat,withCompletion:LOTAnimationCompletionBlock?){
        self.animacion.play(toProgress: toProgress, withCompletion: withCompletion)
    }
    

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
