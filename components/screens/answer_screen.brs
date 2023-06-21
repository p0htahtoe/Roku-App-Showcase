sub init()
	? "[answer_screen] init"
	m.answer_list = m.top.findNode("answer_list")
	m.answer_list.setFocus(true)
		m.top.observeField("visible", "onVisibleChange")

	questions = ["Question 1", "Question 2", "Question 3", "Question 4"]
end sub

sub onVisibleChange()
	if m.top.visible = true then
		m.answer_list.setFocus(true)
	end if
end sub