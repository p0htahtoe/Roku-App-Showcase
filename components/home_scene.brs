function init()
	? "[home_scene] init"
	m.top.backgroundColor = "0x000000FF"
    m.top.backgroundURI = "pkg:/images/question_screen.png"

	' screen = CreateObject("roSGScreen")
    ' m.port = CreateObject("roMessagePort")
    ' screen.setMessagePort(m.port)
	' m.global = screen.getGlobalNode()
	' m.global.addFields("current_screen", "int", true)
	' m.global.current_screen = 0
	'm.global.questions = ["Question 1", "Question 2", "Question 3"]

    m.answer_screen = m.top.findNode("answer_screen")	
	m.correct_screen = m.top.findNode("correct_screen")
	m.incorrect_screen = m.top.findNode("incorrect_screen")

    m.answer_screen.observeField("answer_selected", "onAnswerSelected")
	m.correct_screen.observeField("next_button", "onButtonSelected")
	m.incorrect_screen.observeField("retry_button", "onRetryButtonSelected")

	m.answer_screen.setFocus(true)

	
	
	dim arrQue[0]
    dim arrOpt[0]
    dim arrAns[0]
    m.questionArray = arrQue
    m.optArray = arrOpt
    m.ansArray = arrAns
	

	m.curQuestion = 0
	m.curScore = 0

	m.global.addFields({questionArray:m.questionArray})

	loadFeed("http://172.20.10.8:8080/Roku-App-Showcase/components/tasks/questions.json")
	updateScreen()
end	function



sub onAnswerSelected(obj)
	list = m.answer_screen.findNode("answer_list")
	item = list.content.getChild(obj.getData())
	? "onAnswerSelected field: ";obj.getField()
	? "onAnswerSelected data: ";obj.getData()
	? "onAnswerSelected checkedItem: ";list.checkedItem
	? "onAnswerSelected selected: ";item
	? "onAnswerSelected value: "; item.value
	? "current_screen: "; m.global.current_screen
	answerCheck(item.value)
	
end sub
' Gets the value of the answer selected and runs the answerCheck() function 

sub loadFeed(url)
  m.feed_task = createObject("roSGNode", "loadTask")
  m.feed_task.ObserveField("response", "onFeedResponse")
  m.feed_task.url = url
  m.feed_task.control = "RUN"
  ? "LOADFEED RAN!"
end sub
' Loads the feed

sub onFeedResponse(obj)
	?"onFeedResponse rannn rawwrr"
	response = obj.getData()
	data = parseJSON(response)
	if data <> Invalid and data.items <> invalid
        ? "FEED RESPONSES VALID YAYAY!"
	else
		? "FEED RESPONSE IS EMPTY!"
	end if

	for Each question in data.questions
		' ? question.options.id
		' m.global.questionList.push(question)
		' ? m.global.questionList
		m.questionArray.push(question.text)
		' m.optArray.push(question.options.id)
		' m.ansArray.push(question.options.value)
		'? m.questionArray

		for Each option in question.options
			m.optArray.push(option.id)
			m.ansArray.push(option.value)
		End for
	End for

	m.global.setFields({questionArray:m.questionArray})
	?"m.questionArray: ";m.questionArray
	?"m.global.questionArray: ";m.global.questionArray
	'?m.optArray
	'?m.ansArray
end sub
' Pulls information from the json file and populates arrays

sub updateScreen()
	label = m.top.findNode("questionText")
	?"current global questionArray: ";m.global.questionArray
	' ?m.optArray
	' ?m.ansArray
	'label.text = m.questionArray[m.curQuestion]
end sub

sub answerCheck(answer_value)
	if answer_value = "correct"
		m.answer_screen.visible = false
		m.correct_screen.visible = true
		m.correct_screen.setFocus(true)
		
		m.top.backgroundColor = "0x339933"
		m.top.backgroundURI = "pkg:/images/correct_screen.png"

		?"current_screen: ";m.global.current_screen
		label = m.top.findNode("questionText")
		?"current title: ";label.text
		label.text = "Question 2"

		m.curQuestion += 1
		? m.curQuestion

	else if answer_value = "incorrect"
		m.answer_screen.visible = false
		m.incorrect_screen.visible = true
		m.incorrect_screen.setFocus(true)

		m.top.backgroundColor = "0x800000"
		m.top.backgroundURI = "pkg:/images/incorrect_screen.png"
		? "Wrong!"
	end if
end sub
' This function checks if the user input is correct or incorrect
' if the question is correct the visibility for the correct_screen will be true
' if the question is incorrect the incorrect_screen will become visible

sub onButtonSelected(obj)
	? m.answer_screen.hasFocus()
	? m.correct_screen.hasFocus()

	'label = m.top.findNode("questionText")
	'?"current title: ";label.text
	'm.curQuestion += 1
	'label.text = m.ansArray

	m.correct_screen.visible = false
	m.answer_screen.visible = true
	m.answer_screen.setFocus(true)
	? "BUTTON CLICKED BUTTON CLICKED !!"

	m.top.backgroundColor = "0x000000"
	m.top.backgroundURI = "pkg:/images/question_screen.png"
end sub
' This is the next button
' It changes the visibility of the answer_screen 

sub onRetryButtonSelected(obj)
	? m.answer_screen.hasFocus()
	? m.incorrect_screen.hasFocus()
	? m.correct_screen.hasFocus()
	m.incorrect_screen.visible = false
	m.answer_screen.visible = true
	? "RETRY BUTTON CLICKED RETRY BUTTON CLICKED !!"

	m.top.backgroundColor = "0x000000"
	m.top.backgroundURI = "pkg:/images/question_screen.png"
end sub
' This is the back button
' It does absolutely nothing, it is useless, we are gonna exterminate it


function onKeyEvent(key, press) as Boolean
	? "[home_scene] onKeyEvent", key, press
  return false
end function
