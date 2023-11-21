//
//  GridLayout.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

class GridLayout: UICollectionViewLayout {
    static func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var inset: CGFloat
            if layoutEnvironment.traitCollection.horizontalSizeClass == .compact {
                inset = 10.0
            } else {
                inset = 8.0
            }
            let columns = Self.numberOfCols(width: layoutEnvironment.container.effectiveContentSize.width,
                                            inset: inset)
            if layoutEnvironment.traitCollection.horizontalSizeClass == .compact {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/CGFloat(columns)), heightDimension: .fractionalHeight(1))
                 let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/CGFloat(columns)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/CGFloat(columns)), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/CGFloat(columns)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
    }
    
    private static let cellMaximumWidth = CGFloat(100.0)
    static func numberOfCols(width: CGFloat, inset: CGFloat) -> Int {
        
        var result = 1
        
        //try out horizontal counts until the cells would be
        //smaller than the maximum width
        var horizontalCount = 2
        while horizontalCount < 1024 {
            
            //the amount of space between the cells, including "inset" on both sides too.
            //so more spacing should between the cells than left and right, per the scheme.
            let totalInsetWidth = CGFloat(horizontalCount + 1) * inset
            
            let availableWidthForCells = width - totalInsetWidth
            let expectedCellWidth = availableWidthForCells / CGFloat(horizontalCount)
            
            if expectedCellWidth < CGFloat(cellMaximumWidth) {
                break
            } else {
                result = horizontalCount
                horizontalCount += 1
            }
        }
        return result
    }
    
}
