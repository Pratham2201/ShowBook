//
//  MoviePageViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 07/04/23.
//

import UIKit

class MoviePageViewController: UIViewController {

    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var viewMoviewCard: UIView!
    @IBOutlet weak var viewGenre1: UIView!
    @IBOutlet weak var viewGenre2: UIView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var cvMovieCalendar: UICollectionView!
    @IBOutlet weak var cvMovieTime: UICollectionView!
    @IBOutlet weak var lblGenre1: UILabel!
    @IBOutlet weak var lblGenre2: UILabel!
    @IBOutlet weak var lblImdbRating: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblPlot: UILabel!
    
    var router: IMoviePageRouter?
    
    var selectedDate = 0
    var selectedHall = 0
    var selectedTime = 0
    var movieIndex: Int!
    
    var cvOffset: [CGPoint] = Array(repeating: CGPoint(), count: movieHalls.count)
    
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvMovieCalendar.register(UINib(nibName: "MovieCalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCalendarCollectionViewCell")
        cvMovieTime.register(UINib(nibName: "MovieHallCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieHallCollectionViewCell")
        
        ivBackground.layer.cornerRadius = 20
        ivBackground.image = UIImage(data: imagesData[movieIndex])
        
        viewMoviewCard.layer.cornerRadius = 10
        viewGenre1.layer.cornerRadius = 15
        viewGenre2.layer.cornerRadius = 15
        
        viewMoviewCard.layer.shadowOpacity = 0.1
        viewMoviewCard.layer.shadowRadius = 20
        viewMoviewCard.layer.shadowOffset = CGSize(width: 0, height: 20)
        
        lblImdbRating.text = moviesData[movieIndex].imdbRating
        lblRuntime.text = moviesData[movieIndex].runtime
        lblPlot.text = moviesData[movieIndex].plot
        lblMovieTitle.text = moviesData[movieIndex].title
        
        let genres = moviesData[movieIndex].genre.components(separatedBy: ", ")
        if(genres.count>1){
            lblGenre1.text = genres[0]
        }
        if(genres.count>2){
            lblGenre2.text = genres[1]
        }
        cvMovieCalendar.showsHorizontalScrollIndicator = false
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MoviePageConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MoviePageConfigurator.configure(viewController: self)
    }

    
    @IBAction func onClickNext(_ sender: Any) {
        router?.routeToSeatBooking()
    }
}

extension MoviePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == cvMovieTime){
            return movieHalls.count
        } else{
            return upcomingMovieDates.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == cvMovieCalendar) {
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        } else {
            print("Width: \(collectionView.frame.width)")
            return CGSize(width: collectionView.frame.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("MovieHallDidSelect")
        if(collectionView == cvMovieCalendar) {
            guard let cell1 = cvMovieCalendar.cellForItem(at: indexPath) as? MovieCalendarCollectionViewCell else { return }
            changeSelectedDateView(cell: cell1, itemColor: UIColor.blue.cgColor, dayColor: .black, dateColor: .black)
            guard let cell2 = cvMovieCalendar.cellForItem(at: IndexPath(row: selectedDate, section: 0)) as? MovieCalendarCollectionViewCell else { selectedDate = indexPath.row
                return }
            changeSelectedDateView(cell: cell2, itemColor: UIColor.lightGray.cgColor, dayColor: .lightGray, dateColor: .lightGray)
            selectedDate = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == cvMovieCalendar) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCalendarCollectionViewCell", for: indexPath) as? MovieCalendarCollectionViewCell else { return MovieCalendarCollectionViewCell() }
            let date = upcomingMovieDates[indexPath.row]
            dateFormatter.dateFormat = "dd"
            cell.lblDate.text = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "EEE"
            cell.lblDay.text = dateFormatter.string(from: date!)
            if(indexPath.row != selectedDate)
            {
                changeSelectedDateView(cell: cell, itemColor: UIColor.lightGray.cgColor, dayColor: .lightGray, dateColor: .lightGray)
            } else {
                changeSelectedDateView(cell: cell, itemColor: UIColor.blue.cgColor, dayColor: .black, dateColor: .black)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieHallCollectionViewCell", for: indexPath) as? MovieHallCollectionViewCell else {
                return MovieHallCollectionViewCell() }
            cell.lblMovieHallName.text = movieHalls[indexPath.row]
            cell.delegateChangeSelectedSeat = self
            cell.hallIndex = indexPath.row
            cell.cvMovieTiming.setContentOffset(cvOffset[indexPath.row], animated: false)
            
            if(indexPath.row == selectedHall) {
                cell.selectedTime = selectedTime
            } else {
                cell.selectedTime = nil
            }
            cell.cvMovieTiming.reloadData()
            return cell
        }
        
    }
    
}

protocol IChangeSelectedSeat: AnyObject {
    
    func updateSeat(newSelectedHall: Int, newSelectedTime: Int)
    
    func saveContentOffset(hallIndex: Int, offset: CGPoint)
}

extension MoviePageViewController : IChangeSelectedSeat {
    
    func updateSeat(newSelectedHall: Int, newSelectedTime: Int) {
        print("Delegate Called")
        guard let cell = cvMovieTime.cellForItem(at: IndexPath(row: selectedHall, section: 0)) as? MovieHallCollectionViewCell else {
            selectedHall = newSelectedHall
            selectedTime = newSelectedTime
            return
        }
        guard let innerCell = cell.cvMovieTiming.cellForItem(at: IndexPath(row: selectedTime, section: 0)) as? MovieTimeCollectionViewCell else { print("Time Cell not Found")
            return
        }
        innerCell.viewMovieTimeItem.layer.borderColor = UIColor.lightGray.cgColor
        selectedHall = newSelectedHall
        selectedTime = newSelectedTime
    }
    
    func saveContentOffset(hallIndex: Int, offset: CGPoint) {
        cvOffset[hallIndex] = offset
    }
}

extension MoviePageViewController {
    
    func changeSelectedDateView(cell: MovieCalendarCollectionViewCell, itemColor: CGColor, dayColor: UIColor, dateColor: UIColor) {
        cell.viewCalendarItem.layer.borderColor = itemColor
        cell.lblDay.textColor = dayColor
        cell.lblDate.textColor = dateColor
    }
}
