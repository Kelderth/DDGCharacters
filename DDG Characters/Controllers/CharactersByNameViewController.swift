//
//  CharactersByNameViewControllerViewController.swift
//  DDG Characters
//
//  Created by MCS on 12/18/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class CharactersByNameViewController: UIViewController {

    //MARK: Properties
    let DDGRequest: DDGApiService = DDGApiService()
    var characterSource: [CharacterSource] = [CharacterSource]()
    var dataManager = DDGPersistence()
    
    //MARK: Properties.
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupApiRequest()
    }

    func setupApiRequest() {
        characterSource = dataManager.readData()
        
        if characterSource.count == 0 {
            DDGRequest.serviceRequest() {
                self.characterSource = self.dataManager.readData()
                self.tableView.reloadData()
            }
        }
        
    }

}

//MARK: TableView Delegate and DataSource.
extension CharactersByNameViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CharacterNameCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        let item = characterSource[indexPath.row]
        cell.setup(character: item)
        
        return cell
    }
    
    
}
