extends Control

var data = ""

var mouse_move_x = 0
var mouse_move_y = 0

var request_time = 0

var mode = 0

onready var http = $HTTPRequest

var URL = "https://api.ownthink.com/bot"

func _ready():
	get_viewport().transparent_bg = true
	_transparency()

func _process(delta):
	if mode == 0:
		$聊天室/标题/标题.text = " 青云客"
	if mode == 1:
		$聊天室/标题/标题.text = " 思知"
	

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		_on_send_pressed()
	
	if event is InputEventMouseMotion:
		if $聊天室/标题/拖拽.pressed: #拖拽
			OS.window_position += event.relative

func _on_send_pressed():
	var text = $聊天室/输入/输入.text
	$聊天室/输入/输入.text = ""
	if text != "":
		if $聊天室/消息/消息.text != "":
			$聊天室/消息/消息.text += "\n"
		$聊天室/消息/消息.text += " 我: " + text
		if mode == 0:
			http.request("http://api.qingyunke.com/api.php?key=free&appid=0&msg=" + text, [], false, 0, "")
			
		if mode == 1:
			var data = {"spoken" : text,
						"appid" : "4323eb202779bd5cabbe4ec05df31402"
			}
			http.request("https://api.ownthink.com/bot", [], false, 2, to_json(data))

func _transparency(): #透明度
	var transparency = 0.75
	
	$关闭.color.a = transparency
	$隐藏.color.a = transparency
	
	$聊天室/标题.color.a = transparency
	$聊天室/输入.color.a = transparency
	$聊天室/发送.color.a = transparency
	$聊天室/消息.color.a = transparency
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if mode == 0:
		data = parse_json(body.get_string_from_utf8())["content"]
		$聊天室/消息/消息.text += "\n 青云客: " + data
	if mode == 1:
		data = parse_json(body.get_string_from_utf8())["data"]["info"]["text"]
		$聊天室/消息/消息.text += "\n 思知: " + data

func _on_close_pressed():
	get_tree().quit()


func _on_hide_pressed():
	OS.window_minimized = true

func _on_change_mode_pressed():
	if mode == 2:
		mode = 0
	else:
		mode += 1
