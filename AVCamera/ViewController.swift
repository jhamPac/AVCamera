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
    @IBOutlet weak var customView: UIView!
    
    @IBAction func takePhoto(sender: UIButton)
    {
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

