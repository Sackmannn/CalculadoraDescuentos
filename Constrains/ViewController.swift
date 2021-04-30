//
//  ViewController.swift
//  Constrains
//
//  Created by user on 5/4/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var descuento: UILabel!
    @IBOutlet weak var cantidadTxt: UITextField!
    @IBOutlet weak var prcTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pantalla()
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }

    
    func pantalla (){
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("Iphone 5")
            case 1334:
                print("Iphone 6")
            case 1920:
                print("Iphone Plus")
            case 2436:
                print("Iphone 10")
            case 1792:
                print("Iphone XR")
            case 2688:
                print("Iphone X")
            default:
                print("Cualquier otro tamaño")
            }
            
        }
        
    }
    @objc func teclado(notificacion: Notification) {
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as?NSValue)?.cgRectValue else { return }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height == 1792{
                self.view.frame.origin.y = -tecladoUp.height
            }
        }else {
            self.view.frame.origin.y = 0
            
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func Calcular2(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let numero = cantidadTxt.text else { return }
        guard let porc = prcTxt.text else { return }
        //Transformar a valor float
        let cant = (numero as NSString).floatValue
        let porciento = (porc as NSString).floatValue
        
        let desc = cant * porciento / 100
        
        let totalFinal = cant - desc
        
        total.text = "$\(totalFinal)"
        descuento.text = "$\(desc)"
    }
    
    
    @IBAction func limpair(_ sender: UIButton) {
        self.view.endEditing(true)
        total.text = "$0.00"
        descuento.text = "$0.00"
        cantidadTxt.text = ""
        prcTxt.text = ""
    }
    
}

