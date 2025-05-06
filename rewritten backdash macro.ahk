#Warn
#SuspendExempt
#Requires AutoHotkey v2.0

; ===== CONFIG =====
global REQUIRED_KEY := "s"
global SAFETY_KEYS := ["w","a","s","d","q","e","r","t","Shift","Ctrl","Space","Alt"]

; ===== CORE SYSTEM =====
!Z::Suspend(!A_IsSuspended) ; Toggle suspension
#SuspendExempt False
SendMode("Input")

HandleKeySequence(sequence, requiredKey := "s") {
    static active := false
    if (A_IsSuspended || active) 
       return
    
    active := true
    Critical(1000)
    
    try {
        ; --- Phase 1: Key State Management ---
        originalKeys := ReleaseAllExcept(requiredKey)
        manuallyHeld := GetKeyState(requiredKey, "P")
        
        ; --- Phase 2: Execute Sequence ---
        if !manuallyHeld {
            Send("{Blind}{" requiredKey " down}")
            HighPrecisionSleep(15)
        }
        
        SendInput(sequence)
        
        ; --- Phase 3: Cleanup ---
        if !manuallyHeld {
            Send("{Blind}{" requiredKey " up}")
            HighPrecisionSleep(15)
        }
        
        RepressHeldKeys(originalKeys)
    } finally {
        active := false
        Critical(0)
    }
}

; ===== OPTIMIZED SUBSYSTEMS =====
ReleaseAllExcept(requiredKey) {
    keyStates := Map()
    for key in SAFETY_KEYS {
        if (key = requiredKey)  
		continue

        keyStates[key] := GetKeyState(key, "P")
        if keyStates[key] {
            Send("{Blind}{" key " up}")
            HighPrecisionSleep(5)
        }
    }
    return keyStates
}

RepressHeldKeys(keyStates) {
    for key, state in keyStates {
        if state {
            Send("{Blind}{" key " down}")
            HighPrecisionSleep(5)
        }
    }
}

HighPrecisionSleep(ms) {
    static freq := DllCall("QueryPerformanceFrequency", "Int64*", &freq:=0)
    DllCall("QueryPerformanceCounter", "Int64*", &start:=0)
    while (DllCall("QueryPerformanceCounter", "Int64*", &now:=0) && (now - start)/freq*1000 < ms)
        continue
}

; ===== HOTKEYS =====
*e::HandleKeySequence("3q")
*r::HandleKeySequence("2q")
*t::HandleKeySequence("1q")
*c::HandleKeySequence("4q")