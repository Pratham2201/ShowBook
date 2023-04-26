//
//  MenuViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 06/04/23.
//

import UIKit

let emptyMovie = Movie(title: "", year: "", runtime: "", genre: "", plot: "", imdbRating: "", images: [], released: "")

class MenuViewController: UIViewController {

    @IBOutlet weak var cvBrowse: UICollectionView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var sbMovies: UISearchBar!
    
    var router: IMenuRouter?
    var output: IMenuInteractor?
    
    var movies: [(movie: Movie, movieIndex: Int, imageData: Data)] = Array(repeating: (emptyMovie, 0, Data()), count: moviesData.count)
    var moviesInit: [(movie: Movie, movieIndex: Int, imageData: Data)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MenuConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MenuConfigurator.configure(viewController: self)
    }

    
    @IBAction func onClickAvatar(_ sender: Any) {
        router?.routeToUser()
    }
    
    @IBAction func onClickFilter(_ sender: Any) {
        output?.setFilterActions(movies: movies)
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDisplay", for: indexPath) as? MovieDisplayCollectionViewCell else { return MovieDisplayCollectionViewCell() }
        cell.setUpCell(posterName: backgroundColor[indexPath.row%5], movie: movies[indexPath.row].movie)
        output?.setMovieImage(imageIndex: movies[indexPath.row].movieIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3-5, height: collectionView.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToMoviePage(movieIndex: movies[indexPath.row].movieIndex)
    }
}

extension MenuViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.filterSearch(searchText: searchText, moviesInit: moviesInit)
    }
}

extension MenuViewController {
    func setImage(imageIndex: Int) {
        guard let cell = cvBrowse.cellForItem(at: IndexPath(row: imageIndex, section: 0)) as? MovieDisplayCollectionViewCell else { return }
        cell.ivMovie.image = UIImage(data: imagesData[imageIndex])
    }
    
    func setUpView() {
        for movieIndex in (0..<moviesData.count) {
            movies[movieIndex] = (moviesData[movieIndex], movieIndex, imagesData[movieIndex])
        }
        moviesInit = movies
        cvBrowse.register(UINib(nibName: "MovieDisplayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieDisplay")
        ivAvatar.layer.cornerRadius = 30
        ivAvatar.layer.borderWidth = 0.5
        ivAvatar.layer.borderColor = UIColor.black.cgColor
        sbMovies.barTintColor = .red // NW
        sbMovies.searchTextField.layer.cornerRadius = 20
        sbMovies.searchTextField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.99)
    }
    
    func reloadCVBrowse(filteredMovies: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        movies = filteredMovies
        DispatchQueue.main.async {
            self.cvBrowse.reloadData()
        }
    }
}
