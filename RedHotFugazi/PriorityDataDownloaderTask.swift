//
//  PriorityDataDownloaderTask.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import Foundation
import UIKit

class PriorityDataDownloaderTask: NSObject, URLSessionDelegate {
    
    unowned var downloader: PriorityDataDownloader!
    let cellData: HomeGridCellData
    
    private(set) var active = false
    private(set) var priority: Int = 0
    
    private var session: URLSession?
    private var dataTask: URLSessionDataTask?
    
    init(_ downloader: PriorityDataDownloader, _ cellData: HomeGridCellData) {
        self.downloader = downloader
        self.cellData = cellData
    }
    
    var cellDataIndex: Int { cellData.index }
    
    func setPriority(_ priority: Int) {
        self.priority = priority
    }
    
    func invalidate() {
        flush()
        downloader = nil
    }
    
    private func flush() {
        dataTask?.cancel()
        self.dataTask = nil
        
        session?.invalidateAndCancel()
        self.session = nil
    }
    
    func start() {
        
        active = true
        
        guard let downloader = downloader else {
            DispatchQueue.main.async {
                self.active = false
                self.flush()
                self.downloader.handleDownloadTaskDidFail(task: self)
            }
            return
        }
        
        guard let url = URL(string: cellData.urlString) else {
            DispatchQueue.main.async {
                self.active = false
                self.flush()
                self.downloader.handleDownloadTaskDidFail(task: self)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let _session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: self,
                                 delegateQueue: downloader.operationQueue)
        self.session = _session
        
        let _dataTask = _session.dataTask(with: request as URLRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                DispatchQueue.main.async {
                    if let self = self {
                        self.active = false
                        self.flush()
                        self.downloader.handleDownloadTaskDidFail(task: self)
                    }
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    if let self = self {
                        self.active = false
                        self.flush()
                        self.downloader.handleDownloadTaskDidFail(task: self)
                    }
                }
                return
            }
            guard var image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    if let self = self {
                        self.active = false
                        self.flush()
                        downloader.handleDownloadTaskDidFail(task: self)
                    }
                }
                return
            }
            
            if let self = self {
                let numberString = String(self.cellData.index)
                let fileName = "cached_\(numberString).png"
                let filePath = FileUtils.shared.getDocumentPath(fileName: fileName)
                if FileUtils.shared.savePNG(image: image, filePath: filePath) {
                    if let imageData = FileUtils.shared.load(filePath) {
                        if let cachedImage = UIImage(data: imageData) {
                            image = cachedImage
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                if let self = self {
                    self.active = false
                    self.flush()
                    downloader.handleDownloadTaskDidSucceed(task: self, image: image)
                }
            }
        }
        
        self.dataTask = _dataTask
        _dataTask.resume()
    }
}
