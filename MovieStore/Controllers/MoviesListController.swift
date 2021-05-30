//
//  ViewController.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import UIKit
import RealmSwift

class MoviesListController: UIViewController {
    
    @IBOutlet weak var searchItem: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieListViewModel = MoviesListViewModel()
    var selectedVM: MoviesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        fetchPopulateMovies("action")
    }
    
    func fetchPopulateMovies(_ searchTerm: String) {
        WebServices().load(resource: Movies.all(searchTerm)) {[weak self] result in
            switch result.success {
            case true:
                if let moviesObj = result.data as? Movies {
                    if let movies = moviesObj.d {
                        self?.movieListViewModel.moviesViewModel = movies.map(MoviesViewModel.init)
                        self?.collectionView.reloadData()
                    }
                    
                }
                
            default:
                print(result.errorMessage ?? "")
            }
            
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        fetchPopulateMovies(searchItem.text ?? "")
    }
    
    func saveFavourite(_ vm: MoviesViewModel) {
        let mvitem = D(i: vm.imageDetails, id: vm.id, l: vm.title, q: vm.feature, rank: nil, s: vm.directors, vt: nil, y: Int(vm.year))
        do {
            let realm =  try? Realm(configuration: RealmConfig.configuration)
            try! realm?.write {
                realm?.add(mvitem)
            }
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc  = segue.destination as? MovieDetailsViewController else { return  }
        vc.vm = selectedVM
        
    }
    
}
extension MoviesListController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListViewModel.moviesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveitemCollectionViewCell", for: indexPath) as? MoveitemCollectionViewCell else { fatalError("Error dequeing collectionView reusable cell") }
        
        cell.setupView(movieListViewModel.moviesViewModel[indexPath.row])
        cell.favSelected = {
            () in
            self.saveFavourite(self.movieListViewModel.moviesViewModel[indexPath.row])
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
