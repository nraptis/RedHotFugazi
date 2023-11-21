//
//  HomeGridViewModel.swift
//  PestBlaster
//
//  Created by Nicky Taylor on 11/20/23.
//

import Foundation
import UIKit
import Combine

class HomeGridViewModel {
    
    var cellDataList = [HomeGridCellData]()
    
    lazy var downloader: PriorityDataDownloader = {
        let result = PriorityDataDownloader(numberOfSimultaneousDownloads: 3)
        result.delegate = self
        return result
    }()
    
    var cellDownloadStatusChangePublisher = PassthroughSubject<HomeGridCellData, Never>()
    var visibleCellSet = Set<Int>()
    var imageMap = [Int: UIImage]()
    var errorMap = [Int: Bool]()
    
    init() {
        
        let url1 = "https://dev-test-nv.s3.amazonaws.com/ducati.jpg"
        let url2 = "https://dev-test-nv.s3.amazonaws.com/f1.jpg"
        
        //let url1 = "https://m.media-amazon.com/images/I/81sMEvzsAxL.jpg"
        //let url2 = "https://images.pexels.com/photos/1097456/pexels-photo-1097456.jpeg"
        
        for index in 0...999 {
            let url: String
            if Bool.random() {
                url = url1
            } else {
                url = url2
            }
            let cellData = HomeGridCellData(index: index,
                                            urlString: url)
            cellDataList.append(cellData)
        }
    }
    
    func getCellData(at index: Int) -> HomeGridCellData? {
        if index >= 0 && index < cellDataList.count {
            return cellDataList[index]
        }
        return nil
    }
    
    func notifyCellBecameVisible(_ index: Int) {
        if let cellData = getCellData(at: index) {
            if imageMap[index] == nil && errorMap[index] == nil {
                if !downloader.doesTaskExist(cellData) {
                    downloader.addDownloadTask(cellData)
                }
            }
        }
        visibleCellSet.insert(index)
    }
    
    func notifyCellBecameHidden(_ index: Int) {
        if let cellData = getCellData(at: index) {
            downloader.removeDownloadTask(cellData)
        }
        visibleCellSet.remove(index)
        imageMap.removeValue(forKey: index)
        errorMap.removeValue(forKey: index)
    }
    
    func getImage(at index: Int) -> UIImage? {
        imageMap[index]
    }
    
    func getError(at index: Int) -> Bool? {
        errorMap[index]
    }
    
    private func priority(distX: Int, distY: Int) -> Int {
        let px = (-distX)
        let py = (8192 * 8192) - (8192 * distY)
        return (px + py)
    }
    
    private var _firstContentThump = true
    func handleScreenContentDidMove(_ indexAndFrameList: [(index: Int, frame: CGRect)]) {
        for item in indexAndFrameList {
            if let cellData = getCellData(at: item.index) {
                let distX = Int(item.frame.origin.x)
                let distY = Int(item.frame.origin.y)
                let priority = priority(distX: distX,
                                        distY: distY)
                downloader.setPriority(cellData, priority)
            }
        }
        downloader.startTasksIfNecessary()
    }
}
