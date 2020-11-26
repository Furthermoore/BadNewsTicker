import Foundation

let filePath: String = Bundle.module.path(forResource: "most-depressing-stories", ofType: "html")!
let contents = String(decoding: try! Data(contentsOf: URL(fileURLWithPath: filePath)), as: UTF8.self)

extension String {
  func replace(regex: String, with: String) -> String {
    var copy = self.copy() as! String

    while let range = copy.range(of: regex, options: .regularExpression) {
      copy.replaceSubrange(range, with: with)
    }
  
    return copy
  }

  // doesn't cover all unicode entities, just predefined XML
  // https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references#Predefined_entities_in_XML
  func decodeXMLEntities() -> String {
    return self
      .replace(regex: "&quot;", with: "\"")
      .replace(regex: "&amp;", with: "&")
      .replace(regex: "&apos;", with: "'")
      // &apos; not universally used because not universally supported
      // https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references#Entities_representing_special_characters_in_XHTML
      .replace(regex: "&#39;", with: "'") 
      .replace(regex: "&lt;", with: "<")
      .replace(regex: "&gt;", with: ">")
  }
}

func stories(_ html: String) throws -> Array<String> {
  return Array(html
    .replace(regex: "^[\\s\\S]*BEGIN: StoryGrid", with: "")
    .replace(regex: "END: StoryGrid[\\s\\S]*$", with: "")
    .components(separatedBy: "alt=\"")
    .dropFirst()
    .map { $0.replace(regex: "\"[\\s\\S]*$", with: "") }
    .filter { $0 != "" }
    .dropLast()
    .map { $0.decodeXMLEntities() }
  )
}

for story in try! stories(contents) {
  print(story)
}
