//
//  ViewController.swift
//  ShoppinhList
//
//  Created by Helder on 28/06/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        
        return cell
    }
    
    @objc func addListItem(){
        let ac = UIAlertController(title: "Enter an item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default){
            [weak self] action in
            if let textFieldValue = ac.textFields?[0].text{
                self?.shoppingItems.insert(textFieldValue, at: 0)
                
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        })
        present(ac, animated: true)
    }
    
    @objc func clear(){
        let ac = UIAlertController(title: "Are you sure you want to clear your list?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .destructive){
            [weak self] action in
            var indexPaths: [IndexPath] = []
            for i in 0..<(self?.shoppingItems.count)!{
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            
            self?.shoppingItems.removeAll()
            
            self?.tableView.deleteRows(at: indexPaths, with: .automatic)
        })
        ac.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ac, animated: true)
    }


}

