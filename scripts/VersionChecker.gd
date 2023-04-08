extends Node

# Version Shenanigans
var version_link := "https://onedrive.live.com/download?cid=5DE2D6604D631D2A&resid=5DE2D6604D631D2A%215820&authkey=AKKJETIL6Ja0Rw4"
var version_path := "user://version.txt"
var http_request: HTTPRequest

func _start():
	pass
#	_verify_version()

func _file_exists(path: String): # -> bool:
	pass
#	var dir := Directory.new()
#	return dir.file_exists(path)

func _verify_version():
	pass
#	if _file_exists(version_path):
#		# Check for update
#		_download_file(version_link, version_path, true)
#	else:
#		# Download it
#		_check_integrity()

#func _download_file(link: String, path: String, just_version: bool):
#	pass
#	# Create HTTP request node + connect completion signal
#	http_request = HTTPRequest.new()
#	add_child(http_request)
#
## warning-ignore:return_value_discarded
#	http_request.connect("request_completed",Callable(self,"_install_file").bind(path, just_version))
#
#	# Error handling
#	var error = http_request.request_raw(link)
#	if error != OK:
#		pass

func _install_file(_result, _response_code, _headers, body, path, just_version: bool):
	pass
#	if just_version:
#		var new_version := str(body.get_string_from_utf8())
#		# Check versions
#		_compare_version(new_version)
#		return
#
#	var dir := Directory.new()
## warning-ignore:return_value_discarded
#	dir.remove(path)
#
#	var file := File.new()
## warning-ignore:return_value_discarded
#	file.open(path, File.WRITE)
#	file.store_buffer(body)
#	file.close()

func _check_integrity():
	pass
#	if !_file_exists(version_path):
#		_download_file(version_link, version_path, false)
#		print("no version")
#		return

func _compare_version(new_version):
	pass
#	var file := File.new()
## warning-ignore:return_value_discarded
#	file.open(version_path, File.READ)
#	var cur_version := file.get_as_text();
##	file.close()
#
#	if (int(new_version) > int(cur_version)):
#		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (false) else Window.MODE_WINDOWED
#		Settingsholder.save_data.Fullscreen = 0
#		await get_tree().idle_frame
#		await get_tree().idle_frame
#		await get_tree().idle_frame
#		var dir = Directory.new()
#		dir.remove(version_path)
#		OS.alert("You appear to be running an outdated version, you can install the latest version on itch: https://yetiowner.itch.io/1000-rooms this warning will only appear once per update.", "Outdated Version")
#	_check_integrity()
