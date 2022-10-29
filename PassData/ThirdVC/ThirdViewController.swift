//
//  ThirdViewController.swift
//  PassData
//
//  Created by ashraf on 22/10/2022.
//

import UIKit

struct ageData {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class ThirdViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var getAgeButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var data = [ageData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func getAgePressed(_ sender: UIButton) {
        nameTextField.endEditing(true)
    }
}

extension ThirdViewController: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Provide a name..."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameLabel.text = textField.text
        if let name = textField.text {
            getAge(for: name){
                self.addData($0.name, $0.age)
                self.tableView.reloadData()
            }
        }
        textField.text = ""
    }
    
    func addData(_ name: String, _ age: Int){
        let ageDataItem = ageData(name: name, age: age)
        data.append(ageDataItem)
    }
    
    func getAge (for name: String, completed: @escaping (ageJSON)->()) {
        if let url = URL(string: "https://api.agify.io/?name=" + name){
            URLSession.shared.dataTask(with: url){ (data, urlResponse, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let returned = data {
                    let decodedData = try? JSONDecoder().decode(ageJSON.self, from: returned)
                    DispatchQueue.main.async {
                        if let age = decodedData?.age {
                            //update label
                            self.ageLabel.text = String(age)
                            
                            //add data to table
                            //self.addData(decodedData?.name!, age)
                            completed(decodedData!)
                        }
                    }
                }
            }.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data!.count
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cellData = self.data[indexPath.row]
            cell.textLabel?.text = cellData.name
            cell.detailTextLabel?.text = String(cellData.age)
        
        return cell
    }
}
