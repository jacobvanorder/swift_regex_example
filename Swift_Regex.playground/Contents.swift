import UIKit
import RegexBuilder

let internalURL = "etsy://listing/1291264056"
let externalURL = "https://www.etsy.com/listing/1291264056/nicolas-cage-pillow-nicolas-cage-pillow?ga_order=most_relevant&ga_search_type=all"
let externalInternationalURL = "https://www.etsy.com/en-us/listing/1291264056/nicolas-cage-pillow-nicolas-cage-pillow?ga_order=most_relevant&ga_search_type=all"

// String based
let stringRegex = try! Regex("\\/listing\\/\\d+")
// Regex<AnyRegexOutput>
if let stringRegexMatch = externalURL.firstMatch(of: stringRegex) {
    print(stringRegexMatch.0) // "/listing/1291264056\n"
}

// Other string based
let easierToReadStringRegex = try! Regex(#"\/listing\/\d+"#)
// Still Regex<AnyRegexOutput>
if let clearerStringRegexMatch = externalURL.firstMatch(of: easierToReadStringRegex) {
    print(clearerStringRegexMatch.0 as Any) // "/listing/1291264056\n"
}

// String based with capture
let stringWithCaptureRegex = try! Regex(#"\/listing\/(\d+)"#)
// Regex<AnyRegexOutput>
if let stringWithCaptureRegexMatch = externalURL.firstMatch(of: stringWithCaptureRegex) {
    print(stringWithCaptureRegexMatch.0 as Any) // "/listing/1291264056\n"
    print(stringWithCaptureRegexMatch.first?.substring as Any) // "/listing/1291264056"
    print(stringWithCaptureRegexMatch.last?.substring as Any) // "1291264056"
}

// String based with NAMED capture
let stringWithNamedCaptureRegex = try! Regex(#"\/listing\/(?<listing>\d+)"#)
// Regex<AnyRegexOutput>
if let stringWithNamedCaptureRegexMatch = externalURL.firstMatch(of: stringWithNamedCaptureRegex) {
    print(stringWithNamedCaptureRegexMatch.0 as Any) // "/listing/1291264056\n"
    if let listingIDMatch = stringWithNamedCaptureRegexMatch.output["listing"]?.value {
        print(listingIDMatch) // "1291264056\n"
    }
}

// Regex Literal
let literalRegex = /\/listing\/(\d+)/
// Regex<(Substring, Substring)>
if let literalRegexMatch = externalURL.firstMatch(of: literalRegex) {
    print(literalRegexMatch.0) // "/listing/1291264056\n"
    print(literalRegexMatch.1) // "1291264056\n"
}

// Regex Literal
let longerLiteralRegex = /\/listing\/(\d+)\/somethingElse\/(\d+)/
// Regex<(Substring, Substring, Substring)>
if let longerLiteralRegexMatch = externalURL.firstMatch(of: longerLiteralRegex) {
    // Don't Worry, Doesn't Match
    print(longerLiteralRegexMatch.0)
    print(longerLiteralRegexMatch.1)
}

// Regex Literal Named
let literalNamedRegex = /\/listing\/(?<listing>\d+)/
// Regex<(Substring, listing: Substring)>
if let literalNamedRegexMatch = externalURL.firstMatch(of: literalNamedRegex) {
    print(literalNamedRegexMatch.0)
    print(literalNamedRegexMatch.listing)
}

// Regex Builder
let builtRegex = Regex {
    "/listing/"
    Capture {
        OneOrMore(.digit)
    }
}
// Regex<(Substring, Substring)>
if let builtRegexMatch = externalURL.firstMatch(of: builtRegex) {
    print(builtRegexMatch.0)
    print(builtRegexMatch.1)
}



