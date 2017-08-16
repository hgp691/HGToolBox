//
//  HGTextInputLeftView.swift
//  Pods
//
//  Created by Horacio Guzmán Parra on 15/08/17.
//
//

import UIKit

@available(iOS 9.0, *)
@IBDesignable
class HGTextInputLeftView: UIView {
    
    private var _tipo:HGTextInputType = .name
    private var _campo:UITextField!
    private var _error:UILabel!
    private var _contenedor:UIView!
    
    //MARK: VARIABLES DE PADDING DEL CONTENEDOR
    @IBInspectable var paddingSuperior:CGFloat = 0.0{
        didSet{
            self.configurarCampoTexto()
        }
    }
    @IBInspectable var paddingInferior:CGFloat = 0.0{
        didSet{
            self.configurarCampoTexto()
        }
    }
    @IBInspectable var paddingIzquierda:CGFloat = 0.0{
        didSet{
            self.configurarCampoTexto()
        }
    }
    @IBInspectable var paddingDerecha:CGFloat = 0.0{
        didSet{
            self.configurarCampoTexto()
        }
    }
    
    //MARK: VARIABLES PARA EL BORDE
    @IBInspectable var radioCampoTexto:CGFloat = 0.0{
        didSet{
            print("Did set radioCampo")
            if radioCampoTexto < 0.0{
                radioCampoTexto = 0
            }
            self._campo.layer.cornerRadius = radioCampoTexto
        }
    }
    @IBInspectable var anchoBorde:CGFloat = 0.0{
        didSet{
            if self._campo == nil{
                self.configurarCampoTexto()
            }
            if anchoBorde < 0{
                anchoBorde = 0
            }
            self._campo.layer.borderWidth = anchoBorde
        }
    }
    @IBInspectable var colorBorde:UIColor = .clear{
        didSet{
            if self._campo == nil{
                self.configurarCampoTexto()
            }
            self._campo.layer.borderColor = colorBorde.cgColor
        }
    }
    
    /// FUNCION QUE CONFIGURA EL CAMPO DE TEXTO
    @available(iOS 9.0, *)
    private func configurarCampoTexto(){
        self.configurarCampoTextoYErrorTamano()
        self.configurarPlaceholder()
    }


    @available(iOS 9.0, *)
    private func configurarCampoTextoYErrorTamano(){
        
        self.subviews.forEach { (vista) in
            vista.removeFromSuperview()
        }
        
        self._campo = UITextField()
        self._error = UILabel()
        self._contenedor = UIView()
        
        self.addSubview(_contenedor)
        self._contenedor.translatesAutoresizingMaskIntoConstraints = false
        self._contenedor.backgroundColor = .clear
        self._contenedor.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.paddingIzquierda).isActive = true
        
        self._contenedor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.paddingDerecha).isActive = true
        self._contenedor.topAnchor.constraint(equalTo: self.topAnchor, constant: self.paddingSuperior).isActive = true
        self._contenedor.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.paddingInferior).isActive = true
        
        
        self._contenedor.addSubview(self._campo)
        self._contenedor.addSubview(self._error)
        
        self._campo.translatesAutoresizingMaskIntoConstraints = false
        self._error.translatesAutoresizingMaskIntoConstraints = false
        //error
        self._error.leadingAnchor.constraint(equalTo: self._contenedor.leadingAnchor).isActive = true
        self._error.trailingAnchor.constraint(equalTo: self._contenedor.trailingAnchor).isActive = true
        self._error.topAnchor.constraint(equalTo: self._contenedor.topAnchor).isActive = true
        self._error.heightAnchor.constraint(equalTo: self._contenedor.heightAnchor, multiplier: 0.3).isActive = true
        
        self._campo.leadingAnchor.constraint(equalTo: self._contenedor.leadingAnchor).isActive = true
        self._campo.trailingAnchor.constraint(equalTo: self._contenedor.trailingAnchor).isActive = true
        self._campo.bottomAnchor.constraint(equalTo: self._contenedor.bottomAnchor).isActive = true
        self._campo.topAnchor.constraint(equalTo: self._error.bottomAnchor).isActive = true
        
        self._campo.backgroundColor = .red
        self._error.backgroundColor = .yellow
    }
    
    func configurarPlaceholder(){
        self._campo.placeholder = self._tipo.placeholder()
    }
    
}
enum HGTextInputType{
    
    case email
    case name
    
    public init(){
        self = .name
    }
    public init(value:Int){
        switch value {
        case 0:
            self = .name
        case 1:
            self = .email
        default:
            self = .name
        }
    }
    public func placeholder()->String{
        switch self{
        case .name:
            return "Nombre:"
        case .email:
            return "Correo:"
        }
    }
}
