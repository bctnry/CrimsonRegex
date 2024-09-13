# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import std/options

import CrimsonRegex

suite "regexpr \"abc\"":
  let r = compileRegex("abc")
    
  test "should match \"abc\"":
    let matchres = r.match("abc")
    check (matchres != nil)
    check (matchres.matchedString == "abc")

  test "should not match \"abd\"":
    let matchres = r.match("abd")
    check (matchres == nil)
      
suite "regexpr \"a*\"":
  let r = "a*".compileRegex
      
  test "should match \"\"":
    var matchRes = r.match("")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"a\"":
    var matchRes = r.match("a")
    check (matchRes != nil)
    check (matchRes.matchedString == "a")

  test "should match \"aa\"":
    var matchRes = r.match("aa")
    check (matchRes != nil)
    check (matchRes.matchedString == "aa")

  test "should match \"aaa\"":
    var matchRes = r.match("aaa")
    check (matchRes != nil)
    check (matchRes.matchedString == "aaa")

  test "should match \"aab\" and return \"aa\"":
    var matchRes = r.match("aab")
    check (matchRes != nil)
    check (matchRes.matchedString == "aa")

  test "should match \"bba\" and return \"\"":
    var matchRes = r.match("bba")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

suite "regexpr \"a+\"":
  let r = "a+".compileRegex
      
  test "should not match \"\"":
    var matchRes = r.match("")
    check (matchRes == nil)

  test "should match \"a\"":
    var matchRes = r.match("a")
    check (matchRes != nil)
    check (matchRes.matchedString == "a")

  test "should match \"aa\"":
    var matchRes = r.match("aa")
    check (matchRes != nil)
    check (matchRes.matchedString == "aa")

  test "should match \"aaa\"":
    var matchRes = r.match("aaa")
    check (matchRes != nil)
    check (matchRes.matchedString == "aaa")

  test "should match \"aab\" and return \"aa\"":
    var matchRes = r.match("aab")
    check (matchRes != nil)
    check (matchRes.matchedString == "aa")

  test "should not match \"bba\"":
    var matchRes = r.match("bba")
    check (matchRes == nil)

suite "regexpr \"ab?\"":
  let r = "ab?".compileRegex

  test "should match \"a\"":
    var matchRes = r.match("a")
    check (matchRes != nil)
    check (matchRes.matchedString == "a")

  test "should match \"ab\"":
    var matchRes = r.match("ab")
    check (matchRes != nil)
    check (matchRes.matchedString == "ab")

  test "should match \"ac\" and return \"a\"":
    var matchRes = r.match("ac")
    check (matchRes != nil)
    check (matchRes.matchedString == "a")
      
suite "regexpr \"a*?\"":
  let r = "a*?".compileRegex
      
  test "should match \"\"":
    var matchRes = r.match("")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"a\"":
    var matchRes = r.match("a")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"aa\" but the result should be \"\"":
    var matchRes = r.match("aa")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"aaa\" but the result should be \"\"":
    var matchRes = r.match("aaa")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"aab\" and return \"\"":
    var matchRes = r.match("aab")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"bba\" and return \"\"":
    var matchRes = r.match("bba")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

      
suite "regexpr \"a*?\"":
  let r = "a*?".compileRegex
      
  test "should match \"\"":
    var matchRes = r.match("")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"a\"":
    var matchRes = r.match("a")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"aa\" but the result should be \"\"":
    var matchRes = r.match("aa")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"aaa\" but the result should be \"\"":
    var matchRes = r.match("aaa")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"aab\" and return \"\"":
    var matchRes = r.match("aab")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

  test "should match \"bba\" and return \"\"":
    var matchRes = r.match("bba")
    check (matchRes != nil)
    check (matchRes.matchedString == "")

suite "regexpr \"ab??\"":
  let r = "ab??".compileRegex

  test "should match \"a\"":
    var matchRes = r.match("a")
    check (matchRes != nil)
    check (matchRes.matchedString == "a")

  test "should match \"ab\" but return \"a\"":
    var matchRes = r.match("ab")
    check (matchRes != nil)
    check (matchRes.matchedString == "a")

suite "regexpr \"a(b|c|d)e\"":
  let r = "a(b|c|d)e".compileRegex

  test "should match \"abe\"":
    var matchRes = r.match("abe")
    check (matchRes != nil)
    check (matchRes.matchedString == "abe")
    check (matchRes.groups().len == 2)
    check (matchRes.groups()[1] == "b")

  test "should match \"ace\"":
    var matchRes = r.match("ace")
    check (matchRes != nil)
    check (matchRes.matchedString == "ace")
    check (matchRes.groups().len == 2)
    check (matchRes.groups()[1] == "c")

  test "should match \"ade\"":
    var matchRes = r.match("ade")
    check (matchRes != nil)
    check (matchRes.matchedString == "ade")
    check (matchRes.groups().len == 2)
    check (matchRes.groups()[1] == "d")

  test "should not match \"aee\"":
    var matchRes = r.match("aee")
    check (matchRes == nil)

  test "should not match \"ae\"":
    var matchRes = r.match("ae")
    check (matchRes == nil)
    
