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
    private var _viewIzquierda:UIView!
    
    //MARK: VARIABLES DE PADDING DEL CONTENEDOR
    @IBInspectable var paddingSuperior:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    @IBInspectable var paddingInferior:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    @IBInspectable var paddingIzquierda:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    @IBInspectable var paddingDerecha:CGFloat = 0.0{
        didSet{
            self.configurarContenedor()
        }
    }
    
    //MARK: VARIABLES PARA EL BORDE
    @IBInspectable var radioCampoTexto:CGFloat = 0.0{
        didSet{
            print("Did set radioCampo")
            if radioCampoTexto < 0.0{
                radioCampoTexto = 0
            }
            if self._campo == nil{
                self.configurarCampoTexto()
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
    
    
    @IBInspectable var colorFondo:UIColor = .clear{
        didSet{
            if self._campo == nil{
                self.configurarCampoTexto()
            }
            self._campo.backgroundColor = colorFondo
        }
    }
    
    //DEFINE EL TIPO DEL CAMPO DE TEXTO
    @IBInspectable var tipo:Int = HGTextInputType.name.hashValue{
        didSet{
            self._tipo = HGTextInputType(value: tipo)
            self.configurarLetraCampo()
        }
    }
    
    //MARK: VARIABLES PARA IMAGEN IZQUIERDA
    @IBInspectable var imagenIzquierda:UIImage!{
        didSet{
            if imagenIzquierda != nil{
                self.configurarImagenIzquierda()
            }else{
                
            }
        }
    }
    
    //MARK: VARIABLES PARA Fuentes
    @IBInspectable var tamanoLetra:CGFloat = 17.0{
        didSet{
            if self.existeFuente(nombre: self.fuente){
                self._fuente = UIFont(name: self.fuente, size: self.tamanoLetra)!
            }else{
                print("No existe fuente \(fuente)")
            }
        }
    }
    
    @IBInspectable var fuente:String = "Arial"{
        didSet{
            if self.existeFuente(nombre: fuente){
                self._fuente = UIFont(name: self.fuente, size: self.tamanoLetra)!
            }else{
                print("No existe fuente fuente \(fuente)")
            }
        }
    }
    
    var _fuente:UIFont = UIFont(name: "ArialMT", size: 17.0)!{
        didSet{
            self.configurarLetraCampo()
            self.tamanoError = 10.0
        }
    }
    
    @IBInspectable var mensajeError:String = ""{
        didSet{
            if self._error != nil{
                self._error.text = mensajeError
            }
        }
    }
    
    @IBInspectable var tamanoError:CGFloat = 10.0{
        didSet{
            if self.existeFuente(nombre: self._fuente.fontName) && self._error != nil{
                self._error.font = UIFont(name: self._fuente.fontName, size: tamanoError)
            }else{
                print("no existe fuente tamanoError \(fuente)")
            }
        }
    }
    
    @IBInspectable var colorError:UIColor = .red{
        didSet{
            if self._error != nil{
                self._error.textColor = colorError
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.configurarCampoTexto()
    }
    
    /// FUNCION QUE CONFIGURA EL CAMPO DE TEXTO
    private func configurarCampoTexto(){
        self.configurarCampoTextoYErrorTamano()
        self.configurarPlaceholder()
    }
    
    private func configurarContenedor(){
        print("Configurar contenedor")
        if self._contenedor == nil{
            print("Instancia")
            self._contenedor = UIView()
            self.addSubview(_contenedor)
            self._contenedor.translatesAutoresizingMaskIntoConstraints = false
            self._contenedor.backgroundColor = .clear
        }
        self._contenedor.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.paddingIzquierda).isActive = true
        self._contenedor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.paddingDerecha).isActive = true
        self._contenedor.topAnchor.constraint(equalTo: self.topAnchor, constant: self.paddingSuperior).isActive = true
        self._contenedor.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.paddingInferior).isActive = true
    }
    
    private func configurarCampoTextoYErrorTamano(){
        
        if self._contenedor == nil{
            self.configurarContenedor()
        }
        if self._campo == nil{
            self._campo = UITextField()
            self._contenedor.addSubview(self._campo)
            self._campo.translatesAutoresizingMaskIntoConstraints = false
        }
        if self._error == nil{
            self._error = UILabel()
            self._contenedor.addSubview(self._error)
            self._error.translatesAutoresizingMaskIntoConstraints = false
            self._error.textAlignment = .right
        }
        //error
        self._error.leadingAnchor.constraint(equalTo: self._contenedor.leadingAnchor).isActive = true
        self._error.trailingAnchor.constraint(equalTo: self._contenedor.trailingAnchor).isActive = true
        self._error.topAnchor.constraint(equalTo: self._contenedor.topAnchor).isActive = true
        self._error.heightAnchor.constraint(equalTo: self._contenedor.heightAnchor, multiplier: 0.3).isActive = true
        
        self._campo.leadingAnchor.constraint(equalTo: self._contenedor.leadingAnchor).isActive = true
        self._campo.trailingAnchor.constraint(equalTo: self._contenedor.trailingAnchor).isActive = true
        self._campo.bottomAnchor.constraint(equalTo: self._contenedor.bottomAnchor).isActive = true
        self._campo.topAnchor.constraint(equalTo: self._error.bottomAnchor).isActive = true
    }
    
    func configurarPlaceholder(){
        if self._campo != nil{
            self._campo.placeholder = self._tipo.placeholder()
        }
    }
    
    func configurarImagenIzquierda(){
        if self._contenedor == nil{
            self.configurarContenedor()
        }
        if self._campo == nil{
            self.configurarCampoTexto()
        }
        if self._viewIzquierda == nil{
            self._viewIzquierda = UIView()
            self._viewIzquierda.translatesAutoresizingMaskIntoConstraints = false
            self._contenedor.addSubview(self._viewIzquierda)
        }
        
        
        self._viewIzquierda.heightAnchor.constraint(equalTo: self._contenedor.heightAnchor, multiplier: 0.7).isActive = true
        let const = imagenIzquierda.size.width / imagenIzquierda.size.height
        self._viewIzquierda.widthAnchor.constraint(equalTo: self._viewIzquierda.heightAnchor, multiplier: const).isActive = true
        self._viewIzquierda.backgroundColor = .clear
        let bgn = UIImageView(image: imagenIzquierda)
        bgn.translatesAutoresizingMaskIntoConstraints = false
        self._viewIzquierda.addSubview(bgn)
        bgn.topAnchor.constraint(equalTo: self._viewIzquierda.topAnchor).isActive = true
        bgn.bottomAnchor.constraint(equalTo: self._viewIzquierda.bottomAnchor).isActive = true
        bgn.leadingAnchor.constraint(equalTo: self._viewIzquierda.leadingAnchor).isActive = true
        bgn.trailingAnchor.constraint(equalTo: self._viewIzquierda.trailingAnchor).isActive = true
        
        print("El campo")
        print(self._campo)
        
        self._campo.leftViewMode = .always
        self._campo.leftView = self._viewIzquierda
    }
    
    func configurarLetraCampo(){
        if self._campo != nil{
            self._campo.placeholder = self._tipo.placeholder()
            self._campo.font = self._fuente
        }
    }
    func existeFuente(nombre:String)->Bool{
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
}
enum HGTextInputType{
    
    case email
    case name
    case password
    
    public init(){
        self = .name
    }
    public init(value:Int){
        switch value {
        case 0:
            self = .name
        case 1:
            self = .email
        case 2:
            self = .password
        default:
            self = .name
        }
    }
    public func placeholder()->String{
        switch self{
        case .name:
            return "Nombre"
        case .email:
            return "Correo"
        case .password:
            return "Contraseña"
        }
    }
}
