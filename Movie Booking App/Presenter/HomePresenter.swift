//
//  HomePresenter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation

protocol IHomePresenter {
    
    func setUpImageForCell(imageIndex: Int, collectionView: HomeCollectionView)
}

class HomePresenter: IHomePresenter {
    
    weak var output: HomeViewController?
    
    func setUpImageForCell(imageIndex: Int, collectionView: HomeCollectionView) {
        DispatchQueue.main.async {
            self.output?.setImage(imageIndex: imageIndex, collectionView: collectionView)
        }
    }
}
