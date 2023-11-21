//
//  PriorityDataDownloader.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import Foundation
import UIKit

protocol PriorityDataDownloaderDelegate: AnyObject {
    func dataDownloadDidStart(_ cellData: HomeGridCellData)
    func dataDownloadDidSucceed(_ cellData: HomeGridCellData, image: UIImage)
    func dataDownloadDidFail(_ cellData: HomeGridCellData)
}

class PriorityDataDownloader {
    
    weak var delegate: PriorityDataDownloaderDelegate?
    
    var operationQueue = OperationQueue()
    
    private let numberOfSimultaneousDownloads: Int
    init(numberOfSimultaneousDownloads: Int) {
        self.numberOfSimultaneousDownloads = numberOfSimultaneousDownloads
        operationQueue.maxConcurrentOperationCount = numberOfSimultaneousDownloads
    }
    
    private(set) var taskList = [PriorityDataDownloaderTask]()
    private var failedHomeGridCellDataIndexSet = Set<Int>()
    private var _numberOfActiveDownloads = 0
    
    func addDownloadTask(_ cellData: HomeGridCellData) {
        guard !failedHomeGridCellDataIndexSet.contains(cellData.index) else { return }
        guard !doesTaskExist(cellData) else { return }
        
        let newTask = PriorityDataDownloaderTask(self, cellData)
        taskList.append(newTask)
        computeNumberOfActiveDownloads()
    }
    
    func removeDownloadTask(_ cellData: HomeGridCellData) {
        guard let index = taskIndex(cellData) else { return }
        taskList.remove(at: index)
        computeNumberOfActiveDownloads()
    }
    
    func forceRestartDownload(_ cellData: HomeGridCellData) {
        failedHomeGridCellDataIndexSet.remove(cellData.index)
        removeDownloadTask(cellData)
        addDownloadTask(cellData)
        if let index = taskIndex(cellData) {
            taskList[index].start()
            delegate?.dataDownloadDidStart(cellData)
        }
    }
    
    func invalidateAndRemoveAllTasks() {
        for task in taskList {
            task.invalidate()
        }
        taskList.removeAll()
        failedHomeGridCellDataIndexSet.removeAll()
        _numberOfActiveDownloads = 0
    }
    
    func doesTaskExist(_ cellData: HomeGridCellData) -> Bool { taskIndex(cellData) != nil }
    
    private func taskIndex(_ cellData: HomeGridCellData) -> Int? {
        for (index, task) in taskList.enumerated() {
            if task.cellDataIndex == cellData.index { return index }
        }
        return nil
    }
    
    func setPriority(_ cellData: HomeGridCellData, _ priority: Int) {
        guard let index = taskIndex(cellData) else { return }
        taskList[index].setPriority(priority)
    }
    
    private func computeNumberOfActiveDownloads() {
        _numberOfActiveDownloads = 0
        for task in taskList {
            if task.active == true {
                _numberOfActiveDownloads += 1
            }
        }
    }
    
    func isActivelyDownloading(_ cellData: HomeGridCellData) -> Bool {
        if let index = taskIndex(cellData) {
            return taskList[index].active
        }
        return false
    }
    
    private func chooseTaskToStart() -> PriorityDataDownloaderTask? {
        
        // Choose the highest priority task (that is not active!)
        var highestPriority = Int.min
        var result: PriorityDataDownloaderTask?
        
        for task in taskList {
            if !task.active {
                if (result == nil) || (task.priority > highestPriority) {
                    highestPriority = task.priority
                    result = task
                }
            }
        }
        return result
    }
    
    func startTasksIfNecessary() {
        while _numberOfActiveDownloads < numberOfSimultaneousDownloads {
            if let task = chooseTaskToStart() {
                // start the task!
                task.start()
                computeNumberOfActiveDownloads()
                delegate?.dataDownloadDidStart(task.cellData)
            } else {
                // there are no tasks to start, must exit!
                return
            }
        }
    }
}

extension PriorityDataDownloader {
    func handleDownloadTaskDidSucceed(task: PriorityDataDownloaderTask, image: UIImage) {
        removeDownloadTask(task.cellData)
        computeNumberOfActiveDownloads()
        delegate?.dataDownloadDidSucceed(task.cellData, image: image)
    }
    
    func handleDownloadTaskDidFail(task: PriorityDataDownloaderTask) {
        failedHomeGridCellDataIndexSet.insert(task.cellDataIndex)
        removeDownloadTask(task.cellData)
        computeNumberOfActiveDownloads()
        delegate?.dataDownloadDidFail(task.cellData)
    }
}
