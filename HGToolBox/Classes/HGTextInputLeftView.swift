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
public class HGTextInputLeftView: UIView {
    
    private var _tipo:HGTextInputType = .name
    private var _campo:UITextField!
    private var _error:UILabel!
    private var _contenedor:UIView!
    private var _viewIzquierda:UIView!
    
    private var confirmarConCampo:HGTextInputLeftView!
    
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
    
    //MARK: VARIABLES PARA EL BORDE
    @IBInspectable
    public var radioCampoTexto:CGFloat = 0.0{
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
    @IBInspectable
    public var anchoBorde:CGFloat = 0.0{
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
    @IBInspectable
    public var colorBorde:UIColor = .clear{
        didSet{
            if self._campo == nil{
                self.configurarCampoTexto()
            }
            self._campo.layer.borderColor = colorBorde.cgColor
        }
    }
    
    
    @IBInspectable
    public var colorFondo:UIColor = .clear{
        didSet{
            if self._campo == nil{
                self.configurarCampoTexto()
            }
            self._campo.backgroundColor = colorFondo
        }
    }
    
    //DEFINE EL TIPO DEL CAMPO DE TEXTO
    @IBInspectable
    public var tipo:Int = HGTextInputType.name.hashValue{
        didSet{
            self._tipo = HGTextInputType(value: tipo)
            self.configurarLetraCampo()
        }
    }
    
    //MARK: VARIABLES PARA IMAGEN IZQUIERDA
    @IBInspectable
    public var imagenIzquierda:UIImage!{
        didSet{
            if imagenIzquierda != nil{
                self.configurarImagenIzquierda()
            }else{
                
            }
        }
    }
    
    //MARK: VARIABLES PARA Fuentes
    @IBInspectable
    public var tamanoLetra:CGFloat = 17.0{
        didSet{
            if self.existeFuente(nombre: self.fuente){
                self._fuente = UIFont(name: self.fuente, size: self.tamanoLetra)!
            }else{
                print("No existe fuente \(fuente)")
            }
        }
    }
    
    @IBInspectable
    public var fuente:String = "Arial"{
        didSet{
            if self.existeFuente(nombre: fuente){
                self._fuente = UIFont(name: self.fuente, size: self.tamanoLetra)!
            }else{
                print("No existe fuente fuente \(fuente)")
            }
        }
    }
    @IBInspectable
    public var colorFuente:UIColor = .white{
        didSet{
            if self._campo != nil{
                self._campo.textColor = colorFuente
            }
        }
    }
    
    private var _fuente:UIFont = UIFont(name: "ArialMT", size: 17.0)!{
        didSet{
            self.configurarLetraCampo()
            self.tamanoError = 10.0
        }
    }
    
    @IBInspectable
    public var mensajeError:String = ""{
        didSet{
            if self._error != nil{
                self._error.text = mensajeError
            }
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
            if self._error != nil{
                self._error.textColor = colorError
                self._campo.layer.borderColor = self.colorError.cgColor
            }
        }
    }
    
    public var tamañoMinimo:Int = 6
    public var tamañoMaximo:Int = 10
    public var tipoValidacionContraseña:HGTextInputPWValidationType = .MayusculaYTamaños
    
    public var delegate:UITextFieldDelegate!{
        didSet{
            if self._campo != nil{
                self._campo.delegate = delegate
            }
        }
    }
    
    override public func prepareForInterfaceBuilder() {
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
            self._campo.delegate = self.delegate
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
    
    private func configurarPlaceholder(){
        if self._campo != nil{
            self._campo.placeholder = self._tipo.placeholder()
        }
    }
    
    private func configurarImagenIzquierda(){
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
    
    private func configurarLetraCampo(){
        if self._campo != nil{
            self._campo.placeholder = self._tipo.placeholder()
            self._campo.font = self._fuente
            
            switch self._tipo {
            case .name:
                self._campo.keyboardType = .namePhonePad
                break
            case .email:
                self._campo.keyboardType = .emailAddress
                self._campo.autocorrectionType = .no
                self._campo.autocapitalizationType = .none
                break
            case .password:
                self._campo.isSecureTextEntry = true
                self._campo.autocorrectionType = .no
                self._campo.keyboardType = .default
                break
            case .confirmPassword:
                self._campo.isSecureTextEntry = true
                self._campo.autocorrectionType = .no
                self._campo.keyboardType = .default
                break
            case .cell:
                self._campo.keyboardType = .phonePad
                self._campo.autocorrectionType = .no
                break
            }
            
            
        }
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
    
    public func confirMarConCampo(campo:HGTextInputLeftView){
        if self._tipo == .confirmPassword{
            self.confirmarConCampo = campo
        }
    }
    
    public func setValue(value:String){
        if self._campo != nil{
            self._campo.text = value
        }
    }
    
    public func esValido()->Bool{
        if self.noEsVacio(){
            switch self._tipo {
            case .name:
                return true
            case .email:
                return self.validarEmail()
            case .password:
                return self.validarPW()
            case .confirmPassword:
                return self.validarPWConfirm()
            case .cell:
                return true
            }
        }else{
            return false
        }
        
    }
    
    
    //MARK: FUNCIONES DE VALIDACION
    private func noEsVacio()->Bool{
        self.quitarError()
        if (self._campo.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count)! > 0{
            return true
        }
        if HGUtils.isSpanish{
            self.ponerError(mensaje: "Debe completar")
        }else{
            self.ponerError(mensaje: "You must complete it")
        }
        return false
    }
    
    private func validarEmail()->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: self._campo.text){
            self.quitarError()
            return true
        }else{
            if HGUtils.isSpanish{
                self.ponerError(mensaje: "Esto no es un e-mail")
            }else{
                self.ponerError(mensaje: "This is not an e-mail")
            }
            return false
        }
    }
    private func validarPW()->Bool{
        let pwRegEx = self.tipoValidacionContraseña.Regex(min: self.tamañoMinimo, max: self.tamañoMaximo)
        let pwTest = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        if pwTest.evaluate(with: self._campo.text){
            self.quitarError()
            return true
        }else{
            if HGUtils.isSpanish{
                self.ponerError(mensaje: "No cumple con lo esperado")
            }else{
                self.ponerError(mensaje: "This is not what is expected")
            }
            return false
        }
    }
    private func validarPWConfirm()->Bool{
        self.quitarError()
        if self.value() == self.confirmarConCampo.value(){
            return true
        }
        if HGUtils.isSpanish{
            self.ponerError(mensaje: "Las contraseñas deben conincidir")
        }else{
            self.ponerError(mensaje: "The passwords don't match")
        }
        return false
    }
    public func value()->String{
        return (self._campo.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
    }
    
    private func ponerError(mensaje:String){
        self._error.text = mensaje
        self._campo.layer.borderWidth = 1.0
        self._campo.layer.borderColor = self.colorError.cgColor
    }
    
    private func quitarError(){
        self._error.text = ""
        self._campo.layer.borderWidth = self.anchoBorde
        self._campo.layer.borderColor = self.colorBorde.cgColor
    }
}
public enum HGTextInputType{
    
    case email
    case name
    case password
    case confirmPassword
    case cell
    
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
        case 3:
            self = .confirmPassword
        case 4:
            self = .cell
        default:
            self = .name
        }
    }
    
    public func placeholder()->String{
        if HGUtils.isSpanish{
            switch self{
            case .name:
                return "Nombre completo"
            case .email:
                return "Correo"
            case .password:
                return "Contraseña"
            case .confirmPassword:
                return "Confirmar Contraseña"
            case .cell:
                return "Celular"
            }
        }else{
            switch self{
            case .name:
                return "Full name"
            case .email:
                return "E-mail"
            case .password:
                return "Password"
            case .confirmPassword:
                return "Confirm Password"
            case .cell:
                return "Cell phone"
            }
        }
    }
}

public enum HGTextInputPWValidationType{
    case none
    case tamañoMinimo
    case tamañoMaximo
    case tamañoMinimoYMaximo
    case MayusculaYTamaños
    case MayusculaSinTamaños
    
    public func Regex(min:Int,max:Int)->String{
        switch self {
        case .none:
            return "[\\s\\S]*"
        case .tamañoMinimo:
            let reg = "^.{\(min),}$"
            return reg
        case .tamañoMaximo:
            let reg = "^.{0,\(max)}$"
            return reg
        case .tamañoMinimoYMaximo:
            let reg = "^.{\(min),\(max)}$"
            return reg
        case .MayusculaYTamaños:
            let reg = "^.(?=.*[A-Z]).{\(min),\(max)}"
            return reg
        case .MayusculaSinTamaños:
            let reg = "^.(?=.*[A-Z])"
            return reg
        }
    }
    
}
