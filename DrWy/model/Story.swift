//
//	Story.swift
//
//	Create by yu wang on 12/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Story{

	var id : Int!
	var images : [String]!
	var title : String!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		id = dictionary["id"] as? Int
		images = dictionary["images"] as? [String]
		title = dictionary["title"] as? String
		type = dictionary["type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if id != nil{
			dictionary["id"] = id
		}
		if images != nil{
			dictionary["images"] = images
		}
		if title != nil{
			dictionary["title"] = title
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}