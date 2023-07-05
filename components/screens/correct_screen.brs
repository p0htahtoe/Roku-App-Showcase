sub init()
    ? "[correct_screen] init"
    m.result = m.top.findNode("result")
    m.env = m.top.FindNode("correct_env")
        m.top.observeField("visible", "onVisibleChange")
    m.result.buttons = ["NEXT"]
end sub

sub onVisibleChange()
    if m.top.visible = true then
        m.result.setFocus(true)
    end if
end sub