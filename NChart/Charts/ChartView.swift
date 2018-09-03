//
//  ChartView.swift
//  NChart
//
//  Created by Ngoc LE on 9/3/18.
//  Copyright © 2018 Ngoc LE. All rights reserved.
//

import UIKit

@IBDesignable class ChartView: UIView {
    
    let expenses = [120, 300, 150, 200, 350, 80, 100, 150, 220, 230, 300, 250]
    
    private struct Constants {
        static let margin: CGFloat = 10.0
        static let maxValue: Float = 500
        static let numberOfRows: Int = 10
        static let colorAlpha: CGFloat = 0.3
    }
    
    @IBInspectable var startColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var endColor: UIColor = .green {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawAxis(rect)
    }
    
    private func drawAxis(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
    
        let margin = Constants.margin
        let topBorder = Constants.margin
        let bottomBorder = Constants.margin
        let chartHeight = height - topBorder - bottomBorder
        let chartWidth = width - 2*Constants.margin
        let numberOfColumns = self.expenses.count
        let columnWidth = (chartWidth - margin*CGFloat(numberOfColumns))/CGFloat(numberOfColumns)
        let rowHeight = chartHeight/CGFloat(Constants.numberOfRows)
    
        let columnXPoint = { (column: Int) -> CGFloat in
            return margin + CGFloat(column)*columnWidth + (CGFloat(column) + 1)*margin
        }
        
        let columnYPoint = { (column: Int) -> CGFloat in
            let columnHeight = CGFloat(self.expenses[column])/CGFloat(Constants.maxValue)*chartHeight
            return columnHeight
        }
    
        let axisYPoint = { (graphPoint: Int) -> CGFloat in
        let y = CGFloat(graphPoint) * rowHeight
            return chartHeight + topBorder - y // Flip the graph
        }
    
        // set up the points line
        let linePath = UIBezierPath()
    
        for i in 1..<Constants.numberOfRows {
            // go to start of line
            linePath.move(to: CGPoint(x: columnXPoint(0), y: axisYPoint(i)))
            linePath.addLine(to: CGPoint(x: chartWidth, y: axisYPoint(i)))
        }
    
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
    
        linePath.lineWidth = 1.0
        linePath.stroke()
    
        let axisLinePath = UIBezierPath()
    
        axisLinePath.move(to: CGPoint(x: margin, y: axisYPoint(0)))
        axisLinePath.addLine(to: CGPoint(x: chartWidth + margin, y: axisYPoint(0)))
    
        axisLinePath.move(to: CGPoint(x: margin, y: axisYPoint(0)))
        axisLinePath.addLine(to: CGPoint(x: margin, y: axisYPoint(Constants.numberOfRows)))
    
        let axisColor = UIColor(white: 1.0, alpha: 1.0)
        axisColor.setStroke()
    
        axisLinePath.lineWidth = 1.0
        axisLinePath.stroke()
        
        let dataPath = UIBezierPath()
        for i in 0..<numberOfColumns {
            // go to start of line
            print(columnXPoint(i))
            dataPath.move(to: CGPoint(x: columnXPoint(i), y: axisYPoint(0)))
            dataPath.addLine(to: CGPoint(x: columnXPoint(i), y: columnYPoint(i)))
        }
        
        let dataColor = UIColor(white: 1.0, alpha: 1.0)
        dataColor.setStroke()
        
        dataPath.lineWidth = columnWidth
        dataPath.stroke()
    }
}
