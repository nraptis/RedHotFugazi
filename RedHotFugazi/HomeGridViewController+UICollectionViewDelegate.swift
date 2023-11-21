//
//  HomeGridViewController+UICollectionViewDelegate.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

extension HomeGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        homeGridViewModel.notifyCellBecameVisible(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        homeGridViewModel.notifyCellBecameHidden(indexPath.row)
    }
}
