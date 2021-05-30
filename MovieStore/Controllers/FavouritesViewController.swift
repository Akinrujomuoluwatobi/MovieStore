//
//  FavouritesViewController.swift
//  MovieStore
//
//  Created by MAC on 30/05/2021.
//

import UIKit
import RealmSwift

class FavouritesViewController: UIViewController {
    
    var movieListViewModel = MoviesListViewModel()
    var selectedVM: MoviesViewModel?
    var movies: [D]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let localRealm = try! Realm(configuration: RealmConfig.configuration)
        // Get all tasks in the realm
        movies = localRealm.objects(D.self).toArray()
        if let movies = movies {
            self.movieListViewModel.moviesViewModel = movies.map(MoviesViewModel.init)
        }
        collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    func deleteFavourite(_ indexPath: IndexPath) {
        movieListViewModel.moviesViewModel.remove(at: indexPath.row)
        let movie = movies?[indexPath.row]
        let realm = try! Realm(configuration: RealmConfig.configuration)
        if let movie = movie {
            try! realm.write {
                // Delete the stored movie.
                realm.delete(movie)
            }
        }
        collectionView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc  = segue.destination as? MovieDetailsViewController else { return  }
        vc.vm = selectedVM
        
    }
    
}
extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListViewModel.moviesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavMovieCollectionCell", for: indexPath) as? MoveitemCollectionViewCell else { fatalError("Error dequeing collectionView reusable cell") }
        
        cell.setupView(movieListViewModel.moviesViewModel[indexPath.row])
        cell.favSelected = {
            () in
            print(self.movieListViewModel.moviesViewModel[indexPath.row])
            self.deleteFavourite(indexPath)
        }
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            selectedVM = movieListViewModel.moviesViewModel[index.row]
            performSegue(withIdentifier: "LaunchMovieDetailsVC", sender: self)
        }
    }
    
    
}
