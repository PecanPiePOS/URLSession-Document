//
//  StreamViewController.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/06/29.
//

import UIKit

class StreamViewController: UIViewController {

    private var canWrite: Bool = false
    
    struct Streams {
        var output: OutputStream
        var input: InputStream
    }
    
    lazy var boundStreams: Streams = {
        var inputOrNil: InputStream? = nil
        var outputOrNil: OutputStream? = nil
        
        // 왜 여기서 inout 이 쓰이지?
        Stream.getBoundStreams(withBufferSize: 4096, inputStream: &inputOrNil, outputStream: &outputOrNil)
        
        guard let input = inputOrNil, let output = outputOrNil else {
            fatalError("On return of `getBoundStreams`, both `inputStream` and `outputStream` will contain non-nil streams.")
        }
        
        output.delegate = self
        output.schedule(in: .current, forMode: .default)
        output.open()
        
        return Streams(output: output, input: input)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension StreamViewController: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        guard aStream == boundStreams.output else {
            return
        }
        
        if eventCode.contains(.hasSpaceAvailable) {
            canWrite = true
        }
        
        if eventCode.contains(.errorOccurred) {
            print("Damn... The Stream failed with error")
            // eventCode.error 확인은 어떻게 할까? 따로 described Error 가 존재하는가?
        }
        
        // let timer =
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self else { return }

            if self.canWrite {
                let message = "*** \(Date())\r\n"
                guard let messageData = message.data(using: .utf8) else { return }

                let messageCount: Int = messageData.count
                let bytesWritten: Int = messageData.withUnsafeBytes() { (buffer: UnsafePointer<UInt8>) in
                    self.canWrite = false
                    return self.boundStreams.output.write(buffer, maxLength: messageCount)
                }

                if bytesWritten < messageCount {
                    // Handle writing less data than expected.
                }
            }
        }
    }
}

extension StreamViewController: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {
        completionHandler(boundStreams.input)
    }
}

