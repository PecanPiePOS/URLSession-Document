//
//  SessionViewController.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/06/28.
//

import UIKit

class SessionViewController: UIViewController {

    private let session1 = URLSession.shared
    private let session2 = URLSession(configuration: .default)
    private let session3 = URLSession(configuration: .ephemeral)
    private let sessionBackground4 = URLSession(configuration: .background(withIdentifier: "back1"))
    private let sessionBackground5 = URLSession(configuration: .background(withIdentifier: "back2"))
    private let session6 = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        // delegate: URLSessionDelegate?, delegateQueue: OperationQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        analyzeRequest()
    }
    
    func analyzeRequest() {
        guard let url = URL(string: "www.naver.com") else { return }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3)
        
        let defaultRequest = URLRequest(url: url)
        print(defaultRequest.cachePolicy) // default cachePolicy 는 .useProtocolCachePolicy 다.
        print(defaultRequest.timeoutInterval) // default timeoutInterval 는 60.0s 다.
        
        // cachPolicy -> .reloadIgnoringLocalAndRemoteCacheData, .reloadIgnoringLocalCacheData, .reloadRevalidatingCacheData, .returnCacheDataDontLoad, .returnCacheDataElseLoad, u.seProtocolCachePolicy
    }

}
