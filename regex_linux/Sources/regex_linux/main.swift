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
}

// TODO: this still contains HTML entities
func stories(_ html: String) throws -> Array<String> {
  return Array(html
    .replace(regex: "^[\\s\\S]*BEGIN: StoryGrid", with: "")
    .replace(regex: "END: StoryGrid[\\s\\S]*$", with: "")
    .components(separatedBy: "alt=\"")
    .dropFirst()
    .map { $0.replace(regex: "\"[\\s\\S]*$", with: "") }
    .filter { $0 != "" }
    .dropLast()
  )
}

print(try! stories(contents))
