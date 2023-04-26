//
//  SeatBookingViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 10/04/23.
//

import UIKit

class SeatBookingViewController: UIViewController {

    @IBOutlet weak var ivBackgroundMovie: UIImageView!
    @IBOutlet weak var viewBookingOptions: UIView!
    @IBOutlet weak var viewMovieHallOptionOuter: UIView!
    @IBOutlet weak var viewMovieDateOptionOuter: UIView!
    @IBOutlet weak var viewMovieTimeOptionOuter: UIView!
    @IBOutlet weak var viewMovieTitleOptionOuter: UIView!
    @IBOutlet weak var cvSeats: UICollectionView!
    @IBOutlet weak var viewMovieTicket: UIView!
    @IBOutlet weak var tvDropdown: UITableView!
    @IBOutlet weak var svDateAndTime: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHall: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var lblTotalAmout: UILabel!
    
    var router: ISeatBookingRouter?
    var output: ISeatBookingInteractor?
    
    var hallSeats: [[Int]] = []
    var movieIndex: Int!
    let price = 15
    
    var selectedMovieDate: Int!
    var selectedMovieTiming: Int!
    var seletecMovieHall: Int!
    var seatBookingKey: String!
    var selectedDropdown: String!
    var selectedSeatsSet = Set<Seat>()
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    override func loadView() {
        super.loadView()
        output?.setBookingKeyAndHall(selectedMovie: movieIndex, selectedDate: selectedMovieDate, selectedTime: selectedMovieTiming, selectedHall: seletecMovieHall)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvSeats.register(UINib(nibName: "SeatsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SeatsCollectionViewCell")
        tvDropdown.register(UINib(nibName: "DropdownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropdownTableViewCell")
        ivBackgroundMovie.image = UIImage(data: imagesData[movieIndex])
        setBorderandCorner(view: ivBackgroundMovie, borderWidth: 1, borderColor: UIColor.clear.cgColor, cornerRadius: 20)
        setBorderandCorner(view: viewBookingOptions, borderWidth: 1, borderColor: UIColor.clear.cgColor, cornerRadius: 10)
        setBorderandCorner(view: viewMovieDateOptionOuter, borderWidth: 1, borderColor: UIColor.lightGray.cgColor, cornerRadius: 15)
        setBorderandCorner(view: viewMovieHallOptionOuter, borderWidth: 1, borderColor: UIColor.lightGray.cgColor, cornerRadius: 15)
        setBorderandCorner(view: viewMovieTimeOptionOuter, borderWidth: 1, borderColor: UIColor.lightGray.cgColor, cornerRadius: 15)
        setBorderandCorner(view: viewMovieTicket, borderWidth: 0.5, borderColor: UIColor.lightGray.cgColor, cornerRadius: 35)
        setBorderandCorner(view: tvDropdown, borderWidth: 0.5, borderColor: UIColor.lightGray.cgColor, cornerRadius: 10)
        tvDropdown.isHidden = true
        
        dateFormatter.dateFormat = "EEEE, dd"
        timeFormatter.dateFormat = "hh:mm a"
        
        lblTitle.text = moviesData[movieIndex].title
        lblDate.text = dateFormatter.string(from: upcomingMovieDates[selectedMovieDate]!)
        lblTime.text = timeFormatter.string(from: movieTimings[selectedMovieTiming])
        lblHall.text = movieHalls[seletecMovieHall]
        setSeatsAndPrice()
        
        viewBookingOptions.layer.shadowOpacity = 0.1
        viewBookingOptions.layer.shadowRadius = 20
        viewBookingOptions.layer.shadowOffset = CGSize(width: 0, height: 20)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SeatBookingConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SeatBookingConfigurator.configure(viewController: self)
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        output?.bookSeats(selectedMovie: movieIndex, selectedDate: selectedMovieDate, selectedTime: selectedMovieTiming, selectedHall: seletecMovieHall, selectedSeats: selectedSeatsSet, hall: hallSeats)
    }
    
    @IBAction func MovieTitleSelect(_ sender: Any) {
        presentDropdown(x: viewMovieTitleOptionOuter.frame.minX, y: viewMovieTitleOptionOuter.frame.maxY, width:  viewMovieTitleOptionOuter.frame.width, selectedDropdowntitle: "TITLE")
    }
    
    @IBAction func MovieDateSelect(_ sender: Any) {
        presentDropdown(x: svDateAndTime.frame.minX, y: svDateAndTime.frame.maxY, width:  svDateAndTime.frame.width, selectedDropdowntitle: "DATE")
    }
    
    @IBAction func MovieTimeSelect(_ sender: Any) {
        presentDropdown(x: viewMovieTimeOptionOuter.frame.minX+20, y: svDateAndTime.frame.maxY, width:  viewMovieTimeOptionOuter.frame.width, selectedDropdowntitle: "TIME")    }
    
    @IBAction func MovieHallSelect(_ sender: Any) {
        presentDropdown(x: viewMovieHallOptionOuter.frame.minX, y: viewMovieHallOptionOuter.frame.maxY, width:  viewMovieHallOptionOuter.frame.width, selectedDropdowntitle: "HALL")
    }
}

extension SeatBookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hallSeats[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return hallSeats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatsCollectionViewCell", for: indexPath) as? SeatsCollectionViewCell else {
            return SeatsCollectionViewCell()
        }
        cell.isHidden = false
        switch(hallSeats[indexPath.section][indexPath.row]) {
        case 0 : cell.isHidden = true
        case 2 : cell.ivSeat.tintColor = .tintColor
        case 3 : cell.ivSeat.tintColor = .black
        default : cell.ivSeat.tintColor = .systemGray5
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(hallSeats[indexPath.section][indexPath.row]) {
        case 1: do {
            selectedSeatsSet.insert(Seat(column: indexPath.section, row: indexPath.row))
            changeSeatAllocation(indexPath: indexPath, color: .tintColor, seatStatus: 2)
        }
        case 2: do {
            selectedSeatsSet.remove(Seat(column: indexPath.section, row: indexPath.row))
            changeSeatAllocation(indexPath: indexPath, color: .systemGray5, seatStatus: 1)
        }
        default: print("clicked \(indexPath)")
        }
        setSeatsAndPrice()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-60)/12, height: (collectionView.frame.width-60)/11)
    }
}

