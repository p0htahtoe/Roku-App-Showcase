function init()
    ? "[incorrect_screen] init"
    m.incorrect_result = m.top.findNode("incorrect_result")
        m.top.observeField("visible", "onVisibleChange")
    m.incorrect_result.buttons = ["NEXT", "BACK"]
    ? m.incorrect_result.buttonFocused
    
    ? "incorrect_result focus: "; m.incorrect_result.hasFocus()
end function

sub onVisibleChange()
	if m.top.visible = true then
		m.incorrect_result.setFocus(true)
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if key = "left"
        m.incorrect_result.focusButton = 0 
        return true
    else if key ="right"
        m.incorrect_result.focusButton = 1
        return true
    end if 
        return false
end function