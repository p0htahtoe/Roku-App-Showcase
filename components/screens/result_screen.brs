sub init() 
    ? "[result_screen] init" 
    m.retry = m.top.findNode("retry")
    m.top.observeField("visible", "onVisibleChange") 
    m.retry.buttons = ["RETRY"] 
end sub 
    
sub onVisibleChange() 
    if m.top.visible = true then 
        m.retry.setFocus(true) 
    end if 
end sub