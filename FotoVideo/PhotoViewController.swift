//
//  PhotoViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 7/10/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let image:UIImagePickerController = UIImagePickerController()
    
    
    @IBOutlet weak var Imagen: UIImageView!
    
    @IBAction func OpenGaleria(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            image.allowsEditing = false
            image.sourceType = .photoLibrary
            image.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]

            present(image, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func TakeVideo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            image.allowsEditing = true
            image.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
            image.sourceType = .camera
            image.cameraCaptureMode = .photo
            present(image, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeMovie as NSString as String)
        {
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            if image.sourceType == .camera{

                UISaveVideoAtPathToSavedPhotosAlbum((url?.path)!,self,nil,nil)
            }
            image.dismiss(animated: true, completion: nil)

            
            let player = AVPlayer(url: url!) // url can be remote or local
            
            let playerViewController = AVPlayerViewController()
            // creating a player view controller
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                
                playerViewController.player!.play()
            }

        }else{
            if let imageSelecc:UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                Imagen.image = imageSelecc
                if image.sourceType == .camera{
                    UIImageWriteToSavedPhotosAlbum(imageSelecc,nil, nil,nil)
                    
                }
                image.dismiss(animated: true, completion: nil)

            }
            
        }
        

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        image.delegate = self
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
