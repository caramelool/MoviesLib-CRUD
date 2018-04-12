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
    let posterDefault = UIImage(named: "moviePoster")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if movie != nil {
            tfTitle.text = movie.title
            tfRating.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tvSummary.text = movie.summary
            ivPoster.image = movie.poster ?? posterDefault
            btAddUpdate.setTitle("Atualizar", for: .normal)
        } else {
            btAddUpdate.setTitle("Cadastrar", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (movie == nil) {
            movie = Movie(context: context)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var categoriesName = ""
        if let categories = movie?.categories {
            categoriesName = categories
                .map({($0 as! Category).name!})
                .joined(separator: " | ")
        }
        lbCategories.text = categoriesName.isEmpty ? "Categorias" : categoriesName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CategoriesViewController {
            vc.movie = movie
        }
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func close(_ sender: UIButton? = nil) {
        if (movie?.title == nil) {
            context.delete(movie)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPoster(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde você deseja escolher o poster?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Album de fotos", style: .default) { (action) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let removerPosterAction = UIAlertAction(title: "Remover poster", style: .default) { (action) in
            self.ivPoster.image = self.posterDefault
        }
        alert.addAction(removerPosterAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addUpdateMovie(_ sender: UIButton) {
        movie.title = tfTitle.text
        movie.poster = ivPoster.image == posterDefault ? nil : ivPoster.image
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

extension MovieRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let size = CGSize(width: 640, height: 480)
            UIGraphicsBeginImageContext(size)
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            ivPoster.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        dismiss(animated: true, completion: nil)
    }
}
