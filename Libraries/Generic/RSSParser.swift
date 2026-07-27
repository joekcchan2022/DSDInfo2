//
//  RSSParser.swift
//  DSDInfo
//
//  Created by Joe Chan on 2/1/2026.
//

import Foundation
import SwiftUI

class RSSParser: NSObject, XMLParserDelegate {
    
    private var currentItem: [String: String]?
    private var currentElement: String?
    private var items: [[String: String]] = []
    
    func parseFeed(url: URL, completion: @escaping ([[String: String]]) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                /* Error */
                let _ = print("\(timestamp()) [Error] \(#function): Error loading RSS feed: \(error?.localizedDescription ?? "")")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            DispatchQueue.main.async {
                completion(self.items)
            }
        }.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            currentItem = [:]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentItem?[currentElement ?? ""] = string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let item = currentItem {
                items.append(item)
            }
            currentItem = nil
        }
        currentElement = nil
    }
}


