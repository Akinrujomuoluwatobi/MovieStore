//
//  MoviesViewModel.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import Foundation
class MoviesListViewModel {
    var moviesViewModel: [MoviesViewModel]
    
    init() {
        self.moviesViewModel = [MoviesViewModel]()
    }
}

extension MoviesListViewModel{
    func orderViewModel(at index: Int) -> MoviesViewModel {
        return moviesViewModel[index]
    }
}

struct MoviesViewModel {
    let movie: D
}

extension MoviesViewModel {
    var title : String? {
        return movie.l
    }
    
    var id : String? {
        return movie.id
    }
    
    var imageDetails: I? {
        return movie.i
    }
    
    var directors: String? {
        return movie.s
    }
    
    var year: String {
        return String(movie.y ?? 0)
    }
    var feature: String?{
        return movie.q
    }
    
    var rating: Int?{
        return movie.rank
    }
    
    var type: String? {
        return movie.q
    }
    
    
}
