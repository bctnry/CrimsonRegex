# NOTE: Generated using Crimson. DO NOT DIRECTLY EDIT THIS (UNLESS YOU KNOW WHAT YOU'RE DOING)
import std/options
import std/unicode
import instrdef

type
  MatchResult* = ref object
    st*: uint
    e*: uint
    str*: string
    save: array[20, int]

proc groups*(x: MatchResult): seq[string] =
  var res: seq[string] = @[]
  for i in 0..<10:
    if x.save[i*2] == -1: break
    res.add(x.str[x.save[i*2]..<x.save[i*2+1]])
  return res

proc `$`*(x: MatchResult): string =
  if x == nil:
    "nil"
  else:
    "MatchResult(st=" & $x.st & ",e=" & $x.e & ")"

proc matchedString*(x: MatchResult): string =
  if x.st == x.e:
    ""
  else:
    x.str[x.st..<x.e]

type
  Thread = ref object
    pc: int
    strindex: uint
    save: array[20, int]

proc emptyThread(stp: uint): Thread =
  var res = Thread(pc: 0, strindex: stp)
  for i in 0..<20: res.save[i] = -1
  return res

proc runVM*(prog: seq[Instr], str: string, stp: uint): MatchResult =
  var threadPool: array[2, seq[Thread]] = [@[], @[]]
  var poolIndex: int = 0
  var endThread: Thread = nil
  threadPool[poolIndex].add(emptyThread(stp))
  let strLen = uint(str.len())
  var e: uint = stp
  var matched = false
  while threadPool[poolIndex].len() > 0 or threadPool[1-poolIndex].len() > 0:
    var j = 0
    while true:
      let currentQueueIndex = threadPool[poolIndex].len()
      if j >= currentQueueIndex: break
      let thread = threadPool[poolIndex][j]
      let instr = prog[thread.pc]
      block chk:
        case instr.instype:
          of CHAR:
            if thread.strindex == strLen or instr.ch != str.runeAt(thread.strindex): break chk
            thread.pc += 1
            thread.strindex += uint(str.runeLenAt(thread.strindex))
            threadPool[1-poolIndex].add(thread)
          of IN:
            var chkres = thread.strindex < strLen
            if not chkres: break chk
            let currentRune = str.runeAt(thread.strindex)
            chkres = currentRune in instr.ichset
            for z in instr.ichrange:
              chkres = chkres or (z[0] <=% currentRune and currentRune <=% z[1])
            if not chkres: break chk
            thread.pc += 1
            thread.strindex += uint(str.runeLenAt(thread.strindex))
            threadPool[1-poolIndex].add(thread)
          of NOT_IN:
            var chkres = thread.strindex < strLen
            if not chkres: break chk
            let currentRune = str.runeAt(thread.strindex)
            chkres = currentRune in instr.nchset
            for z in instr.nchrange:
              chkres = chkres or (z[0] <=% currentRune and currentRune <=% z[1])
            if chkres: break chk
            thread.pc += 1
            thread.strindex += uint(str.runeLenAt(thread.strindex))
            threadPool[1-poolIndex].add(thread)
          of MATCH:
            matched = true
            e = thread.strindex
            endThread = thread
            while threadPool[poolIndex].len() > 0: discard threadPool[poolIndex].pop()
          of JUMP:
            let target = thread.pc+instr.offset
            thread.pc = target
            threadPool[1-poolIndex].add(thread)
          of SPLIT:
            for offset in instr.target:
              let t = thread.pc + offset
              var newth = Thread(pc: t, strindex: thread.strindex, save: thread.save)
              for z in 0..<20: newth.save[z] = thread.save[z]
              threadPool[1-poolIndex].add(newth)
          of SAVE:
            thread.save[instr.svindex] = thread.strindex.int
            thread.pc += 1
            threadPool[1-poolIndex].add(thread)
          of ANY:
            if thread.strindex == strLen: break chk
            thread.pc += 1
            thread.strindex += uint(str.runeLenAt(thread.strindex))
            threadPool[1-poolIndex].add(thread)
      j += 1
    while threadPool[poolIndex].len() > 0: discard threadPool[poolIndex].pop()
    poolIndex = 1-poolIndex
  if matched:
    return MatchResult(st: stp, e: e, str: str, save: endThread.save)
  else:
    return nil
    
