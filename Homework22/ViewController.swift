//
//  ViewController.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

import UIKit

class ViewController: UIViewController {
    private let service = MockService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "accountList", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                  return
              }

        do {
            let list = try JSONDecoder().decode([Account].self, from: data)
            print(list)
        } catch {
            print(error)
        }

    }


}