extension SeatBookingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(selectedDropdown) {
        case "TITLE" : return moviesData.count
        case "DATE" : return upcomingMovieDates.count
        case "TIME" : return movieTimings.count
        case "HALL" : return movieHalls.count
        default : return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownTableViewCell") as? DropdownTableViewCell else { return DropdownTableViewCell() }
        switch(selectedDropdown) {
        case "TITLE" : cell.lblDropdownOption.text = moviesData[indexPath.row].title
        case "DATE" : cell.lblDropdownOption.text = dateFormatter.string(from: upcomingMovieDates[indexPath.row]!)
        case "TIME" : cell.lblDropdownOption.text = timeFormatter.string(from: movieTimings[indexPath.row])
        case "HALL" : cell.lblDropdownOption.text = movieHalls[indexPath.row]
        default : cell.lblDropdownOption.text = "No Option"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DropdownTableViewCell else { return }
        switch(selectedDropdown) {
        case "TITLE" : changeDropdownOnSelect(lbl: lblTitle, cell: cell, selectedParameter: &movieIndex, index: indexPath.row)
        case "DATE" : changeDropdownOnSelect(lbl: lblDate, cell: cell, selectedParameter: &selectedMovieDate, index: indexPath.row)
        case "TIME" : changeDropdownOnSelect(lbl: lblTime, cell: cell, selectedParameter: &selectedMovieTiming, index: indexPath.row)
        case "HALL" : changeDropdownOnSelect(lbl: lblHall, cell: cell, selectedParameter: &seletecMovieHall, index: indexPath.row)
        default : print("Default executed")
        }
        selectedSeatsSet.removeAll()
        setSeatsAndPrice()
        hallSeats = seatBooking[seatBookingKey] ?? defaultSeatArrangement
        cvSeats.reloadData()
        tvDropdown.isHidden = true
    }
    
}

extension SeatBookingViewController {
    func changeDropdownOnSelect(lbl: UILabel, cell: DropdownTableViewCell, selectedParameter: inout Int, index: Int) {
        lbl.text = cell.lblDropdownOption.text
        selectedParameter = index
    }
    
    func setSeatsAndPrice() {
        lblSeats.text = "x\(selectedSeatsSet.count)"
        lblTotalAmout.text = "$\(selectedSeatsSet.count*price)"
    }
    
    func setBorderandCorner(view: UIView, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat) {
        view.layer.borderColor = borderColor
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = cornerRadius
    }
    
    func presentDropdown(x: CGFloat, y: CGFloat, width: CGFloat, selectedDropdowntitle: String) {
        tvDropdown.frame = CGRect(x: viewBookingOptions.frame.minX+x, y: viewBookingOptions.frame.minY+y, width: width, height: 0)
        animateDropdown(cgRect: CGRect(x: viewBookingOptions.frame.minX+x, y: viewBookingOptions.frame.minY+y, width: width, height: 100))
        selectedDropdown = selectedDropdowntitle
        tvDropdown.reloadData()
        tvDropdown.isHidden = false
    }
    
    func changeSeatAllocation(indexPath: IndexPath, color: UIColor, seatStatus: Int) {
        hallSeats[indexPath.section][indexPath.row] = seatStatus
        let cell = cvSeats.cellForItem(at: indexPath) as? SeatsCollectionViewCell
        cell?.ivSeat.tintColor = color
    }
    
    func animateDropdown(cgRect: CGRect) {
        UIView.animate( withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tvDropdown.frame = cgRect
            self.view.layoutIfNeeded()
                  }, completion: nil)
    }
    
    func confirmBooking(alertBoxParamters: AlertBoxParamters) {
        showAlertBox(alertBoxParameters: alertBoxParamters, vc: self)
    }
    
    func getKeyAndHall(key: String, hall: [[Int]]) {
        seatBookingKey = key
        hallSeats = hall
    }
}
