extends Panel

func _on_join_pressed():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_node("信息/名称/名称").text = $名称/名称.text
	get_parent().get_parent().get_parent().get_parent().get_parent().get_node("信息/地址/IP").text = $地址/IP.text
	get_parent().get_parent().get_parent().get_parent().get_parent().get_node("信息/地址/端口").value = $地址/端口.value
	get_parent().get_parent().get_parent().get_parent().get_parent().get_node("信息/检测/检测").text = "T"
	
	
