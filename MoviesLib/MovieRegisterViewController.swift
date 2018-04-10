//
//  MovieRegisterViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 09/04/18.
//  Copyright © 2018 EricBrito. All rights reserved.
//

import UIKit

class MovieRegisterViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lbCategories: UILabel!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var btAddUpdate: UIButton!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if movie != nil {
            tfTitle.text = movie.title
//            lbCategories.text =
            tfRating.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tvSummary.text = movie.summary
            btAddUpdate.setTitle("Atualizar", for: .normal)
        } else {
            btAddUpdate.setTitle("Cadastrar", for: .normal)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func close(_ sender: UIButton? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addUpdateMovie(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        movie.title = tfTitle.text
//            lbCategories.text =
        movie.rating = Double(tfRating.text!)!
        movie.duration = tfDuration.text
        movie.summary = tvSummary.text
        do {
            try context.save()
            close()
        } catch {
            print(error.localizedDescription)
        }
    }
}
