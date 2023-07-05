//
//  DownloadTaskViewController.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/07/01.
//

import UIKit

class DownloadTaskViewController: UIViewController {
    
    private let session1: URLSession = URLSession(configuration: .default)
    private lazy var session2: URLSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    private lazy var session3: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "SessionForImages")
        configuration.isDiscretionary = true
        configuration.sessionSendsLaunchEvents = true
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    private var downloadTask: URLSessionDownloadTask?
    private let progressLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func downloadBackground() {
        guard let url: URL = URL(string: "www.naver.com") else { return }
        let backgroundTask = session3.downloadTask(with: url)
        
        backgroundTask.earliestBeginDate = Date().addingTimeInterval(60 * 60)
        backgroundTask.countOfBytesClientExpectsToSend = 200
        backgroundTask.countOfBytesClientExpectsToReceive = 500 * 1024
        backgroundTask.resume()
    }

    private func downloadFileToURL() {
        guard let url = URL(string: "www.naver.com") else { return }
        
        let downloadTask = session1.downloadTask(with: url) { fileURL, response, error in
            guard let fileURL else { return }
            
            do {
                let documentURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let savedURL = documentURL.appending(path: fileURL.lastPathComponent)
                
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
            } catch {
                print("file error: \(error)")
            }
        }
    }
    
    private func startDownload(url: URL) {
        let downloadTask = session2.downloadTask(with: url)
        downloadTask.resume()
        
        self.downloadTask = downloadTask
    }
}

extension DownloadTaskViewController: URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let response = downloadTask.response as? HTTPURLResponse else { return }
        let statusCode = response.statusCode
        
        switch statusCode {
        case 200..<299:
            break
        default:
            print("Error Occured")
            return
        }
        
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let savedURL = documentsURL.appending(path: location.lastPathComponent)
            try FileManager.default.moveItem(at: location, to: savedURL)
        } catch {
            print(error)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        
        if downloadTask == self.downloadTask {
            let calculatedProgress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            
            DispatchQueue.main.async {
                self.progressLabel.text = percentFormatter.string(from:     NSNumber(value: calculatedProgress))
            }
        }
    }
}
