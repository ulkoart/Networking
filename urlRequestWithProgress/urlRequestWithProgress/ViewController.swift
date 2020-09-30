//
//  ViewController.swift
//  urlRequestWithProgress
//
//  Created by user on 30.09.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressLabel.text = ""
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "No image", message: "Sorry :-(", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        
        downloadButton.isEnabled = false
        self.progressLabel.text = "Начало загрузки"
        
        NetworkManagerImp.onProgress = {(progress) in
            DispatchQueue.main.async {
                let intProgress = Int(progress * 100)
                self.progressLabel.text = "\(intProgress)%"
            }
        }
        
        NetworkManagerImp.downloadRandomBigImage { (image) in
            guard let image = image else {
                self.showAlert()
                self.downloadButton.isEnabled = true
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.downloadButton.isEnabled = true
            }
        }
    }
}

