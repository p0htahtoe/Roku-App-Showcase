sub init()
	? "[answer_screen] init"
	m.answer_list = m.top.findNode("answer_list")
	m.answer_list.setFocus(true)
		m.top.observeField("visible", "onVisibleChange")

		m.questionText = m.top.findNode("questionText")
		m.questionText.font.size = "70"


		'music player
		audio = createObject("roSGNode", "Audio")
		audiocontent = createObject("RoSGNode", "ContentNode")
		audiocontent.url = "pkg:/components/sounds/bg_music.mp3"
		audio.content = audiocontent
		m.top.appendChild(audio)
		audio.control = "play"
		audio.loop = true
end sub

sub onVisibleChange()
	if m.top.visible = true then
		m.answer_list.setFocus(true)
	end if
end sub