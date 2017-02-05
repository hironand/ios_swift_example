//
//  ViewController.swift
//  MetalExample
//
//  Created by hironand on 2017/02/04.
//  Copyright © 2017年 appirca. All rights reserved.
//
//  Ref) Tutorial
//  https://www.raywenderlich.com/77488/ios-8-metal-tutorial-swift-getting-started
//  Fix(Swift3)
//  https://github.com/rivertea/HelloMetal
//

import UIKit
import Metal
import QuartzCore


class ViewController: UIViewController {
    
    var device: MTLDevice?
    var metalLayer: CAMetalLayer?
    var vertexBuffer: MTLBuffer?
    var pipelineState: MTLRenderPipelineState?
    var commandQueue: MTLCommandQueue?
    var timer: CADisplayLink?

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
        self.vertexBuffer = device?.makeBuffer(bytes: vertexData, length: dataSize, options: [])
        
        
        let defaultLibrary = device?.newDefaultLibrary()
        let fragmentProgram = defaultLibrary!.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary!.makeFunction(name: "basic_vertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            try pipelineState = device?.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let pipelineError as NSError {
            print("Failed to create pipeline state, error \(pipelineError)")
        }
        
        self.commandQueue = device?.makeCommandQueue()
        
        self.timer = CADisplayLink(target: self, selector: #selector(self.gameloop))
        timer?.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
    }
    
    func gameloop(){
        autoreleasepool(invoking: {
            self.render()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func render() {
        if let drawable = metalLayer?.nextDrawable(){
            let renderPassDescriptor = MTLRenderPassDescriptor()
            renderPassDescriptor.colorAttachments[0].texture = drawable.texture
            renderPassDescriptor.colorAttachments[0].loadAction = .clear
            renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0,
                                                                                green: 104.0/255.0,
                                                                                blue: 5.0/255.0,
                                                                                alpha: 1.0)
            
            let commandBuffer = commandQueue?.makeCommandBuffer()
            let renderEncoderOpt = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
            if let renderEncoder = renderEncoderOpt {
                renderEncoder.setRenderPipelineState(pipelineState!)
                renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, at: 0)
                renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
                renderEncoder.endEncoding()
            }
            
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }

}

