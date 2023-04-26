//
//  HomeViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 04/04/23.
//

import UIKit

let backgroundColor = ["poster_1", "poster_2", "poster_3", "poster_4", "poster_5"]

class HomeViewController: UIViewController {

    var router: IHomeRouter?
    var output: IHomeInteractor?
    
    let customViewLayout = CustomViewLayout()
    
    @IBOutlet weak var cvTest: UICollectionView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var cvMovieGrid: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        HomeConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        HomeConfigurator.configure(viewController: self)
    }

    
    @IBAction func onClickAvatar( sender: UITapGestureRecognizer) {
        router?.routeToUser()
    }
    
    @IBAction func onCLickViewAll(_ sender: Any) {
        router?.routeToMenu()
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == cvTest) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return MovieCollectionViewCell() }
            let zPosition = -(CGFloat(indexPath.row) - CGFloat(customViewLayout.activeCardIndex))
            switch(zPosition) {
            case 0  : cell.setUpPoster(imgHeight: 360, alpha: 1.0, zPosition: zPosition)
            case -1 : cell.setUpPoster(imgHeight: 300, alpha: 0.7, zPosition: zPosition)
            case -2 : cell.setUpPoster(imgHeight: 240, alpha: 0.4, zPosition: zPosition)
            default : cell.setUpPoster(imgHeight: 360, alpha: 0.0, zPosition: zPosition)
            }
            output?.setMovieImage(imageIndex: indexPath.row, collectionView: HomeCollectionView.TestCV)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDisplay", for: indexPath) as? MovieDisplayCollectionViewCell ?? MovieDisplayCollectionViewCell()
            cell.setUpCell(posterName: backgroundColor[indexPath.row%5], movie: moviesData[indexPath.row])
            output?.setMovieImage(imageIndex: indexPath.row, collectionView: HomeCollectionView.MovieGridCV)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == cvMovieGrid) {
            return CGSize(width: collectionView.frame.width/3.3, height: collectionView.frame.height)
        } else {
            return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToMoviePage(movieIndex: indexPath.row)
    }
    
}

extension HomeViewController {
    func setImage(imageIndex: Int, collectionView: HomeCollectionView) {
        switch(collectionView) {
        case HomeCollectionView.TestCV : do {
            guard let cell = cvTest.cellForItem(at: IndexPath(row: imageIndex, section: 0)) as? MovieCollectionViewCell else { return }
            cell.imgMoviePoster.image = UIImage(data: imagesData[imageIndex])
        }
        case HomeCollectionView.MovieGridCV : do {
            guard let cell = cvMovieGrid.cellForItem(at: IndexPath(row: imageIndex, section: 0)) as? MovieDisplayCollectionViewCell else { return }
            cell.ivMovie.image = UIImage(data: imagesData[imageIndex])
        }
        }
    }
    
    func setUpView() {
        cvTest.collectionViewLayout = customViewLayout
        cvTest.showsHorizontalScrollIndicator = false
        
        ivAvatar.layer.borderWidth = 0.5
        ivAvatar.layer.borderColor = UIColor.black.cgColor
        ivAvatar.layer.cornerRadius = 30
        
        cvMovieGrid.register(UINib(nibName: "MovieDisplayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieDisplay")
    }
}

class CustomViewLayout: UICollectionViewFlowLayout {
    
    var prevActiveCardIndex = 0
    var activeCardIndex = 0
    var width : CGFloat?
    var prevProposedOffset = CGPoint(x: 0.0, y: 0.0)
    
    override func prepare() {
        
        guard let cv = collectionView else { return }

        scrollDirection = .horizontal
        
        width = (cv.frame.width)
        
        itemSize = CGSize(width: width!, height: cv.frame.height)
        minimumLineSpacing = -(width!) + 40
        
        print("prepare called")
        width = 40
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let sign = (prevProposedOffset.x-proposedContentOffset.x>0) ? -1.0 : 1.0
        let val = proposedContentOffset.x+sign*width!
        prevProposedOffset.x = val - val.truncatingRemainder(dividingBy: width!)
        print(prevProposedOffset.x)
        
        prevActiveCardIndex = activeCardIndex
        activeCardIndex = Int(prevProposedOffset.x/40.0)
        
        collectionView?.reloadItems(at: [IndexPath(row: prevActiveCardIndex, section: 0), IndexPath(row: prevActiveCardIndex+1, section: 0), IndexPath(row: prevActiveCardIndex+2, section: 0)])
        
        activeCardIndex = (activeCardIndex < 0) ? 0 : activeCardIndex
        
        collectionView?.reloadItems(at: [IndexPath(row: activeCardIndex, section: 0), IndexPath(row: activeCardIndex-1, section: 0), IndexPath(row: activeCardIndex+1, section: 0), IndexPath(row: activeCardIndex+2, section: 0), IndexPath(row: activeCardIndex+3, section: 0)])
        
        return CGPoint(x: prevProposedOffset.x, y: proposedContentOffset.y+0)
    }
    
}
