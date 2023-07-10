function init()
    ? "[incorrect_screen] init"
    m.incorrect_result = m.top.findNode("incorrect_result")
    m.top.observeField("visible", "onVisibleChange")

    'create button
    m.incorrect_result.buttons = ["NEXT"]
    
    'adjust size of feedback Label
    m.feedbackLabel = m.top.findNode("feedbackLabel")
	m.feedbackLabel.font.size = "50"

end function

sub onVisibleChange()
	if m.top.visible = true then
		m.incorrect_result.setFocus(true)
	end if
end sub