suite "regexpr \"a[bcd]e\"":
  let r = "a[bcd]e".compileRegex

  test "should match \"abe\"":
    var matchRes = r.match("abe")
    check (matchRes != nil)
    check (matchRes.matchedString == "abe")

  test "should match \"ace\"":
    var matchRes = r.match("ace")
    check (matchRes != nil)
    check (matchRes.matchedString == "ace")

  test "should match \"ade\"":
    var matchRes = r.match("ade")
    check (matchRes != nil)
    check (matchRes.matchedString == "ade")

  test "should not match \"aee\"":
    var matchRes = r.match("aee")
    check (matchRes == nil)

  test "should not match \"ae\"":
    var matchRes = r.match("ae")
    check (matchRes == nil)

suite "regexpr \"a[bcd]+e\"":
  let r = "a[bcd]+e".compileRegex

  test "should match \"abe\"":
    var matchRes = r.match("abe")
    check (matchRes != nil)
    check (matchRes.matchedString == "abe")

  test "should match \"ace\"":
    var matchRes = r.match("ace")
    check (matchRes != nil)
    check (matchRes.matchedString == "ace")

  test "should match \"ade\"":
    var matchRes = r.match("ade")
    check (matchRes != nil)
    check (matchRes.matchedString == "ade")

  test "should match \"abcdcbe\"":
    var matchRes = r.match("abcdcbe")
    check (matchRes != nil)
    check (matchRes.matchedString == "abcdcbe")

  test "should not match \"aee\"":
    var matchRes = r.match("aee")
    check (matchRes == nil)

  test "should not match \"ae\"":
    var matchRes = r.match("ae")
    check (matchRes == nil)

suite "regexpr \"(?:a*|b)\"":
  let r = "(?:a*|b)".compileRegex

  test "should match \"a\"":
    var matchRes = r.match("a")
    check (matchRes != nil)
    check (matchRes.matchedString == "a")

  test "should match \"\"":
    var matchRes = r.match("b")
    check (matchRes != nil)
    check (matchRes.matchedString == "")
        
  test "shouldn match \"\"":
    var matchRes = r.match("c")
    check (matchRes != nil)
    check: matchRes.matchedString == ""
        
suite "regexpr \".\"":
  let r = ".".compileRegex
  
  test "should match \"a\"":
    var matchRes = r.match("a")
    check: matchRes != nil
    check: matchRes.matchedString == "a"
  test "should match \"b\"":
    var matchRes = r.match("b")
    check: matchRes != nil
    check: matchRes.matchedString == "b"
  test "should match \"c\"":
    var matchRes = r.match("c")
    check: matchRes != nil
    check: matchRes.matchedString == "c"
  test "shouldn't match empty string":
    var matchRes = r.match("")
    check: matchRes == nil

suite "regex \"a{3}\"":
  let r = "a{3}".compileRegex

  test "should match \"aaa\"":
    var matchRes = r.match("aaa")
    check: matchRes != nil
    check: matchRes.matchedString == "aaa"

  test "shouldn't match \"aa\"":
    var matchRes = r.match("aa")
    check: matchRes == nil

  test "should match \"aaaa\"":
    var matchRes = r.match("aaaa")
    check: matchRes != nil
    check: matchRes.matchedString == "aaa"

  test "shouldn't match \"abaa\"":
    var matchRes = r.match("abaa")
    check: matchRes == nil

suite "regex \"a{,3}\"":
  let r = "a{,3}".compileRegex

  test "should match \"aaa\"":
    var matchRes = r.match("aaa")
    check: matchRes != nil
    check: matchRes.matchedString == "aaa"

  test "should match \"aa\"":
    var matchRes = r.match("aa")
    check: matchRes != nil
    check: matchRes.matchedString == "aa"

  test "should match \"\"":
    var matchRes = r.match("")
    check: matchRes != nil
    check: matchRes.matchedString == ""

  test "should match \"baa\"":
    var matchRes = r.match("baa")
    check: matchRes != nil
    check: matchRes.matchedString == ""

suite "regex \"a{2,}\"":
  let r = "a{2,}".compileRegex

  test "should match \"aaa\"":
    var matchRes = r.match("aaa")
    check: matchRes != nil
    check: matchRes.matchedString == "aaa"

  test "should match \"aa\"":
    var matchRes = r.match("aa")
    check: matchRes != nil
    check: matchRes.matchedString == "aa"

  test "shouldn't match \"\"":
    var matchRes = r.match("")
    check: matchRes == nil

  test "shouldn't match \"a\"":
    var matchRes = r.match("a")
    check: matchRes == nil

  test "shouldn't match \"baa\"":
    var matchRes = r.match("baa")
    check: matchRes == nil


suite "regex \"a{2,4}\"":
  let r = "a{2,4}".compileRegex

  test "should match \"aaa\"":
    var matchRes = r.match("aaa")
    check: matchRes != nil
    check: matchRes.matchedString == "aaa"

  test "should match \"aa\"":
    var matchRes = r.match("aa")
    check: matchRes != nil
    check: matchRes.matchedString == "aa"

  test "shouldn't match \"\"":
    var matchRes = r.match("")
    check: matchRes == nil

  test "shouldn't match \"a\"":
    var matchRes = r.match("a")
    check: matchRes == nil

  test "shouldn't match \"baa\"":
    var matchRes = r.match("baa")
    check: matchRes == nil

  test "should match \"aaaaaa\" but matchedString should only have 4 \"a\"s":
    var matchRes = r.match("aaaaaa")
    check: matchRes != nil
    check: matchRes.matchedString == "aaaa"


