//
//  AppDelegate.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 04/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        loadUsersData()
        loadSeatsData()
        setUpRootVC()
        fetchMoviesData()
        return true
    }
    

    func setUpRootVC() {
        
        if(UserDefaults.standard.bool(forKey: USER_LOGIN_STATUS_KEY)) {
            if let activeUserData = UserDefaults.standard.object(forKey: ACTIVE_USER_KEY) as? Data {
                do {
                    let decoder = JSONDecoder()
                    activeUser = try decoder.decode(User.self, from: activeUserData)
                    print(activeUserData)
                } catch let error {
                    print("Error getting users from defaults \(error)")
                }
                activeUserIndex = UserDefaults.standard.integer(forKey: ACTIVE_USER_INDEX_KEY)
            }
            
            window?.rootViewController = UINavigationController(rootViewController: getViewController(vc: "HomeViewController"))
        }
        else
        {
            window?.rootViewController = UINavigationController(rootViewController: getViewController(vc: "LoginViewController"))
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveUsersData()
        saveSeatsData()
    }
    
    func fetchMoviesData() {
        var urlRequest = URLRequest(url: URL(string: movieJSON_URL)!)
        urlRequest.httpMethod = "GET"
        let urlSession = URLSession.shared.dataTask(with: urlRequest, completionHandler: {data, response, error in
            print(data)
            
            let jsonDecoder = JSONDecoder()
            
            if let safeData = data {
                do{
                    moviesData = try jsonDecoder.decode([Movie].self, from: safeData)
                    print(moviesData)
                    imagesData = Array(repeating: Data(), count: moviesData.count)
                }catch {
                    print("Error Decoding")
                }
            }
            DispatchQueue.main.async {
                guard let homeVC = ((self.window!.rootViewController as? UINavigationController)?.topViewController as? HomeViewController) else { return }
                homeVC.cvTest.reloadData()
                homeVC.cvMovieGrid.reloadData()
            }
            
        })
        DispatchQueue.global(qos: .utility).async {
            urlSession.resume()
        }
    }

    func saveUsersData() {
        let encoder = JSONEncoder()
         encoder.outputFormatting = .prettyPrinted
         
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let usersFileURL = URL(fileURLWithPath: "users_file", relativeTo: directoryURL).appendingPathExtension("txt")
        
        if let index = activeUserIndex {
            users[index] = activeUser
            if let encoded = try? encoder.encode(users[index]) {
                UserDefaults.standard.set(encoded, forKey: ACTIVE_USER_KEY)
                UserDefaults.standard.set(activeUserIndex, forKey: ACTIVE_USER_INDEX_KEY)
            }
        }
         
         do{
             let data = try encoder.encode(users)
             try data.write(to: usersFileURL)
             print("File saved: \(usersFileURL.absoluteURL)")
             
         } catch {
             print(error.localizedDescription)
         }
        
        
        
    }
    
    func saveSeatsData() {
        let encoder = JSONEncoder()
         encoder.outputFormatting = .prettyPrinted
         
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let seatsFileURL = URL(fileURLWithPath: "seats_file", relativeTo: directoryURL).appendingPathExtension("txt")
         
         do{
             let data = try encoder.encode(seatBooking)
             try data.write(to: seatsFileURL)
             print("File saved: \(seatsFileURL.absoluteURL)")
             
         } catch {
             print(error.localizedDescription)
         }
    }
    
    func loadUsersData() {
        
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let usersFileURL = URL(fileURLWithPath: "users_file", relativeTo: directoryURL).appendingPathExtension("txt")
        
        do {
            let data = try Data(contentsOf: usersFileURL)
            let decoder = JSONDecoder()
            users = try decoder.decode([User].self, from: data)
        } catch {
            print("Unable to retrieve users")
        }
    }
    
    func loadSeatsData() {
        
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let seatsFileURL = URL(fileURLWithPath: "seats_file", relativeTo: directoryURL).appendingPathExtension("txt")
        
        do {
            let data = try Data(contentsOf: seatsFileURL)
            let decoder = JSONDecoder()
            seatBooking = try decoder.decode([String: [[Int]]].self, from: data)
        } catch {
            print("Unable to retrieve users")
        }
    }
}

func getViewController(vc: String) -> UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let viewController = storyboard.instantiateViewController(withIdentifier: vc)
    return viewController
}
