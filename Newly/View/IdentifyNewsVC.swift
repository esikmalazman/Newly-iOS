//
//  IdentifyNewsVC.swift
//  Newly
//
//  Created by Ikmal Azman on 26/10/2021.
//

import UIKit
import VisionKit

protocol IdentifyNewsVCDelegate : AnyObject {
    func addNewHistory(view : IdentifyNewsVC ,_ historyData : History)
}

// https://www.raulferrergarcia.com/en/develop-your-own-ocr-on-ios-13-with-visionkit/
final class IdentifyNewsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var classifyLabel: UILabel!
    @IBOutlet weak var insertedTextView: UITextView!
    @IBOutlet weak var doneBtnProperties: UIBarButtonItem!
    @IBOutlet weak var classifyBtn: UIButton!
    @IBOutlet weak var photosBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cameraBtn: UIButton!
    
    private let imagePicker = UIImagePickerController()
    private let documentPicker = VNDocumentCameraViewController()
    private let presenter = IdentifyNewsPresenter()
    static let segueIdentifier = "goToNewsVC"
    
    weak var delegate : IdentifyNewsVCDelegate?
    private var sourceType : UIImagePickerController.SourceType?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    //MARK: - Actions
    @IBAction func doneBtnTap(_ sender: UIBarButtonItem) {
        presenter.didCompleteClassifyText(category: classifyLabel.text, fullText: insertedTextView.text)
    }
    
    @IBAction func optionsButton(_ sender: UIButton) {
        let title = sender.titleLabel?.text
        presenter.didSelectOptions(source: title)
    }

    
    @IBAction func classifyButtonTap(_ sender: UIButton) {
        let textFromImage = insertedTextView.text!
        presenter.makePredictions(text: textFromImage)
        configureContentView(with: textFromImage)
    }
    
    static func instantiate() -> IdentifyNewsVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IdentifyNewsVC") as! IdentifyNewsVC
    }
}

//MARK: - UIImagePickerControllerDelegate
extension IdentifyNewsVC : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Could not get image from user")
        }
        debugPrint(selectedImage.size)
        guard let imageData = selectedImage.pngData() else {
            fatalError("Could not convert UIImage to Data")
        }
        // Translate image to text
        presenter.analyseTextIn(image: imageData)
    }
}

//MARK: - VNDocumentCameraViewControllerDelegate
extension IdentifyNewsVC : VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        // Request image at selected page
        let scanned = scan.imageOfPage(at: 0)
        let imageData = scanned.pngData()!
        presenter.analyseTextIn(image: imageData)
    }
}
//MARK: - IdentifyNewsVC
extension IdentifyNewsVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .secondaryBlack
    }
}

//MARK: - IdentifyNewsPresenter Delegate
extension IdentifyNewsVC : IdentifyNewsPresenterDelegate {
    func presentOptions(button: String) {
        configureSelection(source: button)
    }
    
    func presentHistory(data: History) {
        delegate?.addNewHistory(view: self, data)
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentText(results: String) {
        configureContentView(with: results)
        imagePicker.dismiss(animated: true, completion: nil)
        documentPicker.dismiss(animated: true, completion: nil)
    }
    
    func presentPredictions(_ text: String) {
        doneBtnProperties.title = "Done"
        contentView.backgroundColor = .primaryPurple
        insertedTextView.textColor = .white
        classifyLabel.isHidden = false
        classifyLabel.text = text
    }
}

extension IdentifyNewsVC : UINavigationControllerDelegate {}

//MARK: - Private Methods
extension IdentifyNewsVC {
    
    private func renderView() {
        setInitialOutletsProperties()
        addToolbarForTextView()
        
        insertedTextView.delegate = self
        documentPicker.delegate = self
        imagePicker.delegate = self
        presenter.setViewDelegate(delegate: self)
    }
    
    private  func setInitialOutletsProperties() {
        classifyBtn.layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        insertedTextView.layer.cornerRadius = 15
        
        navigationController?.navigationBar.tintColor = .primaryPurple
        photosBtn.tintColor = .primaryPurple
        cameraBtn.tintColor = .primaryPurple
        insertedTextView.textColor = .lightGray
        classifyBtn.tintColor = .clear
        
        classifyLabel.isHidden = true
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.primaryPurple.cgColor
        // Hide done button
        doneBtnProperties.title = ""
    }
    
    private func configureSelection(source : String) {
        if source == "Camera" {
            imagePicker.sourceType =  .photoLibrary
            present(documentPicker, animated: true, completion: nil)
        } else if source == "Photos" {
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func addToolbarForTextView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone(button:)))
        toolbar.setItems([button], animated: true)
        insertedTextView.inputAccessoryView = toolbar
    }
    
    @objc private func didTapDone(button : UIBarButtonItem) {
        insertedTextView.resignFirstResponder()
        classifyBtn.tintColor = .white
        classifyBtn.backgroundColor = .primaryPurple
    }
    
    private func configureContentView(with textResults : String) {
        classifyBtn.tintColor = .white
        classifyLabel.textColor = .white
        classifyBtn.backgroundColor = .primaryPurple
        cameraBtn.tintColor = .clear
        photosBtn.tintColor = .clear
        
        insertedTextView.text = textResults
    }
}

