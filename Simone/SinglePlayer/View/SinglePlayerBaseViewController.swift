//
//  SinglePlayerBaseViewController.swift
//  Simone
//
//  Created by Nicola on 14/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class SinglePlayerBaseViewController: SquaredViewController {

    @IBOutlet weak var lblGoBack: UILabel!
    @IBOutlet internal var centralFab: SimoneFabButton!
    @IBOutlet internal var scoreButton: SimoneFabButton!
    
    private var buttons: [SimoneColorEnum: UIButton] = [:]
    private var key: String = ""
    private var whichPlayer: String = ""
    
    internal var presenter: GameViewPresenterProtocol!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func renderYouLost(with score: Int) {
        centralFab.isEnabled = true
        centralFab.isUserInteractionEnabled = true
        centralFab.backgroundColor = SColors.redLoose
        
        scoreButton.setTitle("\(score)", for: .normal)
        scoreButton.isHidden = false
    }
    
    public func updateCentralTextView(with text: String) {
        centralFab.setTitle(text, for: .normal)
        //animation
    }
    
    public func blinkDelayed(color: SimoneColorEnum) {
        guard let button = buttons[color] else { return }
        button.alpha = 0.4
        //play sound
        presenter.blinkDelayed(turn: .cpu, color: color)
    }
    
    public func resetButton(for color: SimoneColorEnum) {
        guard let button = buttons[color] else { return }
        button.alpha = 1.0
    }
    
    internal func prepareViewsForGame() {
        scoreButton.isHidden = true
        centralFab.isEnabled = false
        centralFab.isUserInteractionEnabled = false
        
        centralFab.setTitle("", for: .normal)
        centralFab.setTitleColor(SColors.greyFont, for: .normal)
        centralFab.backgroundColor = SColors.buttonBackground
    }
    
    
    public func setup() {
        presenter = GameViewPresenter(viewController: self, type: .easy) // TODO
        buttons = [.green:  btnFirst,
                   .red:    btnSecond,
                   .yellow: btnThird,
                   .blue:   btnFourth]
    }
    
    public func saveScore() {
        centralFab.setTitle("play\nagain", for: .normal)
        centralFab.setTitleColor(.white, for: .normal)
    }
    
    public func prepareGame() {
        presenter.prepareGame(message: MStartGameVsCpu())
    }
    
    public func swapButtonPositions() {
        
    }
    
    @IBAction func goBack() {
        
        if presenter.tapToBegin {
            performUnwindSegue()
            return
        }
        
        let alert = UIAlertController(title: "Are you letting Simone win?",
                                      message: "Your final score will be considered \(presenter.finalScore).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
            self?.saveScore()
            self?.presenter.endGame()
            self?.performUnwindSegue()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func performUnwindSegue() {
        self.performSegue(withIdentifier: "unwindSinglePlayer", sender: self)
    }
    

}
