//
//  MovieDetailsViewController.swift
//  MovieStore
//
//  Created by MAC on 30/05/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var vm: MoviesViewModel?
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = vm?.title
        print(String(describing: vm))
        loadMovieDetails()
        // Do any additional setup after loading the view.
    }
    
    func loadMovieDetails() {
        if let imageDetails = vm?.imageDetails {
            let imageUrl:URL = URL(string: imageDetails.imageURL ?? "")!
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
                DispatchQueue.main.async {
                    
                    let image = UIImage(data: imageData as Data)
                    self.moviePoster.image = image
                    self.moviePoster.contentMode = UIView.ContentMode.scaleToFill
                    
                }
            }
        }
        
        movieTitle.text = vm?.title
        movieDirector.text = vm?.directors
        movieYear.text = vm?.year
        movieType.text = vm?.type
        movieRating.text = String(vm?.rating ?? 0)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
