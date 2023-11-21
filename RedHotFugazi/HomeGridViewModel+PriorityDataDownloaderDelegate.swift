//
//  HomeGridViewModel+PriorityDataDownloaderDelegate.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import Foundation
import UIKit

extension HomeGridViewModel: PriorityDataDownloaderDelegate {
    
    func dataDownloadDidStart(_ cellData: HomeGridCellData) {
        cellDownloadStatusChangePublisher.send(cellData)
        downloader.startTasksIfNecessary()
    }
    
    func dataDownloadDidSucceed(_ cellData: HomeGridCellData, image: UIImage) {
        imageMap[cellData.index] = image
        cellDownloadStatusChangePublisher.send(cellData)
        downloader.startTasksIfNecessary()
    }
    
    func dataDownloadDidFail(_ cellData: HomeGridCellData) {
        imageMap.removeValue(forKey: cellData.index)
        errorMap[cellData.index] = true
        
        cellDownloadStatusChangePublisher.send(cellData)
        downloader.startTasksIfNecessary()
    }
}
