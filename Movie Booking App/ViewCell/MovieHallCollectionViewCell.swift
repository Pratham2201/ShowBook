//
//  MovieHallCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 10/04/23.
//

import UIKit

class MovieHallCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewMoviewItem: UIView!
    @IBOutlet weak var lblMovieHallName: UILabel!
    @IBOutlet weak var cvMovieTiming: UICollectionView!
    let dateFormatter = DateFormatter()
    let dateFormat = "hh:mm a"
    var hallIndex: Int!
    var selectedTime: Int!
    
    var delegateChangeSelectedSeat: IChangeSelectedSeat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cvMovieTiming.register(UINib(nibName: "MovieTimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieTimeCollectionViewCell")
        cvMovieTiming.showsHorizontalScrollIndicator = false
            }

}


extension MovieHallCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTimings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Time Item: \(indexPath)")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTimeCollectionViewCell", for: indexPath) as? MovieTimeCollectionViewCell else {
            return MovieTimeCollectionViewCell() }
        dateFormatter.dateFormat = dateFormat
        cell.lblMovieTime.text = dateFormatter.string(from: movieTimings[indexPath.row])
        cell.viewMovieTimeItem.layer.borderColor = UIColor.lightGray.cgColor
        
        if let time = selectedTime {
            if(time == indexPath.row) {
                cell.viewMovieTimeItem.layer.borderColor = UIColor.blue.cgColor
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("MovieTimeDidSelect: \(indexPath)  MovieHall: \(hallIndex)")
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieTimeCollectionViewCell else { return }
        
        delegateChangeSelectedSeat.updateSeat(newSelectedHall: hallIndex!, newSelectedTime: indexPath.row)
        cell.viewMovieTimeItem.layer.borderColor = UIColor.blue.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegateChangeSelectedSeat.saveContentOffset(hallIndex: hallIndex, offset: scrollView.contentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegateChangeSelectedSeat.saveContentOffset(hallIndex: hallIndex, offset: scrollView.contentOffset)
    }
}

