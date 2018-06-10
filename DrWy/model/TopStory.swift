//
//	TopStory.swift
//
//	Create by yu wang on 10/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct TopStory{

	var gaPrefix : String!
	var id : Int!
	var image : String!
	var title : String!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		gaPrefix = dictionary["ga_prefix"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		title = dictionary["title"] as? String
		type = dictionary["type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
        let dictionary = NSMutableDictionary()
		if gaPrefix != nil{
			dictionary["ga_prefix"] = gaPrefix
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
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
