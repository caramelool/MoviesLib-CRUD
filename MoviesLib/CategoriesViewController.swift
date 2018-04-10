//
//  CategoriesViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 09/04/18.
//  Copyright © 2018 EricBrito. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction

    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
    }
}

//extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
//    // MARK: - Table view data source
//    
//    //Método que define a quantidade de seções de uma tableView
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    //Método que define a quantidade de células para cada seção de uma tableView
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return nil
//    }
//
//}

