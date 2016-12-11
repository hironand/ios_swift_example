//
//  ViewController.swift
//  CameraExample
//
//  Created by hironand on 2016/12/11.
//  Copyright © 2016年 hironand. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    // Component
    @IBOutlet weak var shutterBtn: UIButton!
    @IBOutlet weak var videoPreviewView: UIView!
    @IBOutlet weak var photoCaptureView: UIImageView!
    
    // Flag
    var shutterBtnOn = false
    
    // Camera
    var session: AVCaptureSession?
    var imageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //----------
        // Camera
        //----------
        self.session = AVCaptureSession()
        self.imageOutput = AVCapturePhotoOutput()
        self.session?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        dof{
            
        }
        
        // set preview layer
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        guard let _videoPreviewLayer = videoPreviewLayer else {
            return
        }
        _videoPreviewLayer.masksToBounds = true
        _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoPreviewView.layer.addSublayer(_videoPreviewLayer)
        
        // set input
        
        let input = try! AVCaptureDeviceInput(device: device)
        self.session?.addInput(input)
        
        // set output
        
        self.session?.addOutput(self.imageOutput)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //------------------
    // Handle Event
    //------------------
    @IBAction func onTouchShutterBtn(_ sender: Any) {
        // self.playButton.setImage(UIImage(named: "play_on"), forState: UIControlState.Normal)
        if self.shutterBtnOn {
            self.shutterBtn.setImage(UIImage(named: "camera_btn"), for: UIControlState.normal)
            self.shutterBtnOn = false
        } else {
            self.shutterBtn.setImage(UIImage(named: "camera_btn_on"), for: UIControlState.normal)
            self.shutterBtnOn = true
            
            self.capturePhoto()
        }
    }
    
    //------------------
    // Handle Camera
    //------------------
    func capturePhoto(){
        let setting = AVCapturePhotoSettings()
        setting.flashMode = .auto
        setting.isAutoStillImageStabilizationEnabled = true
        setting.isHighResolutionPhotoEnabled = false
        
        self.imageOutput?.capturePhoto(with: setting, delegate: self)
    }
    
    //------------------------------------
    // AVCapturePhotoCaptureDelegate
    //------------------------------------
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let photoSampleBuffer = photoSampleBuffer {
            // JPEG形式で画像データを取得
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            let image = UIImage(data: photoData!)
            self.photoCaptureView.image = image
        }
    }
    
}

