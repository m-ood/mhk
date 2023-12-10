|Functions|Args|Description|
|:-|:-|:-|
|`_.hotkey()`|`_option,_hotkey,_function,_toggle?`|`simulate ahk v2 hotkey function`|
|`_.wait()`|` `|`waits for current hotkey to lift`|
|`_.sleep()`|`_time`|`precise version of sleep`|
|`_.clock()`|` `|`global anchor for when & stamp`|
|`_.when()`|`_time`|`relative timing from global anchor`|
|`_.mouse.move()`|`_x,_y`|`safely move mouse to x/y on screen`|
|`_.mouse.relative()`|`_x,_y`|`move mouse relative from mouse pos`|
|`_.filter()`|`_string,_pattern*`|`PCRE2 regex syntax`|
|`_.reg.set()`|`_value,_string`|`manipulate local/global reg keys`|
|`_.reg.get()`|`_value*`|`get local/global reg keys`|
|`_.reg.kill()`|`_value*`|`remove local/global reg keys`|
|`_.json.load()`|`json`|`convert json object to ahk object`|
|`_.json.dump()`|`obj,pretty`|`convert ahk object to json object`|
|`_.json.file()`|`_file`|`convert json file to ahk object`|
|`_.json.open()`|`_obj`|`open object in temp file to edit`|
|`_.log()`|`_content,_bypass`|` log info to file in script folder`|
|`_.error()`|`_code,_depth`|`error with logging and reporting`|
|`_.file.write()`|`_file,_string*`|`write to file`|
|`_.file.annex()`|`_file,_string*`|`append text to end of file`|
|`_.file.read()`|`_file`|`return file content`|
|`_.file.edit()`|`_file`|`open file to edit and return content`|
|`_.notify()`|`_string*`|`custom notification system`|
|`_.print()`|`_string*`|`print text to custom console gui`|
|`_.ontop.instance()`|`_obj`|`open instance of ontopreplica on hwnd`|
|`_.ontop.end()`|`_id`|` close ontopreplica instance with id`|
|`_.input()`|` `|`fancier inputbox`|
|`_.cmd()`|`_command`|`execute batch commands with output`|
|`_.ps.import()`|`_link`|`import powershell script as function`|
|`_.ps.execute`|`_link,args*`|`execute powershell script with output`|
|`_.assetLoad()`|`_link,_name`|`load assets after script download`|
|`_.urlLoad()`|`_link*`|`load raw url into array`|



|Extensions|Args|Description|
|:-|:-|:-|
|`.hasValue()`|`_needle*`|`check if array has values`|
|`.bump()`|`_value*`|`merge objects together`|
|`.map()`|`_value*`|`add text to end/start of all values`|
|`.comment()`|`_keyword*`|`use PCRE2 regex to remove keys/value`|
|`.find()`|`_pattern*`|`use PCRE2 regex to get all matches in keys/values`|
|`.iterate()`|`_function*`|`run function on every value`|



|Properties|Args|Description|
|:-|:-|:-|
|`_.anchor`|` `|`returns private anchor object`|
|`_.hk`|` `|`returns current hotkey without mods`|
|`_.batchLines`|` `|`edit batchlines inline`|
|`_.stamp`|` `|`benchmarking with global anchor`|