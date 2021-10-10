//
//  ViewController.swift
//  RegisterBloodGlucose
//
//  Created by Igor Samoel da Silva on 08/10/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
 
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var records: [Registry] = []
    let suffix = " mg/dL"
    
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: view.frame)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    
    lazy var inputGlucoseLevel: UITextField = {
        let input = UITextField(frame: view.frame)
        input.keyboardType = .numberPad
        input.placeholder = "Enter your blood glucose level"
        input.delegate = self
        return input
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(frame: view.frame)
        button.configuration = .plain()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(saveBloodGlucoseLevel(_:)), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var bloodGlucoseLevel: UILabel = {
        let outputText = UILabel()
        outputText.textAlignment = NSTextAlignment.center
        outputText.font = .systemFont(ofSize: 50)
        outputText.text = ""
        outputText.textColor = .black
        return outputText
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        view.addSubview(tableView)
        view.addSubview(inputGlucoseLevel)
        view.addSubview(saveButton)
        view.addSubview(bloodGlucoseLevel)
        setupConstraints()
        self.getRecords()
    }
    
    
    
    
    @objc func saveBloodGlucoseLevel(_ sender: UIButton!){
        if let result = self.inputGlucoseLevel.text {
            self.createRegistry(level: result)
            bloodGlucoseLevel.text = result + suffix
            getRecords()
        }
    }
    
    
    

    
    
    
    private func getRecords(){
        do{
            self.records = try context.fetch(Registry.fetchRequest())
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }catch{
            let alert = UIAlertController(title: "Load error", message: "it was not possible to load blood glucose records!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    private func createRegistry(level: String){
        let item = Registry(context: context)
        item.id = UUID()
        item.level = Int32(level) ?? 0
        do{
            try context.save()
        }catch{
            let alert = UIAlertController(title: "Save error", message: "it was not possible to save blood glucose!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    private func deleteRegistry(registry: Registry){
        
        context.delete(registry)
        do{
           try context.save()
        }catch{
            print("Erro")
        }
        
    }
    
    
    
    
    
    
    
    private func setupConstraints(){
        self.inputGlucoseLevel.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.bloodGlucoseLevel.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let contraints = [
            //Input Glucose Level
            self.inputGlucoseLevel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.inputGlucoseLevel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250),
            
            //Save Button
            self.saveButton.centerXAnchor.constraint(equalTo: self.inputGlucoseLevel.centerXAnchor),
            self.saveButton.centerYAnchor.constraint(equalTo: self.inputGlucoseLevel.centerYAnchor, constant: 50),
            
            //Blood Glucose Result View
            self.bloodGlucoseLevel.centerXAnchor.constraint(equalTo: self.inputGlucoseLevel.centerXAnchor),
            self.bloodGlucoseLevel.centerYAnchor.constraint(equalTo: self.inputGlucoseLevel.centerYAnchor, constant: -50),
            self.bloodGlucoseLevel.widthAnchor.constraint(equalTo: self.inputGlucoseLevel.widthAnchor, constant: 50),
            self.bloodGlucoseLevel.heightAnchor.constraint(equalTo: self.inputGlucoseLevel.heightAnchor, constant: 50),
            
            
            
            //Table View
            

            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
            
        ]
        NSLayoutConstraint.activate(contraints)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = records[indexPath.row].level.description + suffix
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.bloodGlucoseLevel.text = records[indexPath.row].level.description + suffix
        self.inputGlucoseLevel.text = records[indexPath.row].level.description
    }
    
    
    
}
