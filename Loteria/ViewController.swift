//
//  ViewController.swift
//  Loteria
//
//  Created by Anderson on 27/04/18.
//  Copyright © 2018 Anderson. All rights reserved.
//

import UIKit

//enum
enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

//operador criado
infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let ramdomNumber = Int(arc4random_uniform(UInt32(universe)) + 1)
        if !result.contains(ramdomNumber) {
            result.append(ramdomNumber)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {

    //Controles
    @IBOutlet weak var lbGametype: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showNumbers(for: .megasena)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showNumbers(for type: GameType) {
        //mostra o titulo de qual jogo megasena ou quina
        lbGametype.text = type.rawValue
        
        //chama o operador para gerar os numeros de acordo do jogo escolhido
        var game: [Int] = []
        switch type {
            case .megasena:
                game = 6>-<60
                balls.last!.isHidden = false
            case .quina:
                game = 5>-<80
                balls.last!.isHidden = true
        }
        
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
		
    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
            case 0:
                showNumbers(for: .megasena)
            default:
                showNumbers(for: .quina)
        }
    }
}

