//
//  MenuViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 3/11/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let transition = SlideInTrans()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickMn(_ sender: Any) {
        //let callView = UIStoryboard(name: "Main", bundle: nil)
        guard let menu = storyboard?.instantiateViewController(withIdentifier: "MenuViewViewControler") as? ViewMenuViewController else{return}
        menu.didtap = { menuType in
            self.transitionToNew(menuType)
            
        }
        menu.modalPresentationStyle = .overCurrentContext
        menu.transitioningDelegate = self
        present(menu, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType){
    
        let view = UIView()
        view.backgroundColor = .yellow
        view.frame = self.view.bounds
        self.view.addSubview(view)
    }

}

extension MenuViewController: UIViewControllerTransitioningDelegate{
 

    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        transition.isPresenting = false
        return transition
        
    }
}
