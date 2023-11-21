//
//  HomeGridViewController+UICollectionViewDataSource.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

extension HomeGridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeGridViewModel.cellDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.row >= 0 && indexPath.row < homeGridViewModel.cellDataList.count else {
            print("FATAL: Cell index out of bounds...")
            return UICollectionViewCell(frame: .zero)
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellIdentifierHomeGridStandardCell,
                                                            for: indexPath) as? HomeGridCollectionViewCell else {
            print("FATAL: Cell not properly registered...")
            return UICollectionViewCell(frame: .zero)
        }
        
        let cellData = homeGridViewModel.cellDataList[indexPath.row]
        cell.setup(cellData: cellData, homeGridViewModel: homeGridViewModel)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        false
    }
}
