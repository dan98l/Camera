//
//  ViewController.swift
//  Camera
//
//  Created by Daniil G on 30.01.2021.
//

import UIKit

enum Media {
    case camera
    case photo
}

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func selectButton(_ sender: Any) {
        self.media = .photo
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func takeButton(_ sender: Any) {
        self.media = .camera
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    private var media: Media = .camera
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            
            switch media {
            case .camera:
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
            default: break
            }
            picker.dismiss(animated: true, completion: nil)
        } else {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveError() {
        print("saveError")
    }
}

