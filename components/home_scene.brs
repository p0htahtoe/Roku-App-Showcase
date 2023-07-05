function init()
	'initializes background image
	? "[home_scene] init"
	m.top.backgroundColor = "0x000000FF"
    m.top.backgroundURI = "pkg:/images/question_screen.png"

	'finds and initializes screens
    m.answer_screen = m.top.findNode("answer_screen")	
	m.correct_screen = m.top.findNode("correct_screen")
	m.incorrect_screen = m.top.findNode("incorrect_screen")
	m.result_screen = m.top.findNode("result_screen")

	'connects buttons to event callback functions
    m.answer_screen.observeField("answer_selected", "onAnswerSelected")
	m.correct_screen.observeField("next_button", "onCorrectButtonSelected")
	m.incorrect_screen.observeField("incorrect_button", "onIncorrectButtonSelected")
	m.result_screen.ObserveField("retry_button", "onRetryButtonSelected")

	m.answer_screen.setFocus(true)
	
	'initializes empty arrays that store questions, answers, options
	dim arrQue[0]
    dim arrOpt[0]
    dim arrAns[0]
    m.questionArray = arrQue
    m.optArray = arrOpt
    m.ansArray = arrAns

	'initializes variables that keep count of the current question, current index for a for-loop, and the current score of the user
	m.curQuestion = 0
	m.curIndex = 0
	m.curScore = 0

	'add and convert current question count into a global variable
	m.global.addFields({curQuestion:m.curQuestion})

	'load json file hosted on public webserver
	loadFeed("https://sthsroku.net/quizzers/questions.json")
end	function

'created general function to load questions, options, and their respective values onto the screen
sub updateScreen()
	label = m.top.findNode("questionText")
	answer_list = m.top.findNode("answer_list")
	answer_list.checkedItem =-1
	
	for i=0 to 3
		option = answer_list.content.getChild(i)
		
		option.title = m.optArray.getEntry(m.curIndex)
		option.value = m.ansArray.getEntry(m.curIndex)
		m.curIndex += 1
	end for

	label.text = m.questionArray.GetEntry(m.global.curQuestion)
	?"curQuestion: ";m.global.curQuestion
	?"curIndex: "; m.curIndex

	?"ans screen focus?"; m.answer_screen.hasFocus()
end sub

'event function that is called after button is clicked
sub onAnswerSelected(obj)
	list = m.answer_screen.findNode("answer_list")
	item = list.content.getChild(obj.getData())
	? "onAnswerSelected field: ";obj.getField()
	? "onAnswerSelected data: ";obj.getData()
	? "onAnswerSelected checkedItem: ";list.checkedItem
	? "onAnswerSelected selected: ";item
	? "onAnswerSelected value: "; item.value
	? "current_screen: "; m.global.current_screen
	' Gets the value of the answer selected and runs the answerCheck() function 
	answerCheck(item.value)
end sub

' Loads the feed
sub loadFeed(url)
  m.feed_task = createObject("roSGNode", "loadTask")
  m.feed_task.ObserveField("response", "onFeedResponse")
  m.feed_task.url = url
  m.feed_task.control = "RUN"
  ? "LOADFEED RAN!"
end sub

'gets link and parses json file --> populates arrays initializes in init() 
sub onFeedResponse(obj)
	response = obj.getData()
	data = parseJSON(response)
	if data <> Invalid and data.items <> invalid
        ? "FEED RESPONSES VALID YAYAY!"
	else
		? "FEED RESPONSE IS EMPTY!"
	end if

	for Each question in data.questions
		m.questionArray.push(question.text)
		for Each option in question.options
			m.optArray.push(option.id)
			m.ansArray.push(option.value)
		End for
	End for

	'updateScreen called here to populate the first screen
	updateScreen()
end sub

'function that is called within onAnswerSelected()
'checks if answer is correct and switches screens
sub answerCheck(answer_value)
	if answer_value = "1"
		m.answer_screen.visible = false
		m.correct_screen.visible = true
		m.correct_screen.setFocus(true)
		
		m.top.backgroundColor = "0x339933"
		m.top.backgroundURI = "pkg:/images/correct_screen.png"

		m.curScore += 1
		?"curScore: "; m.curScore
	else if answer_value = "0"
		m.answer_screen.visible = false
		m.incorrect_screen.visible = true
		m.incorrect_screen.setFocus(true)

		m.top.backgroundColor = "0x800000"
		m.top.backgroundURI = "pkg:/images/incorrect_screen.png"
		? "Wrong!"
	end if

	m.global.curQuestion += 1

	updateScreen()
end sub

'event function that is called after next button within the correct screen is clicked
sub onCorrectButtonSelected(obj)
	? m.answer_screen.hasFocus()
	? m.correct_screen.hasFocus()

	m.correct_screen.visible = false
	m.answer_screen.visible = true
	m.answer_screen.setFocus(true)
	
	? "BUTTON CLICKED BUTTON CLICKED !!"

	m.top.backgroundColor = "0x000000"
	m.top.backgroundURI = "pkg:/images/question_screen.png"

	if m.global.curQuestion = m.questionArray.count()
		m.incorrect_screen.visible = false
		m.correct_screen.visible = false
		m.answer_screen.visible = false
		m.result_screen.visible = true
		m.result_screen.setFocus(true)
		showResults()
		m.top.backgroundColor = "0x000000"
		m.top.backgroundURI = "pkg:/images/result_screen.png"
	end if

end sub

'event function that is called after next button within the incorrect screen is clicked
sub onIncorrectButtonSelected(obj)
	m.incorrect_screen.visible = false
	m.answer_screen.visible = true
	? "INCORRECT BUTTON CLICKED INCORRECT BUTTON CLICKED !!"

	m.top.backgroundColor = "0x000000"
	m.top.backgroundURI = "pkg:/images/question_screen.png"

	if m.global.curQuestion = m.questionArray.count()
		m.incorrect_screen.visible = false
		m.correct_screen.visible = false
		m.answer_screen.visible = false
		m.result_screen.visible = true
		m.result_screen.setFocus(true)
		showResults()
		m.top.backgroundColor = "0x000000"
		m.top.backgroundURI = "pkg:/images/result_screen.png"
	end if
end sub

'event function that is called after next button within the result screen is clicked
sub onRetryButtonSelected(obj)
	ansList = m.answer_screen.findNode("answer_list")
	m.result_screen.visible = false
	m.answer_screen.visible = true
	ansList.setFocus(true)
	
	? "RETRY BUTTON CLICKED!!"

	m.curIndex = 0
	m.global.curQuestion = 0
	m.curScore = 0
	?"ans screen focus?"; m.answer_screen.hasFocus()

	m.top.backgroundColor = "0x000000"
	m.top.backgroundURI = "pkg:/images/question_screen.png"
	updateScreen()	
end sub

'populates the result screen
sub showResults()
	m.scoreLabel = m.top.findNode("scoreLabel")
	m.commentLabel = m.top.findNode("commentLabel")

	m.scoreLabel.text = m.curScore.toStr() + "/" + m.global.curQuestion.toStr()
	if m.curScore < 3
		m.commentLabel.text = "YOU'RE ADOPTED KID"
	else if m.curScore < 6
		m.commentLabel.text = "NOT BAD BUDDY"
	else if m.curScore < 10 
		m.commentLabel.text = "STOP CHEATING!!"
	end if
end sub

'records remote inputs on console debugger
function onKeyEvent(key, press) as Boolean
	? "[home_scene] onKeyEvent", key, press
  return false
end function
