//
//  FileUtils.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/21/23.
//

import UIKit

final class FileUtils {
    
    static let shared = FileUtils()
    
    private init() {
        
    }
    
    lazy var mainBundleDirectory: String = {
        var result:String! = nil
        result = Bundle.main.resourcePath
        result = result + "/"
        return result
    }()
    
    lazy var documentDirectory: String = {
        var result:String! = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        result = result + "/"
        return result
    }()
    
    func getDocumentPath(fileName: String?) -> String {
        var result = documentDirectory
        if let fileName = fileName {
            result = result + fileName
        }
        return result
    }
    
    func getMainBundleFilePath(fileName: String?) -> String {
        var result = mainBundleDirectory
        if let fileName = fileName {
            result = result + fileName
        }
        return result
    }
    
    func doesFileExists(filePath: String?) -> Bool {
        if let path = filePath, path.count > 0 {
            return FileManager.default.fileExists(atPath: path)
        }
        return false
    }
    
    @discardableResult
    func save(data: Data?, filePath: String?) -> Bool {
        if let path = filePath, let data = data {
            do {
                try data.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
                return true
            } catch {
                print("Unable to save data [\(path)]")
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    func load(_ filePath: String?) -> Data? {
        if let path = filePath {
            
            do {
                let fileURL: URL
                if #available(iOS 16.0, *) {
                    fileURL = URL(filePath: path)
                } else {
                    // Fallback on earlier versions
                    fileURL = URL(fileURLWithPath: path)
                }
                let result = try Data(contentsOf: fileURL)
                return result
            } catch {
                print("Unable to load data [\(path)]")
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    @discardableResult
    func savePNG(image: UIImage?, filePath: String?) -> Bool {
        if let filePath = filePath {
            if image != nil {
                if let imageData = image?.pngData() {
                    if save(data: imageData, filePath: filePath) {
                        return true
                    } else {
                        print("Unable to save image (\(image!.size.width)x\(image!.size.height)) [\(filePath)]")
                    }
                } else {
                    print("Unable to save image (\(image!.size.width)x\(image!.size.height)) [\(filePath)]")
                }
            }
        }
        return false
    }    
}
