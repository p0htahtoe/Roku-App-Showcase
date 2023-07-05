function init()
    ? "[incorrect_screen] init"
    m.incorrect_result = m.top.findNode("incorrect_result")
        m.top.observeField("visible", "onVisibleChange")
    m.incorrect_result.buttons = ["NEXT"]
    ? m.incorrect_result.buttonFocused
    
    m.feedbackLabel = m.top.findNode("feedbackLabel")
	m.feedbackLabel.font.size = "50"

    ? "incorrect_result focus: "; m.incorrect_result.hasFocus()
end function

sub onVisibleChange()
	if m.top.visible = true then
		m.incorrect_result.setFocus(true)
	end if
end sub