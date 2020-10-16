//
//  SaveSongViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 15/10/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit

class SaveSongViewController: UIViewController {

   
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var Url: UITextField!
    @IBOutlet weak var descripcion: UITextField!
    let services = WebServ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Save(_ sender: Any) {
        if( !nombre.text!.isEmpty && !Url.text!.isEmpty && !descripcion.text!.isEmpty ){
            let datosenviar=["nombre":nombre.text!,"descripcion":descripcion.text!,"URL":Url.text!] as NSMutableDictionary
            
             services.enviar(urlc: "/videos/nuevo", datosenviados: datosenviar) { (array_repuesta) in DispatchQueue.main.async {
             
                
                }}
            nombre.text = ""
            Url.text = ""
            descripcion.text = ""
            self.navigationController?.popViewController(animated: true)

        } else{
            let alert = UIAlertController(title: "Error", message: "Revise que sus campos esten completos", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            nombre.text = ""
            Url.text = ""
            descripcion.text = ""
        }
   
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
