//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct TwitterUser : Codable {
    var id : String
    var displayName : String = ""
    var userName : String = ""
    var followersCount : Int = 0
    var followingCount : Int = 0
    var createdOn : Date = Date()
    var bio : String = ""
    var avatarPath : String = ""
    var isUserOnboard : Bool = false
    
    enum CodingKeys: String, CodingKey {
           case id
           case displayName
           case userName
           case followersCount
           case followingCount
           case createdOn
           case bio
           case avatarPath
           case isUserOnboard
       }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(displayName, forKey: .displayName)
        try container.encode(userName, forKey: .userName)
        try container.encode(followersCount, forKey: .followersCount)
        try container.encode(followingCount, forKey: .followingCount)
        try container.encode(createdOn, forKey: .createdOn)
        try container.encode(bio, forKey: .bio)
        try container.encode(avatarPath, forKey: .avatarPath)
        try container.encode(isUserOnboard, forKey: .isUserOnboard)
           
       }
    
    init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          self.id = try container.decode(String.self, forKey: .id)
          self.displayName = try container.decode(String.self, forKey: .displayName)
          self.userName = try container.decode(String.self, forKey: .userName)
          self.followersCount = try container.decode(Int.self, forKey: .followersCount)
          self.followingCount = try container.decode(Int.self, forKey: .followingCount)
          self.createdOn = try container.decode(Date.self, forKey: .createdOn)
          self.bio = try container.decode(String.self, forKey: .bio)
          self.avatarPath = try container.decode(String.self, forKey: .avatarPath)
          self.isUserOnboard = try container.decode(Bool.self, forKey: .isUserOnboard)
      }
    
    init(from user: User) {
        self.id = user.uid
    }
    
    func toDictionary() throws -> [String: Any] {
         let encoder = JSONEncoder()
         encoder.dateEncodingStrategy = .iso8601

         let data = try encoder.encode(self)
         guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
             throw NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert to dictionary"])
         }
         
         return dictionary
     }
    
}
