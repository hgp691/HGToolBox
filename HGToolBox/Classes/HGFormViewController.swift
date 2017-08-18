//
//  HGFormViewController.swift
//  Pods
//
//  Created by Horacio Guzmán Parra on 17/08/17.
//
//

import UIKit

open class HGFormViewController: UIViewController,UITextFieldDelegate {
    
    var keyBoardSize:CGFloat = 220.0
    
    public var distanciaAbajoOriginal:CGFloat!
    @IBOutlet var distanciaAbajo: NSLayoutConstraint!

    override open func viewDidLoad() {
        super.viewDidLoad()

        self.ConfigOcultarTeclado()
        // Do any additional setup after loading the view.
    }

    
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func configurarConstraintAbajo(cons:NSLayoutConstraint){
        self.distanciaAbajo = cons
        self.distanciaAbajoOriginal = self.distanciaAbajo.constant
    }

    //MARK: FUNCIONES PARA OCULTAR TECLADO
    func ConfigOcultarTeclado(){
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.ocultarTeclado))
        self.view.addGestureRecognizer(tap)
        
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(self.ocultarTeclado))
        swip.direction = .down
        self.view.addGestureRecognizer(swip)
        let swip1 = UISwipeGestureRecognizer(target: self, action: #selector(self.ocultarTeclado))
        swip1.direction = .up
        self.view.addGestureRecognizer(swip1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func ocultarTeclado(){
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            let keyboardScreenFrameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewFrameEnd = view.convert(keyboardScreenFrameEnd, from: view.window)
            let keyboardHeight = keyboardViewFrameEnd.height
            if self.keyBoardSize < keyboardHeight{
                self.keyBoardSize = keyboardHeight
            }
        }
    }
    
    func sacarEntradas(constraint:NSLayoutConstraint,tanto:CGFloat){
        constraint.constant = constraint.constant + tanto
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    func meterEntradas(constraint:NSLayoutConstraint,original:CGFloat){
        constraint.constant = original
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        let punto=textField.convert(textField.frame.origin, to: self.view)
        let altoTextfield = textField.frame.size.height
        if (self.view.frame.size.height-punto.y) < altoTextfield+self.keyBoardSize {
            print("debajo")
            let min=self.keyBoardSize+altoTextfield
            let cuanto=min-(self.view.frame.size.height-punto.y)
            self.sacarEntradas(constraint: self.distanciaAbajo, tanto: cuanto)
        }else{
            print("encima")
        }
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.meterEntradas(constraint: self.distanciaAbajo, original: self.distanciaAbajoOriginal)
    }

}
