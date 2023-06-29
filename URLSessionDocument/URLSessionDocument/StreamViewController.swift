//
//  StreamViewController.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/06/29.
//

import UIKit

class StreamViewController: UIViewController {

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
        
//        output.delegate = self
        output.schedule(in: .current, forMode: .default)
        output.open()
        
        return Streams(output: output, input: input)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


