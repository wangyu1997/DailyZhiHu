//
//	RootClass.swift
//
//	Create by yu wang on 10/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct StoryList{

	var date : String!
	var stories : [Story]!
	var topStories : [TopStory]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		date = dictionary["date"] as? String
		stories = [Story]()
		if let storiesArray = dictionary["stories"] as? [NSDictionary]{
			for dic in storiesArray{
				let value = Story(fromDictionary: dic)
				stories.append(value)
			}
		}
		topStories = [TopStory]()
		if let topStoriesArray = dictionary["top_stories"] as? [NSDictionary]{
			for dic in topStoriesArray{
				let value = TopStory(fromDictionary: dic)
				topStories.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
        let dictionary = NSMutableDictionary()
		if date != nil{
			dictionary["date"] = date
		}
		if stories != nil{
			var dictionaryElements = [NSDictionary]()
			for storiesElement in stories {
				dictionaryElements.append(storiesElement.toDictionary())
			}
			dictionary["stories"] = dictionaryElements
		}
		if topStories != nil{
			var dictionaryElements = [NSDictionary]()
			for topStoriesElement in topStories {
				dictionaryElements.append(topStoriesElement.toDictionary())
			}
			dictionary["top_stories"] = dictionaryElements
		}
		return dictionary
	}

}
