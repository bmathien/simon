//
//  ViewController.swift
//  simon
//
//  Created by teacher on 8/24/16.
//  Copyright © 2016 Mathien. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    @IBOutlet weak var view0: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet var backgroundview: UIView!
    @IBOutlet weak var startButton: UIButton!

    var buttonArray = [UIView]()
    var computerPattern = [Int]()
    var count = 1
    var index = 0
    var patternTrackr = 0
    var timer = Timer()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        buttonArray  = [view0, view1, view2, view3]
    }

    @IBAction func gameTapped(_ sender: AnyObject)
    {
        let selectedPoint = sender.location(in: view)

        for view in buttonArray
        {
            if view.frame.contains(selectedPoint)
            {
                if (view.tag == computerPattern[index]) && (count != computerPattern.count)
                {
                    print("keep going")
                    count += 1
                    index += 1
                    animateButton(view)
                }

                else if (view.tag == computerPattern[index]) && (count == computerPattern.count)
                {
                    print("correct pattern")
                    count = 1
                    index = 0
                    patternTrackr = 0
                    randomButtonAdd()
                    animateButton(view)
                    UIView.animate(withDuration: 0.10, delay: 0.105, options: UIViewAnimationOptions(), animations: {
                        self.view.backgroundColor = UIColor.lightGray
                        self.view.backgroundColor = UIColor.white

                        }, completion: nil)
                    let time = DispatchTime(DispatchTime.now()) + Double(1 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: time) {
                        self.showPattern()}
                }

                else
                {
                    print("game over")
                    computerPattern.removeAll()
                    count = 1
                    index = 0
                    patternTrackr = 0
                    startButton.isHidden = false
                    backgroundview.backgroundColor = UIColor.red
                    animateButton(view)
                }
            }
        }
    }

    @IBAction func startButtonPressed(_ sender: AnyObject)
    {
        randomButtonAdd()
        view.backgroundColor = UIColor.white
        showPattern()
    }

    func randomButtonAdd()
    {
        let randomIndex = Int(arc4random_uniform(UInt32(buttonArray.count)))
        computerPattern.append(randomIndex)
        startButton.isHidden = true
        print("match \(computerPattern)")
    }

    func animateButton(_ view: UIView)
    {
        UIView.animate(withDuration: 0.125, delay: 0.125, options: .curveLinear, animations: {
            view.alpha = 0.5
            view.alpha = 1.0
            }, completion: nil)
    }

    func showPattern()
    {
        if patternTrackr < computerPattern.count
        {
            UIView.animate(withDuration: 0.125, delay: 0.25, options: .curveLinear, animations: {
                self.buttonArray[self.computerPattern[self.patternTrackr]].alpha = 0.5
                self.buttonArray[self.computerPattern[self.patternTrackr]].alpha = 1.0
                }, completion: { (void) in self.addOne()
            })
            print("flash")
            print(patternTrackr)

        }
    }

    func addOne()
    {   print("addone fired")
        patternTrackr += 1
        showPattern()
    }


}



