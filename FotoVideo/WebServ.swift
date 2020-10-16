//
//  WebServ.swift
//  FotoVideo
//
//  Created by GABRIELA on 12/10/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit

class WebServ: NSObject {
    let url1 = "http://192.168.100.12:8000/api"
    
    func enviar(urlc:String, datosenviados:NSMutableDictionary,comletionHandler: @escaping (NSArray?) -> Void){
        let url = URL(string: "\(url1)\(urlc)")!
        print("\(url1)\(urlc)")
        var request = URLRequest(url:url)
        
        request.setValue("aplication/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("aplication/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        
        request.httpBody = try! JSONSerialization.data(withJSONObject :datosenviados)
        print("request\(request)")
        let task = URLSession.shared.dataTask(with: request){ datos_Recibidos, respuesta, error
            in
            if error != nil{
                print(error)
                comletionHandler(nil)
                
                
            }else{
                do{
                    print("datos recibidos\(String(describing: String(data:datos_Recibidos!,encoding: .utf8 )))  - datos enviados: \(datosenviados)")
                    
                    if let array = try JSONSerialization.jsonObject(with: datos_Recibidos!) as? NSArray{
                        
                        comletionHandler(array)
                        
                    }
                    
                    
                }catch let parseError{
                    print("servidor php \(String(data:datos_Recibidos!,encoding: .utf8))\(parseError)")
                    comletionHandler(nil)
                    
                }
                
            }
            
        }
        task.resume()
        
    }
    func obtener(urlc:String,comletionHandler: @escaping (NSArray?) -> Void){
       
        var request = URLRequest(url: URL(string: "http://192.168.100.12:8000/api/videos")!,timeoutInterval: Double.infinity)
        request.addValue("aplication/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("aplication/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){datos_Recibidos,  respuesta, error
            in
            if error != nil{
                comletionHandler(nil)
            }else{
                do{
                    if let array = try JSONSerialization.jsonObject(with: datos_Recibidos!) as? NSArray{
                        comletionHandler(array)
                        
                    }
                    
                }catch let parseError{
                    comletionHandler(nil)
                    
                }
                
            }
            
        }
        task.resume()
        
    }
}
