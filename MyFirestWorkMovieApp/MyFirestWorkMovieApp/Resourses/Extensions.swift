//
//  Extensions.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 10.11.2022.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
