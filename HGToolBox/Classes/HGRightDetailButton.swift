//
//  HGRightDetailButton.swift
//  Pods
//
//  Created by Alexander Ortiz on 17/08/17.
//
//

import UIKit

@available(iOS 9.0, *)
@IBDesignable
public class HGRightDetailButton: UIView {

    private var _error:UILabel!
    private var _contenedor:UIView!
    private var _viewDerecha:UIImageView!
    private var button:UIButton!
    private var _placeHolder:UILabel!
    private var _contenedor2:UIView!
    
    //MARK: VARIABLES DE PADDING DEL CONTENEDOR
    @IBInspectable
    public var paddingSuperior:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    @IBInspectable
    public var paddingInferior:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    @IBInspectable
    public var paddingIzquierda:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    
    @IBInspectable
    public var paddingDerecha:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    
    @IBInspectable
    public var redondeoBorde:CGFloat = 0.0{
        didSet{
            if self._contenedor2 == nil{
                self.configurarBoton()
            }
            self._contenedor2.layer.cornerRadius = redondeoBorde
        }
    }
    
    @IBInspectable
    public var imagenDerecha:UIImage!{
        didSet{
            if self._viewDerecha == nil{
                self.configurarBoton()
            }
            self._viewDerecha.image = imagenDerecha
        }
    }
    
    @IBInspectable
    public var titulo:String = ""{
        didSet{
            if self._placeHolder == nil{
                self.configurarBoton()
            }
            self._placeHolder.text = titulo
        }
    }
    
    @IBInspectable
    public var fuente:String = "ArialMT"{
        didSet{
            if self.existeFuente(nombre: self.fuente){
                self._fuente = UIFont(name: self.fuente, size: self.tamañoFuente)!
            }else{
                
            }
        }
    }
    
    @IBInspectable
    public var tamañoFuente:CGFloat = 10.0{
        didSet{
            if self.existeFuente(nombre: self.fuente){
                self._fuente = UIFont(name: self.fuente, size: self.tamañoFuente)!
            }else{
                
            }
        }
    }
    
    @IBInspectable
    public var colorFuente:UIColor = .black{
        didSet{
            if self._placeHolder == nil{
                self.configurarBoton()
            }
            self._placeHolder.textColor = colorFuente
        }
    }
    
    private var _fuente:UIFont = UIFont(name: "ArialMT", size: 17.0)!{
        didSet{
            if self._placeHolder == nil{
                self.configurarBoton()
            }
            self._placeHolder.font = _fuente
        }
    }
    
    @IBInspectable
    public var colorBackground:UIColor = .clear{
        didSet{
            if self._contenedor2 == nil{
                self.configurarBoton()
            }
            self._contenedor2.backgroundColor = colorBackground
        }
    }
    
    @IBInspectable
    public var mensajeError:String = ""{
        didSet{
            if self._error == nil{
                self.configurarBoton()
            }
            self._error.text = mensajeError
        }
    }
    
    @IBInspectable
    public var tamanoError:CGFloat = 10.0{
        didSet{
            if self.existeFuente(nombre: self._fuente.fontName) && self._error != nil{
                self._error.font = UIFont(name: self._fuente.fontName, size: tamanoError)
            }else{
                print("no existe fuente tamanoError \(fuente)")
            }
        }
    }
    
