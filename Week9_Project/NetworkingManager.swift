//
//  NetworkingManager.swift
//  Week9_Project
//
//  Created by Rania Arbash on 2023-03-17.
//

import Foundation

protocol NetworkingDelegate {
    
    func networkingDidFinishWithData(data : StudentInfo)
    func networkingDidFinishWithError()
}

class NetworkingManager {
    
    var delegate : NetworkingDelegate? = nil
    
    static var shared = NetworkingManager()
    
    func getStudentInfo(){
        
        let urlString = "https://raw.githubusercontent.com/RaniaArbash/Networking_IOS/main/courses_data.json"
        
        if let urlObject = URL(string: urlString){
            
            let task = URLSession.shared.dataTask(with: urlObject) { data, response, error in
                if error != nil {
                            // notify the listener
                    DispatchQueue.main.async {
                        self.delegate?.networkingDidFinishWithError()
                    }
                    return
                        }
                guard let httpResponse = response as? HTTPURLResponse,
                           (200...299).contains(httpResponse.statusCode) else {
                    
                    DispatchQueue.main.async {
                        self.delegate?.networkingDidFinishWithError()

                    }

                    return
                       }
                
                let decoder = JSONDecoder()
                do {
                    let stdObject = try decoder.decode(StudentInfo.self, from: data!)
                    print(stdObject.student)
                 
                    DispatchQueue.main.async {
                        self.delegate?.networkingDidFinishWithData(data: stdObject)
                    }

                }catch {
                    
                }
            }
            task.resume()
            
            
            
        }else {
            
            
            
        }
        
        
    }
    
}
