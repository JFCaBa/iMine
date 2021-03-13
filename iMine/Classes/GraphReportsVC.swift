//
//  GraphReportsVC.swift
//  iMine
//
//  Created by Jose Catala on 12/03/2021.
//

import UIKit
import SwiftChart
import ChartLegends

enum GraphType {
    case hashrate
    case payouts
}

class GraphReportsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var legendsView: ChartLegendsView!
    @IBOutlet weak var sliderGraph: UISlider!
    // MARK: - Ivars
    private var theTitle: String!
    private var graphType: GraphType! // To create the mining or the payouts chart
    
    // MARK: - ViewModels
    var viewModel: ReportsVM!
    
    // MARK: - Lifecycle
    static func customInit(title: String, viewModel: ReportsVM, type: GraphType) -> GraphReportsVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GraphReportsVC") as! GraphReportsVC
        vc.theTitle = title
        vc.viewModel = viewModel
        vc.graphType = type
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = theTitle
        self.sliderGraph.value = viewModel.sliderValue
        createChart()
    }
    
    // MARK: - Actions
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        viewModel.maxOfCols = Int(sender.value)
        createChart()
    }
    
    // MARK: - Public
    public func updateChart() {
        createChart()
    }
    
    // MARK: - Private
    fileprivate func createChart() {
        switch graphType {
        case .hashrate:
            createMiningChart()
        case .payouts:
            createPayoutsChart()
        default: break
        }
    }
    
    fileprivate func createMiningChart() {
        chart.removeAllSeries()
        legendsView.setLegends(.circle(radius: 7), [
            (text: "Actual", color: UIColor.theBlue),
            (text: "Average", color: UIColor.theGreen),
            (text: "Reported", color: UIColor.theOrange)
        ])
        
        let actual = ChartSeries(viewModel.actual)
        actual.color = UIColor.theBlue

        let average = ChartSeries(viewModel.average)
        average.color = UIColor.theGreen

        let reported = ChartSeries(viewModel.reported)
        reported.color = UIColor.theOrange
        
        chart.showXLabelsAndGrid = false
        chart.add([actual, average, reported])
    }
    
    fileprivate func createPayoutsChart() {
        chart.removeAllSeries()
        let actual = ChartSeries(viewModel.payout)
        actual.color = UIColor.theBlue
        actual.area = true
        chart.add([actual])
    }
}
