//
//  HomeInteractor.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation

protocol IHomeInteractor {
    
    func setMovieImage(imageIndex: Int, collectionView: HomeCollectionView)
}

class HomeInteractor: IHomeInteractor {
    
    var output: IHomePresenter?
    var worker: IHomeWorker?
    
    func setMovieImage(imageIndex: Int, collectionView: HomeCollectionView) {
        DispatchQueue.global(qos: .userInitiated).async {
            if(imagesData[imageIndex] == Data()) {
                self.worker?.fetchImageData(imageIndex: imageIndex)
            }
            self.output?.setUpImageForCell(imageIndex: imageIndex, collectionView: collectionView)
        }
    }
}
