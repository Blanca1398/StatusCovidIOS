//
//  ViewController.swift
//  StatusCovid
//
//  Created by Blanca Cordova on 08/12/20.
//  Copyright © 2020 Blanca Cordova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var paisLabel: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LimpiarInfo(paisText: "Busca el pais",img: "covid3.png")

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
    
}
