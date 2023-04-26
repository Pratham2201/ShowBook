//
//  MenuInteractor.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation
import UIKit

protocol IMenuInteractor {
    
    func setMovieImage(imageIndex: Int)
    
    func filteringYear(movies: [(movie: Movie, movieIndex: Int, imageData: Data)])
    
    func filteringRuntime(movies: [(movie: Movie, movieIndex: Int, imageData: Data)])
    
    func filteringRating(movies: [(movie: Movie, movieIndex: Int, imageData: Data)])
    
    func filteringReleasedDate(movies: [(movie: Movie, movieIndex: Int, imageData: Data)])
    
    func filterSearch(searchText: String, moviesInit: [(movie: Movie, movieIndex: Int, imageData: Data)])
    
    func setFilterActions(movies: [(movie: Movie, movieIndex: Int, imageData: Data)])
}

class MenuInteractor: IMenuInteractor {
    
    var output: IMenuPresenter?
    var worker: IMenuWorker?
    
    func setMovieImage(imageIndex: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            if(imagesData[imageIndex] == Data()) {
                self.worker?.fetchImageData(imageIndex: imageIndex)
            }
            self.output?.setUpImageForCell(imageIndex: imageIndex)
        }
    }
    
    func setFilterActions(movies: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        print("Filtering released")
        let filter = [UIAlertAction(title: "Released", style: .default, handler: { (_) in
                self.filteringReleasedDate(movies: movies)
        }),
                      UIAlertAction(title: "Year", style: .default, handler: {(_) in
                self.filteringYear(movies: movies)
            
        }),
                      UIAlertAction(title: "Duration", style: .default, handler: {(_) in
                self.filteringRuntime(movies: movies)
            
        }),
                      UIAlertAction(title: "Rating", style: .default, handler: {(_) in
                self.filteringRating(movies: movies)
        }),
                      UIAlertAction(title: "Dismiss", style: .cancel)]
        output?.setUpFilterAlertBox(actions: filter)
    }
    
    func filteringYear(movies: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1 {
            for j in 0...(moviesCount-movie-1) {
                let filterYear1 = Int(filteredMovies[j].movie.year) ?? 0
                let filterYear2 = Int(filteredMovies[j+1].movie.year) ?? 0
                if(filterYear1 > filterYear2) {
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr
                } } }
        output?.setUpFilteredMovies(filteredMovies: filteredMovies)
    }
    
    func filteringRuntime(movies: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1 {
            for j in 0...(moviesCount-movie-1) {
                let filterRun1 = filteredMovies[j].movie.runtime.split(separator: " ")
                let filterRuntime1 = Int(filterRun1[0]) ?? 0
                let filterRun2 = filteredMovies[j+1].movie.runtime.split(separator: " ")
                let filterRuntime2 = Int(filterRun2[0]) ?? 0
                if(filterRuntime1 > filterRuntime2) {
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr
                    
                } } }
        output?.setUpFilteredMovies(filteredMovies: filteredMovies)
    }
    
    /* Filtering Ratings code start */
    func filteringRating(movies: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1 {
            for j in 0...(moviesCount-movie-1) {
                let filterRating1 = Double(filteredMovies[j].movie.imdbRating) ?? 0
                let filterRating2 = Double(filteredMovies[j+1].movie.imdbRating) ?? 0
                if(filterRating1 > filterRating2) {
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr
                    
                } } }
        output?.setUpFilteredMovies(filteredMovies: filteredMovies)
    }
    
    /* Filtering Released Date code start */
    func filteringReleasedDate(movies: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1 {
            for j in 0...(moviesCount-movie-1) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                let filterDate1 = dateFormatter.date(from: filteredMovies[j].movie.released) ?? Date()
                let filterDate2 = dateFormatter.date(from: filteredMovies[j+1].movie.released) ?? Date()
                if (filterDate1.compare(filterDate2)) == .orderedAscending {
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr
                } } }
        output?.setUpFilteredMovies(filteredMovies: filteredMovies)
    }
    
    func filterSearch(searchText: String, moviesInit: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        let searchedMovies = searchText.isEmpty ? moviesInit : moviesInit.filter { (item: (movie: Movie, movieIndex: Int, imageData: Data)) -> Bool in
            return item.movie.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        output?.setUpFilteredMovies(filteredMovies: searchedMovies)
    }

}
