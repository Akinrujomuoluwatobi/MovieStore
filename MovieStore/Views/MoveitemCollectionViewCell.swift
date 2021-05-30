//
//  MoveitemCollectionViewCell.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import UIKit

class MoveitemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var favSelected: (()->())?
    
    func setupView(_ vm: MoviesViewModel) {
        movieTitle.text = vm.title
        movieDirector.text = vm.directors
        movieReleaseYear.text = vm.year
        
        if let imageDetails = vm.imageDetails {
            let imageUrl:URL = URL(string: imageDetails.imageURL ?? "")!
            DispatchQueue.global(qos: .userInitiated).async {
                        
                let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
                        DispatchQueue.main.async {
                            
                            let image = UIImage(data: imageData as Data)
                            self.movieThumbnail.image = image
                            self.movieThumbnail.contentMode = UIView.ContentMode.scaleAspectFit
                            
                        }
                    }
        }else{
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favButton.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
    }
    
    @objc func favButtonPressed() {
        favSelected?()
    }
    
}
