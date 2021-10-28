//
//  IdentifyNewsVC.swift
//  Newly
//
//  Created by Ikmal Azman on 26/10/2021.
//

import UIKit
import Vision
import VisionKit

// https://www.raulferrergarcia.com/en/develop-your-own-ocr-on-ios-13-with-visionkit/
final class IdentifyNewsVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var classifyLabel: UILabel!
    @IBOutlet weak var insertedTextView: UITextView!
    @IBOutlet weak var doneBtnProperties: UIBarButtonItem!
    
    //MARK:- Variables
    private let imagePicker = UIImagePickerController()
    private let documentPicker = VNDocumentCameraViewController()
    private let presenter = IdentifyNewsPresenter()
    private let textAnalyst = TextAnalysisInteractor()
    private var sourceType : UIImagePickerController.SourceType?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    //MARK:- Actions
    @IBAction func doneBtnTap(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func optionsButtonTap(_ sender: UIButton) {
        let title = sender.currentTitle!
        print(title)
        
        configureSelection(source: title)
    }
}

//MARK:- UIImagePickerControllerDelegate
extension IdentifyNewsVC : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Could not get image from user")
        }
        print(selectedImage.size)
        
        guard let imageData = selectedImage.pngData() else {
            fatalError("Could not convert UIImage to Data")
        }
        //MARK:- TODO : Translate image to text here
        textAnalyst.processImageToText(imageData: imageData) { textResults in
            DispatchQueue.main.async {
                self.insertedTextView.text = textResults
            }
        }
        //MARK:- TODO : Predict Translated image
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

//MARK:- VNDocumentCameraViewControllerDelegate
extension IdentifyNewsVC : VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        // Request image at selected page
        let scanned = scan.imageOfPage(at: 0)
        let imageData = scanned.pngData()!
        textAnalyst.processImageToText(imageData: imageData) { textResults in
            DispatchQueue.main.async {
                self.insertedTextView.text = textResults
            }
        }
        documentPicker.dismiss(animated: true, completion: nil)
    }
}

//MARK:- IdentifyNewsPresenter Delegate
extension IdentifyNewsVC : IdentifyNewsPresenterDelegate {}
extension IdentifyNewsVC : UINavigationControllerDelegate {}

//MARK:- Private Methods
extension IdentifyNewsVC {
    
    private func renderView() {
        classifyLabel.isHidden = true
        documentPicker.delegate = self
        imagePicker.delegate = self
        presenter.setViewDelegate(delegate: self)
    }
    
    private func configureSelection(source : String) {
        if source == "Camera" {
            imagePicker.sourceType =  .photoLibrary
            present(documentPicker, animated: true, completion: nil)
        } else if source == "Photos" {
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

