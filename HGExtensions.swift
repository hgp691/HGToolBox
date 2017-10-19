//
//  HGExtensions.swift
//  Alamofire
//
//  Created by Alexander Ortiz on 19/10/17.
//

import Foundation
import UIKit

//MARK: UIVIEW
extension UIView{
    func estaDebug()->Bool{
        return false
    }
}

extension UIViewController{
    
    //MARK FUNCIONES PARA CONFIGURAR NAVBAR
    func configurarNavBarTransparente(){
        let atributosTextoNavBar = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Akrobat-Bold", size: 18.0)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = atributosTextoNavBar as Any as? [NSAttributedStringKey : Any]
        
        let navbarColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        let image = UIImage()
        
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        navigationController?.navigationBar.backgroundColor = navbarColor
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let statusBarWidth = UIScreen.main.bounds.size.width
        
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: statusBarWidth, height: statusBarHeight))
        statusBarView.backgroundColor = navbarColor
        
        view.addSubview(statusBarView)
    }
    ///funcion que configura el backButton
    func configurarBackButton(imageName:String,tintColor:UIColor){
        let but=UIBarButtonItem(image: UIImage(named: imageName), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.volver))
        but.tintColor = tintColor
        self.navigationItem.setLeftBarButton(but, animated: true)
    }
    @objc func volver(){
        //print("Volver")
        _ = self.navigationController?.popViewController(animated: true)
    }
    func logoEnNavBar(imageName:String,frame:CGRect){
        //CGRect(x: 0, y: 0, width: 97, height: 40)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: imageName)
        imageView.image = image
        self.navigationController?.navigationBar.topItem?.titleView = imageView
    }
    
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        ////print("IDENTIFIER: \(identifier)")
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6"
        case "iPhone8,2":                               return "iPhone 6 Plus"
        case "iPhone9,1":                               return "iPhone 6"
        case "iPhone9,2":                               return "iPhone 6 Plus"
        case "iPhone9,3":                               return "iPhone 6"
        case "iPhone9,4":                               return "iPhone 6 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

public extension UIImage{
    
    func obtenerImagenCuadrada(ancho:CGFloat)->UIImage{
        let contextImage = UIImage(cgImage: self.cgImage!)
        let contextSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat!
        var cgheight: CGFloat!
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        let rect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        // Create a new image based on the imageRef and rotate back to the original orientation
        //print("Escala: \(imgOriginal.scale)")
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        print("Tamaño Imagen cuadrada: \(image.size)")
        return resizeImage(image: image, newWidth: ancho)
    }
    
    func obtenerImagenArreglada(tamañoMinimo:CGFloat)->UIImage{
        
        let contextImage = UIImage(cgImage: self.cgImage!)
        let contextSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat!
        var cgheight: CGFloat!
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            /// la imagen es horizontal
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.width
            cgheight = contextSize.height
        } else {
            /// la imagen es vertical
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.height
        }
        
        let rect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        // Create a new image based on the imageRef and rotate back to the original orientation
        //print("Escala: \(imgOriginal.scale)")
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        print("Tamaño Imagen arreglada: \(image.size)")
        return resizeImage(image: image, newWidth: tamañoMinimo)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        //UIRectFill(CGRectMake(0, 0, size.width, size.height))
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}
