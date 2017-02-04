//
//  ViewController.swift
//  MetalExample
//
//  Created by hironand on 2017/02/04.
//  Copyright © 2017年 appirca. All rights reserved.
//
//  Ref) Tutorial
//  https://www.raywenderlich.com/77488/ios-8-metal-tutorial-swift-getting-started
//

import UIKit
import Metal
import QuartzCore


class ViewController: UIViewController {
    
    var device: MTLDevice?
    var metalLayer: CAMetalLayer?
    var vertexBuffer: MTLBuffer?
    var pipelineState: MTLRenderPipelineState?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.device = MTLCreateSystemDefaultDevice()
        
        self.metalLayer = CAMetalLayer()
        self.metalLayer?.device = device!
        self.metalLayer?.pixelFormat = .bgra8Unorm
        self.metalLayer?.framebufferOnly = true
        self.metalLayer?.frame = view.layer.frame
        self.view.layer.addSublayer(metalLayer!)
        
        // Triangle
        let vertexData:[Float] = [0.0, 1.0, 0.0,
                                  -1.0, -1.0, 0.0,
                                  1.0, -1.0, 0.0]
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        let mtlResOptions: MTLResourceOptions = MTLResourceOptions()
        self.vertexBuffer = device?.makeBuffer(bytes: vertexData, length: dataSize, options: mtlResOptions)
        
        
        let defaultLibrary = device?.newDefaultLibrary()
        let fragmentProgram = defaultLibrary!.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary!.makeFunction(name: "basic_vertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments.subscriping().pixelFormat = .BGRA8Unorm
        
        do {
            try pipelineState = device?.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch pipelineError {
            print("Failed to create pipeline state, error \(pipelineError)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

