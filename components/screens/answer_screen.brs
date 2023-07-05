sub init()
	? "[answer_screen] init"
	m.answer_list = m.top.findNode("answer_list")
	m.answer_list.setFocus(true)
		m.top.observeField("visible", "onVisibleChange")

		m.questionText = m.top.findNode("questionText")
		m.questionText.font.size = "70"
end sub

sub onVisibleChange()
	if m.top.visible = true then
		m.answer_list.setFocus(true)
	end if
end sub