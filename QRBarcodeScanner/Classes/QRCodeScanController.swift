//
//  QRCodeScanController.swift
//  DemoApp
//
//  Created by dexiong on 2021/12/16.
//

import UIKit
import AVFoundation

public class QRCodeScanController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let metadataOutputQueue = DispatchQueue.init(label: "AVCaptureMetadataOutputQueue")
    let sessionQueue = DispatchQueue.init(label: "AVCaptureSessionQueue")
    
    lazy var session: AVCaptureSession = {
        let captureSession: AVCaptureSession = .init()
        if captureSession.canSetSessionPreset(.hd1920x1080) {
            captureSession.sessionPreset = .hd1920x1080
        } else if captureSession.canSetSessionPreset(.vga640x480) {
            captureSession.sessionPreset = .vga640x480
        }
        return captureSession
    }()
    
    lazy var device: AVCaptureDevice = {
        guard let d = AVCaptureDevice.default(for: .video) else { fatalError("硬件获取失败") }
        return d
    }()
    
    lazy var input: AVCaptureDeviceInput = {
        guard let input: AVCaptureDeviceInput = try? .init(device: device) else { fatalError("输入流失败") }
        return input
    }()
    
    lazy var output: AVCaptureMetadataOutput = {
        let out: AVCaptureMetadataOutput = .init()
        out.setMetadataObjectsDelegate(self, queue: metadataOutputQueue)
//        out.rectOfInterest = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return out
    }()
    
    lazy var layer: AVCaptureVideoPreviewLayer = {
        let layer: AVCaptureVideoPreviewLayer = .init(session: session)
        return layer
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.metadataObjectTypes = [.aztec, .code128, .qr, .code39, .code39Mod43, .ean13, .code93, .ean8, .pdf417, .upce].filter { output.availableMetadataObjectTypes.contains($0) }
        }
        
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)
        session.commitConfiguration()
        sessionQueue.async { [weak self] in
            guard let this = self else { return }
            this.session.startRunning()
        }
    }
    internal func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for obj in metadataObjects where obj is AVMetadataMachineReadableCodeObject {
            print(obj)
            if let codeObject = obj as? AVMetadataMachineReadableCodeObject, let code = codeObject.stringValue {
                print(code)
            }
        }
    }
}
