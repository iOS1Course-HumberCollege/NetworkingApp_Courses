//
//  ViewController.swift
//  Week9_Project
//
//  Created by Rania Arbash on 2023-03-17.
//

import UIKit

class ViewController: UIViewController , NetworkingDelegate{
 
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var counter: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var courseText: UILabel!
    @IBOutlet weak var mainDetails: UITextView!
    
    var objectFromAPI = (UIApplication.shared.delegate as! AppDelegate).StudentInfoFromAPI
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkingManager.shared.getStudentInfo()
        NetworkingManager.shared.delegate = self
        
       
    }
    
    func updateUI(i: Int){
        mainDetails.text = "Student Name :\(objectFromAPI.student)"
        courseText.text = "\(objectFromAPI.data[i].courseName) \(objectFromAPI.data[i].courseCode)"
        counter.text = "Course: \(i + 1)"
        let queue = DispatchQueue.init(label: "myQ")
        queue.async {
            let urlObject = URL(string: self.objectFromAPI.data[i].image)
            do {
                let imageData = try Data(contentsOf: urlObject!)
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: imageData)
                }
            }catch {
                print(error)
            }
            
        }
        
    }
    
    @IBAction func previous(_ sender: Any) {
        if index > 0 {
            index -= 1
            updateUI(i: index)
        }
    }
   
    func networkingDidFinishWithData(data: StudentInfo) {
        loadingIndicator.startAnimating()
//        Thread.sleep(forTimeInterval: 3)

        (UIApplication.shared.delegate as! AppDelegate).StudentInfoFromAPI = data
        objectFromAPI = data
        updateUI(i: 0)
        loadingIndicator.stopAnimating()

    }
    
    func networkingDidFinishWithError() {
        mainDetails.text = "Student Name : No Data Available"
        courseText.text = "No Data"
        counter.text = "Course: No Data"
        image.image = UIImage(named: "noCourse")
    }
    
    
    @IBAction func next(_ sender: Any) {
        if index < objectFromAPI.count - 1 {
            index += 1
            updateUI(i: index)
        }
        
    }
}

