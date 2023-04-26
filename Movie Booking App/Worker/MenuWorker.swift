//
//  MenuWorker.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation

protocol IMenuWorker {
    
    func fetchImageData(imageIndex: Int)
}

class MenuWorker: IMenuWorker {
    
    func fetchImageData(imageIndex: Int) {
        let urlString = moviesData[imageIndex].images[0]
        let urlSession = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { data, response, error in
            if let safeData = data {
                imagesData[imageIndex] = safeData
            }
        })
            urlSession.resume()

    }
}
