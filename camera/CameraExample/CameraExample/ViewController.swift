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
    var isShutterBtnOn = false
    
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
        let input = try! AVCaptureDeviceInput(device: device)
        if(self.session!.canAddInput(input)){
            self.session?.addInput(input)
            
            if(self.session!.canAddOutput(self.imageOutput)){
                self.session?.addOutput(self.imageOutput)
                self.session?.startRunning()
                
                self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                self.videoPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                
                self.videoPreviewView.layer.addSublayer(self.videoPreviewLayer!)
                
                // size setting
                self.videoPreviewLayer?.position = CGPoint(x: self.videoPreviewView.frame.width,
                                                           y: self.videoPreviewView.frame.height)
                self.videoPreviewView.bounds = self.videoPreviewView.frame
            }
        }

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
        if self.isShutterBtnOn {
            self.shutterBtnOff()
        } else {
            self.shutterBtnOn()
            
            self.capturePhoto()
        }
    }
    
    private func shutterBtnOn(){
        self.shutterBtn.setImage(UIImage(named: "camera_btn_on"), for: UIControlState.normal)
        self.isShutterBtnOn = true
    }
    
    private func shutterBtnOff(){
        self.shutterBtn.setImage(UIImage(named: "camera_btn"), for: UIControlState.normal)
        self.isShutterBtnOn = false
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
            
//            image.position = CGPoint(x: self.photoCaptureView.frame.width,
//                                     y: self.photoCaptureView.frame.height)
//            self.image.bounds = self.photoCaptureView.frame
            
            self.photoCaptureView.image = image
            
            self.shutterBtnOff()
        }
    }
    
}

