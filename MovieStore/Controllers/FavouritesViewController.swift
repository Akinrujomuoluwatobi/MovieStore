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
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let localRealm = try! Realm(configuration: RealmConfig.configuration)
        // Get all tasks in the realm
        let movies = localRealm.objects(D.self).toArray()
        movieListViewModel.moviesViewModel = movies.map(MoviesViewModel.init)
        collectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func deleteFavourite(_ vm: MoviesViewModel) {
        
    }
    
}
extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListViewModel.moviesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveitemCollectionViewCell", for: indexPath) as? MoveitemCollectionViewCell else { fatalError("Error dequeing collectionView reusable cell") }
        
        cell.setupView(movieListViewModel.moviesViewModel[indexPath.row])
        cell.favSelected = {
            () in
            self.deleteFavourite(self.movieListViewModel.moviesViewModel[indexPath.row])
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
    
    
}
