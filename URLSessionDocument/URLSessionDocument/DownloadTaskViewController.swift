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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}

extension DownloadTaskViewController: URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
}
