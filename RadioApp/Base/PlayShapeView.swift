//
//  CustomImageView.swift
//  RadioApp
//
//  Created by Natalia on 06.08.2024.
//
import UIKit

final class PlayShapeView: UIView {
    var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
        super.init(frame: .zero)
        self.backgroundColor = .clear
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), let image = image else { return }
        
        let path = UIBezierPath()
        let width = rect.width
        let height = rect.height
        
        let midX = rect.width / 2
        let midY = rect.height / 2
        let third = rect.height / 3
        
        path.move(to: CGPoint(x: midX, y: third))
        
        path.addQuadCurve(
            to: CGPoint(x: 0, y: midY),
            controlPoint: CGPoint(x: 0, y: 0)
        )
        path.addQuadCurve(
            to: CGPoint(x: midX, y: third * 2),
            controlPoint: CGPoint(x: 0, y: height)
        )
        path.addQuadCurve(
            to: CGPoint(x: midX, y: third),
            controlPoint: CGPoint(x: width * 0.7, y: midY)
        )
        
        path.close()
        
        context.addPath(path.cgPath)
        context.clip()
        
        image.draw(in: rect)
    }
}
