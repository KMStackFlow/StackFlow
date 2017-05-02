//
//  AspectFillImageView.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 5/2/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import AppKit

class AspectFillImageView: NSImageView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        super.imageScaling = .scaleAxesIndependently
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.imageScaling = .scaleAxesIndependently
    }
    
    override var imageScaling: NSImageScaling {
        get {
            return super.imageScaling
        }
        
        set {
            super.imageScaling = .scaleAxesIndependently
        }
    }
    
    override var image: NSImage? {
        get {
            return super.image
        }
        
        set {
            guard let newImage = newValue else {
                super.image = newValue
                return
            }
            
            let scaleToFillImage = NSImage(
            size: self.bounds.size, flipped: false) { (dstRect: NSRect) -> Bool in
                
                let imageSize = newImage.size
                let imageViewSize = self.bounds.size
                
                var newImageSize = imageSize
                
                let imageAspectRatio = imageSize.height / imageSize.width
                let imageViewAspectRatio = imageViewSize.height / imageViewSize.width
 
                if imageAspectRatio < imageViewAspectRatio {
                    // Image is more horizontal than the view. Image left and right borders need to be cropped.
                    newImageSize.width = imageSize.height / imageViewAspectRatio
                } else {
                    // Image is more vertical than the view. Image top and bottom borders need to be cropped.
                    newImageSize.height = imageSize.width * imageViewAspectRatio
                }
 
                let srcRect = NSRect(x: imageSize.width/2.0-newImageSize.width/2.0, y: imageSize.height/2.0-newImageSize.height/2.0, width: newImageSize.width, height: newImageSize.height)
                
                NSGraphicsContext.current()!.imageInterpolation = .high
                newImage.draw(in: dstRect,
                            from: srcRect,
                            operation: NSCompositingOperation.copy,
                            fraction: 1.0,
                            respectFlipped: true,
                            hints: [NSImageHintInterpolation: NSImageInterpolation.high])
 
                return true
            }
            scaleToFillImage.cacheMode = .never
            super.image = scaleToFillImage
        }
    }
}
