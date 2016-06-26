//
//  ViewController.swift
//  AVCamera
//
//  Created by Ace_Rimmer on 6/26/16.
//  Copyright © 2016 HackTacoma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previewBox: UIView!
    
    
    @IBAction func takePhoto(sender: UIButton)
    {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo)
        {
            videoConnection.videoOrientation = .Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection) { [unowned self] (sampleBuffer, error) in
                
                if sampleBuffer != nil
                {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, .RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    self.imageView.image = image
                    
                }
                
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var input: AVCaptureInput?
        var checkError: NSError?
        
        do
        {
            input = try AVCaptureDeviceInput(device: backCamera)
        }
        catch let error1 as NSError
        {
            checkError = error1
            input = nil
        }
        
        if checkError == nil && captureSession!.canAddInput(input!)
        {
            captureSession!.addInput(input!)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if captureSession!.canAddOutput(stillImageOutput!)
            {
                captureSession!.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                previewLayer!.connection?.videoOrientation = .Portrait
                previewBox.layer.addSublayer(previewLayer!)
                
                captureSession!.startRunning()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        // your frame equals my bounds; inside
        
        previewLayer!.frame = previewBox.bounds
    }
}

