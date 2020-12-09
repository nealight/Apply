//
//  CompaniesModel.swift
//  Apply
//
//  Created by Yi Xu on 11/8/20.
//  Copyright © 2020 Yi Xu. All rights reserved.
//

import Foundation
import RealmSwift


class CompaniesModel: NSObject {

    private var companies: Array<Company> = Array<Company>()
    private var archivedCompanies: Array<Company> = Array<Company>()
    private var currentIndex: Int? = nil
    public var selectedIndex: Int? = nil
    // Swift Singleton pattern
    static let shared = CompaniesModel()
    
    private var filepath: String
    
    let realm = try! Realm()
    
    override init() {

        // Cite lecture codes
        
        
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        
        filepath = url!.appendingPathComponent("companies.txt").path
        print("filepath=\(filepath)")
        

        
        if manager.fileExists(atPath: filepath) {
            do {
                // Read the file and load data
                let data = try String(contentsOfFile: filepath, encoding: .utf8)
                
                let myStrings = data.components(separatedBy: .newlines)
                for line in myStrings {
//                    if line.contains("~") {
//                        let attributes = line.split(separator: "~")
//                        let company = Company(name: String(attributes[0]), note: String(attributes[1]), image: String(attributes[2]))
//                        companies.append(company)
//                    }
                    
                    if line.contains("|") {
                        let attributes = line.split(separator: "|")
                        let company = Company(name: String(attributes[0]), note: String(attributes[1]), image: String(attributes[2]))
                        archivedCompanies.append(company)
                    }
                }
            } catch {
                print("could not read file")
            }
        } else {
            companies.append(Company(name: "Zillow", note: "Blue House", image:"Default"))
            
        }
        
        super.init()
        
        render()
        
        
    }
    
    func save() {
        var dataString = String()
        
        for item in archivedCompanies {
            let desc = item.archivedDescription
            dataString.append(desc)
        }
        
        do  {
            try dataString.write(toFile: filepath, atomically: true, encoding: .utf8)
            
        } catch {
            print("could not save to file")
        }
        
        try! realm.write {
            realm.delete(realm.objects(Company.self))
            for item in companies {
                realm.add(item)
            }
        }
    }
    
    func render() {
        let saved_companies = realm.objects(Company.self)
        for company in saved_companies {
            companies.append(company)
        }
    }
    
    

    
    func numberOfCompanies() -> Int {
        return companies.count
    }
    
    func numberOfArchivedCompanies() -> Int {
        return archivedCompanies.count
    }
    
    func insert(name: String, note: String, image: String) {
        if numberOfCompanies() == 0 {
            currentIndex = 0
        }
        companies.append(Company(name: name, note: note, image: image))
        
        
        save()
    }
    
    func currentCompany() -> Company? {
        guard let current = currentIndex else {
            return nil
        }
        return companies[current]
    }
    
    func company(at index: Int) -> Company? {
        if index < 0 || index >= numberOfCompanies() {
            return nil
        }
        
        currentIndex = index
        return companies[index]
    }
    
    func archivedCompany(at index: Int) -> Company? {
        if index < 0 || index >= numberOfArchivedCompanies() {
            return nil
        }
        
        return archivedCompanies[index]
    }
    
    func removeCompany(at index: Int) {
        if index < 0 || index >= numberOfCompanies() {
            return
        }
        
        guard let current = currentIndex else {
            return
        }
        
        
        if index < current || (index == current && current == numberOfCompanies() - 1) {
            currentIndex = current - 1
        }
        
        archivedCompanies.append((company(at: index) ?? Company(name: "Error", note: "Error Company", image: "")).copy())
        companies.remove(at: index)
        
        if numberOfCompanies() == 0 {
            currentIndex = nil
        }
        
        print(archivedCompanies)
        save()
    }
    
    // Cite: lecture code
//    func save() {
//        var dataString = String()
//        for item in companies {
//            let desc = item.desc
//            dataString.append(desc)
//        }
//
//        for item in archivedCompanies {
//            let desc = item.archivedDescription
//            dataString.append(desc)
//        }
//
//        do  {
//            try dataString.write(toFile: filepath, atomically: true, encoding: .utf8)
//
//        } catch {
//            print("could not save to file")
//        }
//    }
    
    
}
