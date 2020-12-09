//
//  AddEditCompanyViewController.swift
//  Apply
//
//  Created by Yi Xu on 11/8/20.
//  Copyright © 2020 Yi Xu. All rights reserved.
//

import UIKit

class AddEditCompanyViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let companiesModel = CompaniesModel.shared
    
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var companyName: UITextField!
    @IBOutlet var companyNotes: UITextView!
    @IBOutlet var addCompanyImageButton: UIButton!
    
    private var companyImage: String?
    
    func enableSavedButton() {
        let name = companyName.text ?? ""
        let note = companyNotes.text ?? ""
        saveButton.isEnabled = name.count > 0 && note.count > 0
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyName.delegate = self
        companyNotes.delegate = self
        
        saveButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func companyNameChanged(_ sender: UITextField) {
        enableSavedButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        companyName.resignFirstResponder()
        companyNotes.becomeFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            companyNotes.resignFirstResponder()
            return false
        }
        
        enableSavedButton()
        return true
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        companyName.text = ""
        companyNotes.text = ""
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        companiesModel.insert(name: companyName.text ?? "", note: companyNotes.text ?? "", image: companyImage ?? "Default")
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: UIButton) {
        // Cite: https://www.hackingwithswift.com/read/10/4/importing-photos-with-uiimagepickercontroller
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Cite: https://www.hackingwithswift.com/read/10/4/importing-photos-with-uiimagepickercontroller
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        let imageName = UUID().uuidString
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
               
               
        let imagePath = url!.appendingPathComponent(imageName)
        
        if let jpedData = image.jpegData(compressionQuality: 0.99) {
            try? jpedData.write(to: imagePath)
            
        }
        
        companyImage = imageName
        
        dismiss(animated: true)
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
