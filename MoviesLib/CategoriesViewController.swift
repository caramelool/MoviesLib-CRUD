//
//  CategoriesViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 09/04/18.
//  Copyright © 2018 EricBrito. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    var categories: [Category] = []
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Definindo os valores das propriedades da lavel
        label.text = "Sem categorias"
        label.textAlignment = .center
        label.textColor = .black
        
        // Do any additional setup after loading the view.
        loadCategories()
    }
    
    func loadCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            categories = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

    func showAlert(_ category: Category? = nil) {
        let title = category == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: "\(title) categoria", message: "Preenchar abaixo o nome da categoria", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome da categoria"
            textField.text = category?.name ?? ""
        }
        
        let addEditAction = UIAlertAction(title: title, style: .default) { (action) in
            let category = category ?? Category(context: self.context)
            category.name = alert.textFields!.first!.text
            
            try? self.context.save()
            self.loadCategories()
        }
        alert.addAction(addEditAction)
        
        let closeAction = UIAlertAction(title: "Fechar", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(closeAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - IBAction

    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        showAlert()
    }

}

extension CategoriesViewController: NSFetchedResultsControllerDelegate {
    override func didChangeValue(forKey key: String) {
        tableView.reloadData()
    }
}

// MARK: - Table view delegate and data source
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Método que define a quantidade de seções de uma tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Método que define a quantidade de células para cada seção de uma tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = categories.count
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = category.name
        if let moveCategories = movie?.categories {
            cell.accessoryType = moveCategories.contains(category) ? .checkmark : .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            movie?.addToCategories(category)
        } else {
            cell.accessoryType = .none
            movie?.removeFromCategories(category)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let category = self.categories[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Deletar") { (action, indexPath) in
            self.context.delete(category)
            try? self.context.save()
            self.categories.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            self.showAlert(category)
            tableView.setEditing(false, animated: true)
        }
        editAction.backgroundColor = .blue
        
        return [deleteAction, editAction]
    }
}

