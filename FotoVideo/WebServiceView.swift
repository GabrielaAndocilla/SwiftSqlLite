//
//  WebServiceView.swift
//  FotoVideo
//
//  Created by GABRIELA on 12/10/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit
import WebKit

class WebServiceView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    let services = WebServ()
    
    var Canciones: NSArray = []
    var CancionesCurrent: NSArray = []
    
    private var webView = WKWebView()
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        setCanciones()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCanciones()
        setsearchBar()
        /*services.obtener(urlc: "/videos") { (array_repuesta) in DispatchQueue.main.async {
            
            let a = array_repuesta?.object(at: 0) as! NSDictionary
            print(array_repuesta)

            if let nom = a.object(forKey: "Nombre") as! String?{
                print("NOMBRE",nom)
                print(a)
            }
            
            }}*/

       /* let datosenviar=["nombre":"App","descripcion":"skjdn","URL":"www"] as NSMutableDictionary
        
        services.enviar(urlc: "/videos/nuevo", datosenviados: datosenviar) { (array_repuesta) in DispatchQueue.main.async {
            
                let diccionarioDatos = array_repuesta
            
                print(diccionarioDatos)
            }}
        */
    
        // Do any additional setup after loading the view.
    }
    
    private func setCanciones(){
        
        services.obtener(urlc: "/videos") { (array_repuesta) in DispatchQueue.main.async {
            self.Canciones = (array_repuesta as! NSArray)
            self.CancionesCurrent = (array_repuesta as! NSArray)
            print("FF")
            self.TableView.reloadData()
         }}
    }
    
    private func setsearchBar(){
        searchbar.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("F")
        return CancionesCurrent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else{
            return UITableViewCell()
        }
        let can = self.CancionesCurrent.object(at: indexPath.row) as! NSDictionary
        print("CANNNN\(can)")
        cell.nom.text = can.object(forKey: "Nombre") as! String?
        cell.desc.text = can.object(forKey: "descripcion") as! String?
        cell.Img.image = UIImage(named: "MusicaImage")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let can = self.CancionesCurrent.object(at: indexPath.row) as! NSDictionary
        
        //WEB VIew
        
        let webViewPref = WKPreferences()
        webViewPref.javaScriptEnabled = true
        webViewPref.javaScriptCanOpenWindowsAutomatically = true
        
        let webViewConf = WKWebViewConfiguration()
        webViewConf.preferences = webViewPref
        webView = WKWebView(frame: view.frame, configuration: webViewConf)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        
        load(url: (can.object(forKey: "url")as! String?)!)
        print(can)
    }
    
    private func load(url: String) {
        webView.load(URLRequest(url:URL(string: url)!))
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String ){
        guard !searchText.isEmpty else {
            CancionesCurrent = Canciones
            self.TableView.reloadData()

            return}
        
        CancionesCurrent = Canciones.filter({ cancion -> Bool  in
           
            return ((cancion as AnyObject).object(forKey: "Nombre") as! String).contains(searchText)
            
        }) as NSArray
        self.TableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int ){
        
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

