#Warn
#SuspendExempt ; Exempt following hotkeys from suspension

; Suspend/Unsuspend hotkey (Alt + Z)
!Z:: {
    if A_IsSuspended {
        Suspend(false)
    } else {
        Suspend()
    }
    return
}

#SuspendExempt False

SendMode("Input")

; High-precision sleep function using DllCall
HighPrecisionSleep(ms) {
    DllCall("Sleep", "UInt", ms)
}

; Function to release all keys except "S" and store their states
ReleaseAllExceptS() {
    global wWasPressed := GetKeyState("w", "P")
    global aWasPressed := GetKeyState("a", "P")
    global dWasPressed := GetKeyState("d", "P")
    Send("{Blind}{w up}{a up}{d up}{q up}{e up}{r up}{t up}{Shift up}{Ctrl up}{Alt up}")
}

; Function to re-press keys that were held before the macro
RepressHeldKeys() {
    if wWasPressed {
        Send("{Blind}{w down}")
    }
    if aWasPressed {
        Send("{Blind}{a down}")
    }
    if dWasPressed {
        Send("{Blind}{d down}")
    }
}

; Function to check if the "S" key is already held down
IsKeyPressed(key) {
    return GetKeyState(key, "P")
}

; Function to handle the key sequences with proper key release and re-press
HandleKeySequence(sequence) {
    ReleaseAllExceptS()  ; Release all currently held keys except S

    manuallyHeld := IsKeyPressed("S")
    if !manuallyHeld {
        Send("{Blind}{S down}")
    }

    SendInput(sequence)
    HighPrecisionSleep(1)  ; Use high-precision sleep to ensure timing

    if !manuallyHeld {
        Send("{Blind}{S up}")
    }

    ; Re-press the manually held keys (W, A, D) if they were held before
    RepressHeldKeys()
}

; Hotkeys to trigger the sequences regardless of other keys being held down
*e::HandleKeySequence("3q")
*r::HandleKeySequence("2q")
*t::HandleKeySequence("1q")
*c::HandleKeySequence("4q")
