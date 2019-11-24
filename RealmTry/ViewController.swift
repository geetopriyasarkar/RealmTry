//
//  ViewController.swift
//  RealmTry
//
//  Created by Manmohan on 14/11/19.
//  Copyright © 2019 Geet. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var provinceText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var searchFor: UITextField!
    @IBOutlet weak var searchResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func saveBtn(_ sender: UIButton) {
        // Get Values From TextFields
        let cityName = self.cityText!.text
        let provinceName = self.provinceText!.text
        let countrtyName = self.countryText!.text
        
        //validate inpuet Values
        if ( cityName?.isEmpty )! {
            self.cityText.layer.borderColor = UIColor.red.cgColor
            return
        } else {
            self.cityText.layer.borderColor = UIColor.black.cgColor
        }
        if ( provinceName?.isEmpty )! {
            self.provinceText.layer.borderColor = UIColor.red.cgColor
            return
        } else {
            self.provinceText.layer.borderColor = UIColor.black.cgColor
        }
        if ( cityName?.isEmpty )! {
            self.countryText.layer.borderColor = UIColor.red.cgColor
            return
        } else {
            self.countryText.layer.borderColor = UIColor.black.cgColor
        }
        
        let newCity = CityLib()
        newCity.setValue(self.cityText!.text, forKey: "cityName")
        newCity.setValue(self.provinceText!.text, forKey: "provinceName")
        newCity.setValue(self.countryText!.text, forKey: "countryName")
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(newCity)
                print("Added \(newCity.CityName) to Realm DataBase")
                
                self.cityText!.text = ""
                self.provinceText!.text = ""
                self.countryText!.text = ""
            }
        } catch {
            print(error)
        }
        
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier:"TableViewController") as! TableViewController
       
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func showAllCities(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier:"TableViewController") as! TableViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        let searchString = self.searchFor?.text
        let realm = try! Realm()
        var outputStr = ""
        
        //let predicate = NSPredicate(format: "cityName contains[c] %@", searchString!)
        let predicate = NSPredicate(format: "CityName CONTAINS %@", searchString!) // contains case sensitive
        //let predicate = NSPredicate(format: "cityName LIKE[cd] %@", searchString!) // like case insensitive
        //let predicate = NSPredicate(format: "cityName ==[cd] %@", searchString!) // equal case insensitive
       // let predicate = NSPredicate(format: "cityName == %@", searchString!) // equal case sensitive
        
        
        
        
        let result = realm.objects(CityLib.self).filter(predicate)
        
        if result.count > 0 {
            for oneline in result {
                let oneCity = (oneline as AnyObject).value(forKey: "CityName") as! String
                let oneProvince = (oneline as AnyObject).value(forKey: "ProvinceName") as! String
                let oneCountry = (oneline as AnyObject).value(forKey: "CountryName") as! String
                outputStr += oneCity + " " + oneProvince + " " + oneCountry + "\n "
            }
        } else {
            outputStr = "No match Found !"
        }
        self.searchResult?.text = outputStr
    }
    
    
}

