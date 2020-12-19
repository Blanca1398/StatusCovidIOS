//
//  ViewController.swift
//  StatusCovid
//
//  Created by Blanca Cordova on 08/12/20.
//  Copyright © 2020 Blanca Cordova. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var paisLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var rLabel: UILabel!
    
    @IBOutlet weak var ctLabel: UILabel!
    @IBOutlet weak var mtLabel: UILabel!
    @IBOutlet weak var rtLabel: UILabel!
    
    @IBOutlet weak var casosLabel: UILabel!
    @IBOutlet weak var muertesLabel: UILabel!
    @IBOutlet weak var recuperadosLabel: UILabel!
    
    @IBOutlet weak var casostLabel: UILabel!
    @IBOutlet weak var muertestLabel: UILabel!
    @IBOutlet weak var recuperadostLabel: UILabel!
    
    @IBOutlet weak var imgBandera: UIImageView!
    
    var statusManager = StatusManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buscarTextField.delegate = self
        statusManager.delegado = self
        LimpiarInfo(paisText: "Busca el pais",img: "covid3.png")

    }
    
    
    @IBAction func btnBuscar(_ sender: UIButton) {
        if buscarTextField.text != "" {
            paisLabel.text = buscarTextField.text
            statusManager.fetchStatus(nombrePais: paisLabel.text!)
             }
             else {
                 //Alerta
                 let alerta = UIAlertController(title: "Campo Vacio", message: "Porfavor asegurese de no dejar el campo vacio al buscar", preferredStyle: .alert)
                 let actionOk = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                 alerta.addAction(actionOk)
                 self.present(alerta, animated: true, completion: nil)
             }
    }
    
    //cerrar teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
    }
    
    func LimpiarInfo(paisText:String, img: String) {
        paisLabel.text = paisText
        cLabel.text = ""
        mLabel.text = ""
        rLabel.text = ""
        
        ctLabel.text = ""
        mtLabel.text = ""
        rtLabel.text = ""
        
        casosLabel.text = ""
        muertesLabel.text = ""
        recuperadosLabel.text = ""
        
        casostLabel.text = ""
        muertestLabel.text = ""
        recuperadostLabel.text = ""
        
        imgBandera.image = UIImage(named: img)
    }
    
    func ReescribirLabels() {
        cLabel.text = "Casos"
        mLabel.text = "Muertes"
        rLabel.text = "Recuperados"
        
        ctLabel.text = "Casos Hoy"
        mtLabel.text = "Muertes Hoy"
        rtLabel.text = "Recuperados Hoy"
    }
    
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        buscarTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if buscarTextField.text != "" {
            paisLabel.text = buscarTextField.text
            statusManager.fetchStatus(nombrePais: paisLabel.text!)
            return true
        }
        else {
            //Alerta
            let alerta = UIAlertController(title: "Campo Vacio", message: "Porfavor asegurese de no dejar el campo vacio al buscar", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Entendido", style: .default, handler: nil)
            alerta.addAction(actionOk)
            self.present(alerta, animated: true, completion: nil)
            return false
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTextField.text != "" {
            return true
        } else {
            buscarTextField.placeholder = "Escribe un Pais"
            return false
        }
    }
    
}


extension ViewController : StatusManagerDelegate {
    func huboError(cualError: Error) {
        print(cualError.localizedDescription)
        
        DispatchQueue.main.async {
            if cualError.localizedDescription == "The data couldn’t be read because it is missing." {
                //Alerta
                let alerta = UIAlertController(title: "Pais Desconocida", message: "Verifica que el nombre del Pais esta bien escrito e intentalo de nuevo", preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                alerta.addAction(actionOk)
                self.present(alerta, animated: true, completion: nil)
                self.LimpiarInfo(paisText: "Pais Desconocido", img: "map.png")
            }
            if cualError.localizedDescription == "The Internet connection appears to be offline." {
                //Alerta
                let alerta = UIAlertController(title: "Conexion de Internet", message: "Verifique que tenga internet e intentelo de nuevo", preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                alerta.addAction(actionOk)
                self.present(alerta, animated: true, completion: nil)
                self.LimpiarInfo(paisText: "Conexion de Internet", img: "noInternet.jpg")
            }
            
        }
        
    }
    
    func actualizarStatus(status: StatusModel) {
        
        DispatchQueue.main.async {
            //Cambiar Bandera
            
            self.ReescribirLabels()
            
            var url:NSURL? = NSURL(string: String(status.bandera))
            var data:NSData? = NSData(contentsOf : url! as URL)
            var image = UIImage(data : data! as Data)
            self.imgBandera.image = image
            
            self.casosLabel.text = String(status.casos)
            self.muertesLabel.text = String(status.muertes)
            self.recuperadosLabel.text = String(status.recuperados)
            
            self.casostLabel.text = String(status.casosHoy)
            self.muertestLabel.text = String(status.muertesHoy)
            self.recuperadostLabel.text = String(status.recuperadosHoy)
            
        }
        
        
    }
}

