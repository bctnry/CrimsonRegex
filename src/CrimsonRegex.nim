# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

import CrimsonRegex/parser
import CrimsonRegex/instrdef
import CrimsonRegex/regexdef
import CrimsonRegex/regexcompile
import CrimsonRegex/vm
export `$`, groups, MatchResult, matchedString

type
  RegexObject* = seq[Instr]
  
proc compileRegex*(x: string): RegexObject =
  let parsed: Regex = x.parse()
  echo parsed
  let compiled: RegexObject = parsed.compileRegex()
  echo compiled
  compiled

proc match*(x: RegexObject, str: string): MatchResult =
  x.runVM(str, 0)

  

