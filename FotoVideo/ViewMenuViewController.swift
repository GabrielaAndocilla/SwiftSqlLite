//
//  ViewMenuViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 3/11/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit
enum MenuType: Int {
    case home
    case local
    case op3
}
class ViewMenuViewController: UITableViewController {

    var didtap: ((MenuType)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let mType = MenuType(rawValue: indexPath.row) else {return }
        dismiss(animated: true) {[weak self] in
            print("Dismiss", mType)
            self?.didtap?(mType)
        }
    }

}
