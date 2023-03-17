//
//  Model.swift
//  Week9_Project
//
//  Created by Rania Arbash on 2023-03-17.
//

import Foundation

class Course : Codable{
    var id : Int
    var courseCode: String
    var courseName : String
    var image : String
    
    init(){
        
        id = 0
        courseCode = ""
        courseName = ""
        image = ""
    }
}

class StudentInfo : Codable {
    var student: String = ""
    var version : String = ""
    var count : Int = 0
    var data : [Course] = [Course]()
    
}


