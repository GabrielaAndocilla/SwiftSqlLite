//
//  ViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 6/10/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func GoFoto(_ sender: Any) {
        let callView = UIStoryboard(name: "Main", bundle: nil)
        let viewGAB = callView.instantiateViewController(withIdentifier: "PhotoVC")
        navigationController?.pushViewController(viewGAB, animated: true)
    }
    
}

