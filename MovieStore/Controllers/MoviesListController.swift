//
//  ViewController.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import UIKit

class MoviesListController: UIViewController {

    @IBOutlet weak var searchItem: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
}
extension MoviesListController: UICollectionViewDataSource, UICollisionBehaviorDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
