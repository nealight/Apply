//
//  CompanyDetailsViewController.swift
//  Apply
//
//  Created by Yi Xu on 11/8/20.
//  Copyright © 2020 Yi Xu. All rights reserved.
//

import UIKit

class CompanyDetailsViewController: UIViewController {
    
    let companiesModel = CompaniesModel.shared
    
    @IBOutlet var companyLogoImage: UIImageView!
    @IBOutlet var companyTitle: UINavigationItem!
    @IBOutlet var companyNotes: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        // Configure the cell...
        
        guard let selectedIndex = companiesModel.selectedIndex else {
            return
        }
        
        let name = companiesModel.company(at: selectedIndex)?.getName()
        let notes = companiesModel.company(at: selectedIndex)?.getNote()
        
        companyTitle.title = name
        companyNotes.text = notes
        
        let image = companiesModel.company(at: selectedIndex)?.getImage()
        
        if let imageName = image {
            if imageName != "Default" {
                
                let manager = FileManager.default
                let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
                
                
                let imagePath = url!.appendingPathComponent(imageName)
                
                print(imagePath)
                
                do {
                    companyLogoImage.image = UIImage(data: try Data(contentsOf: imagePath))
                    
                } catch {
                    
                }
                
            }
        }
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