    @IBInspectable
    public var colorError:UIColor = .red{
        didSet{
            if self._error == nil{
                self.configurarBoton()
            }
            self._error.textColor = colorError
            self._contenedor2.layer.borderColor = colorError.cgColor
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.configurarBoton()
    }
    
    private func configurarContenedor(){
        print("Configurar contenedor")
        if self._contenedor == nil{
            print("Instancia")
            self._contenedor = UIView()
            self.addSubview(_contenedor)
            self._contenedor.translatesAutoresizingMaskIntoConstraints = false
            //self._contenedor.backgroundColor = .red
        }
        self._contenedor.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.paddingIzquierda).isActive = true
        self._contenedor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.paddingDerecha).isActive = true
        self._contenedor.topAnchor.constraint(equalTo: self.topAnchor, constant: self.paddingSuperior).isActive = true
        self._contenedor.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.paddingInferior).isActive = true
    }
    
    private func configurarBoton(){
        
        if self._contenedor == nil{
            self.configurarContenedor()
        }
        if self._contenedor2 == nil{
            self._contenedor2 = UIView()
            self._contenedor.addSubview(self._contenedor2)
            self._contenedor2.translatesAutoresizingMaskIntoConstraints = false
            self._contenedor2.clipsToBounds = true
        }
        if self.button == nil{
            self.button = UIButton()
            self._contenedor2.addSubview(self.button)
            self.button.translatesAutoresizingMaskIntoConstraints = false
        }
        if self._error == nil{
            self._error = UILabel()
            self._contenedor.addSubview(self._error)
            self._error.translatesAutoresizingMaskIntoConstraints = false
            self._error.textAlignment = .right
        }
        if self._viewDerecha == nil{
            self._viewDerecha = UIImageView()
            self._contenedor2.addSubview(self._viewDerecha)
            self._viewDerecha.translatesAutoresizingMaskIntoConstraints = false
        }
        if self._placeHolder == nil{
            self._placeHolder = UILabel()
            self._contenedor2.addSubview(self._placeHolder)
            self._placeHolder.translatesAutoresizingMaskIntoConstraints = false
            self._placeHolder.textAlignment = .center
            self._placeHolder.numberOfLines = 0
        }
        
        
        //error
        self._error.leadingAnchor.constraint(equalTo: self._contenedor.leadingAnchor).isActive = true
        self._error.trailingAnchor.constraint(equalTo: self._contenedor.trailingAnchor).isActive = true
        self._error.topAnchor.constraint(equalTo: self._contenedor.topAnchor).isActive = true
        self._error.heightAnchor.constraint(equalTo: self._contenedor.heightAnchor, multiplier: 0.3).isActive = true
        
        //self._error.backgroundColor = .yellow
        //contenedor2
        self._contenedor2.leadingAnchor.constraint(equalTo: self._contenedor.leadingAnchor).isActive = true
        self._contenedor2.trailingAnchor.constraint(equalTo: self._contenedor.trailingAnchor).isActive = true
        self._contenedor2.bottomAnchor.constraint(equalTo: self._contenedor.bottomAnchor).isActive = true
        self._contenedor2.topAnchor.constraint(equalTo: self._error.bottomAnchor).isActive = true
        
        self.button.leadingAnchor.constraint(equalTo: self._contenedor2.leadingAnchor).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self._contenedor2.trailingAnchor).isActive = true
        self.button.topAnchor.constraint(equalTo: self._contenedor2.topAnchor).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self._contenedor2.bottomAnchor).isActive = true
        
        //self._contenedor2.backgroundColor = .clear
        //viewIzquierda
        self._viewDerecha.trailingAnchor.constraint(equalTo: self._contenedor2.trailingAnchor).isActive = true
        self._viewDerecha.topAnchor.constraint(equalTo: self._contenedor2.topAnchor).isActive = true
        self._viewDerecha.bottomAnchor.constraint(equalTo: self._contenedor2.bottomAnchor).isActive = true
        self._viewDerecha.widthAnchor.constraint(equalTo: self._viewDerecha.heightAnchor, multiplier: 1.0).isActive = true
        
        //self._viewDerecha.backgroundColor = .orange
        //label
        self._placeHolder.leadingAnchor.constraint(equalTo: self._contenedor2.leadingAnchor).isActive = true
        self._placeHolder.topAnchor.constraint(equalTo: self._contenedor2.topAnchor).isActive = true
        self._placeHolder.bottomAnchor.constraint(equalTo: self._contenedor2.bottomAnchor).isActive = true
        self._placeHolder.trailingAnchor.constraint(equalTo: self._viewDerecha.leadingAnchor).isActive = true
        
        //self._placeHolder.backgroundColor = .green
        
        self._contenedor2.bringSubview(toFront: self.button)
        
    }
    
    public func addTarget(target: Any?, action: Selector, foR: UIControlEvents){
        self.button.addTarget(target, action: action, for: foR)
    }
    
    
    private func existeFuente(nombre:String)->Bool{
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("Familia \(familyName): ")
            for fuente in UIFont.fontNames(forFamilyName: familyName){
                print(fuente)
                if fuente == nombre{
                    return true
                }
            }
        }
        return false
    }
    
    public func quitarError(){
        self._contenedor2.layer.borderWidth = 0.0
    }
    
    public func ponerError(mensaje:String){
        self._contenedor2.layer.borderWidth = 2.0
        self.mensajeError = mensaje
    }
}
