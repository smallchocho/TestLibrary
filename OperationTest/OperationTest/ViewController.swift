//
//  ViewController.swift
//  OperationTest
//
//  Created by 黃聖傑 on 2018/10/22.
//  Copyright © 2018 seaFoodBon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var queue:OperationQueue?
    var operationA:BlockOperation!
    var operationB:BlockOperation!
    var operationC:BlockOperation!
    @IBAction func clickedStartButton(_ sender: UIButton) {
        createAndStartOperation()
    }
    
    @IBAction func clickedEndButton(_ sender: Any) {
        queue?.cancelAllOperations()
    }
    @IBAction func pauseAction(_ sender: UIButton) {
        guard let isSuspended = queue?.isSuspended else{ return }
        if isSuspended { queue?.isSuspended = false }
        queue?.isSuspended = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func createAndStartOperation(){
        operationA = BlockOperation {
            print("開始任務a,\(Thread.current)")
            sleep(1)
            print("結束任務a,\(Thread.current)")
        }
        operationB = BlockOperation {
            print("開始任務b,\(Thread.current)")
            sleep(1)
            print("結束任務b,\(Thread.current)")
        }
        operationC = BlockOperation {
            print("開始任務c,\(Thread.current)")
            sleep(1)
            print("結束任務c,\(Thread.current)")
        }
        queue = OperationQueue()
        queue?.maxConcurrentOperationCount = 3
        operationA.addDependency(operationB)
        operationB.addDependency(operationC)
        queue?.addOperation(operationA)
        queue?.addOperation(operationB)
        queue?.addOperation(operationC)
        
    }
}

