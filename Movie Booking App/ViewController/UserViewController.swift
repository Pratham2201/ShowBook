//
//  UserViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tvMyBookings: UITableView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var viewUserInfo: UIView!
    @IBOutlet weak var ivUserAvatar: UIImageView!
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "dd MMM yyyy, "
        timeFormatter.dateFormat = "hh:mm a"
        
        ivUserAvatar.layer.cornerRadius = 20
        ivUserAvatar.layer.borderColor = UIColor.black.cgColor
        ivUserAvatar.layer.borderWidth = 0.5
        
        viewOuter.layer.cornerRadius = 30
        tvMyBookings.layer.cornerRadius = 20
        viewUserInfo.layer.cornerRadius = 20
        
        lblUserName.text = activeUser.name
        lblUserEmail.text = activeUser.email
        
        tvMyBookings.register(UINib(nibName: "BookingTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        let alert = UIAlertController(title: "Warning!", message: "Do you want to Logout?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Logout", style: .default, handler: {(_) in
            
            users[activeUserIndex] = activeUser
            activeUser = nil
            activeUserIndex = nil
            
            UserDefaults.standard.removeObject(forKey: ACTIVE_USER_KEY)
            UserDefaults.standard.removeObject(forKey: ACTIVE_USER_INDEX_KEY)

            UserDefaults.standard.set(false, forKey: USER_LOGIN_STATUS_KEY)
            self.navigationController?.setViewControllers([getViewController(vc: "LoginViewController")], animated: true)
        })
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }

}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activeUser.bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell", for: indexPath) as? BookingTableViewCell else { return BookingTableViewCell() }
        let booking = activeUser.bookings[indexPath.row]
        cell.lblMovieTitle.text = moviesData[booking.movieIndex].title
        cell.lblMovieHall.text = booking.movieHall
        cell.imgMovie.image = UIImage(data: imagesData[booking.movieIndex])
        
        var arr = "Seats: "
        for seat in booking.movieSeats {
            let seatName = columnMap[seat.column]!+String(seat.row)
            arr = arr + seatName + ","
        }
        arr.remove(at: arr.index(arr.endIndex, offsetBy: -1))
        cell.lblSeatsBooked.text = arr
        cell.lblTotalAmount.text = "Amount: $\(booking.bookingAmount)"
        cell.lblMovieDate.text = dateFormatter.string(from: booking.movieDate) + timeFormatter.string(from: booking.movieTiming)
        return cell
    }
    
    
}
