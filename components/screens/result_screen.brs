sub init() 
    ? "[result_screen] init" 
    m.retry = m.top.findNode("retry")
    m.top.observeField("visible", "onVisibleChange") 
    m.retry.buttons = ["RETRY"] 

    m.scoreLabel = m.top.findNode("scoreLabel")
	m.commentLabel = m.top.findNode("commentLabel")
	m.scoreLabel.font.size = "150"
	m.commentLabel.font.size = "100"

end sub 
    
sub onVisibleChange() 
    if m.top.visible = true then 
        m.retry.setFocus(true) 
    end if 
end sub