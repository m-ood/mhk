_.start({"packageName":"mloop", "version":"1", "url":"https://raw.githubusercontent.com/m-ood/mhk/main/mloop.as", "passwordProtected":"0"})
global $:=_.params({"1_keybind":"q", "2_rebind":"e"})
#if ((!winactive("ahk_exe code.exe")))
{
    ;! obsidian object types
    ;! move documentation to obsidian
    ;! actually write all the documentation lol
    ;@ this version is held together by duct tape ᗜˬᗜ
    
    
    _.keybind.macro("$*~",$.1_keybind,"main")
} return





main() {
    @:=_.anchor, key:=$.2_rebind
    _.send(key), @.when("+2")
    ;_.wait() ;? uncomment 4 rebind
    _.send(key . "@"), @.when("+2")
    return
}





;[/mhk
    ;ᗜˬᗜ
    class _ { ;$beta.26=ea.3
        static version:="mhk.3.beta.27" ;$version
        static gitName:="m-ood/mhk/" ;$rootUrl
        ;/methods
            ;/tas
                ;/BETTER HOTKEY YIPEE
                    class keybind extends _ {
                        static private
                        static hkRef:={}
                        static hkDict:={}
                        static labelLocal:={}
                        static args2bind:=[]
                        static allowedWindows
                        macro(modifiers:="$*~",hotkey:="",func2:="",args*) {
                            if (hotkey="")
                                base.error("invalid hotkey","-2")
                            modCheck:=((base.filter(hotkey,base.patterns.hkStrip))?(hotkey):(modifiers . hotkey)), id:=base.md5(modCheck)
                            keyOnly:=base.filter(modCheck,base.patterns.hkOnly),modOnly:=base.filter(modCheck,base.patterns.modOnly)
                            if (this.hkThread.haskey(id)) {
                                this.close(id)
                            } this.hkRef[id]:={}, func:=base.funcLiteral(func2,args*), this.hkref[id].func:=func, this.hkdict[modcheck]:=id
                            this.hkRef[id].key:=keyOnly, this.hkRef[id].mod:=modOnly, this.hkRef[id].status:="On"
                            ;hotkeyThreadInfo:=this.__createHotkeyThread(modCheck,keyOnly,func2,id,args*)
                            hotkey, % modcheck, % "_系统标签", % "On"
                            finalObj:={"modifiers":modOnly,"hotkey":keyOnly,"id":id}
                            finalObj["path"]:=this.hkRef[id].func.path
                            finalObj["close"]:=objbindmethod(this,"close",id)
                            finalObj["open"]:=objbindmethod(this,"open",id)
                            ;finalObj["suspend"]:=objbindmethod(this,"suspend",id,"")
                            return finalObj
                        }

                        _groupTestStuff(hotkey,key,function,id,args*) {
                            this.hkRef[id].func:=base.funcLiteral(function,this.args2bind,this.hkref[id],args*)
                            this.hkRef[id].key:=key, this.hkRef[id].status:="on"
                            ;shareType:="mhk:=objShare(" . objshare(_) . ")`n" ;$share
                            ;shareType:="mhk:=objShare(" . objshare(_.fco(_)) . ")`n" ;$clone share
                            ;co:=criticalObject(_.fco(_)),shareType:="global mhk:=criticalObject(" . (&co) . ")`n" ;$clone critcal

                            ;this.hkref[id].func.path
                            argsCo:=objshare(args),paramsRef:=objshare(this.args2Bind.clone()),safeRef:=objshare(_),path:=function ;$ \

                            collection:="thr:={""key"":""" . key . """,""unsafe"":mhk,""safe"":objshare(" . safeRef . ")}`n" ;,""wait"":func(""kw"").bind(""" . key . """)

                            ;
                            trayIcon:="#noTrayIcon`n",c:=criticalObject(_),shareTypeORef:="mhk:=criticalObject(" . &c . ")`n",thread:="#persistent`n"
                             . trayIcon . "setbatchlines, % ""-1""`nSetKeyDelay, -1, -1`nSendMode, input`n#MaxHotkeysPerInterval 99999`n#MaxThreadsP"
                             . "erHotkey 1`n" . this.allowedWindows . shareTypeORef . "hotkey, % """ . hotkey . """, % """ . id . """"
                             . "`nobj1:=objshare(" . paramsRef . ")`n" . collection
                             . ""
                             . "obj4:=objshare(" . argsCo . ")`nglobal func:=mhk.funcliteral(""" . path . ""
                             . """,_)`nreturn`nturnOff(string:="""") {`nsuspend, % string`nreturn`n}`n"
                             . "" . id . ":`n{"
                             . "`nfunc.call()`n}" ;$ compressed mhk keybind.macro thread :o
                            this.hkRef[id].thr:=ahkthread(thread . "`n" . base.export() . "`n") ;obj1,thr,_,obj4*
                            loop {
                                sleep, 1
                                temp:=this.hkRef[id].thr.ahkgetvar["func"]
                            } until (temp!="")
                            _.print(thread)
                            ;this.hkref[id].wait:=objbindmethod(this.hkRef[id].thr,"ahkFunction","kw",key)
                            ;objbindmethod(this.base,"wait",key)
                            ;_.print(objbindmethod(this.hkRef[id].thr,"ahkFunction",key))
                            ;_.print(objshare(_.keybind.hkref[id]))
                            return {"func":this.hkRef[id].func,"debug":objbindmethod(this,"__threadDebug",thread,id)}
                        }

                        close(id) {
                            hotkey, % this.hkref[id].hotkey,, % "Off"
                            this.hkref[id].status:="Off"
                            return
                        }

                        open(id) {
                            hotkey, % this.hkref[id].hotkey,, % "On"
                            this.hkref[id].status:="On"
                        }

                        closeAll() {
                            for a,b in this.hkref
                                this.close(a)
                            return
                        }

                        suspend(id,override:="") {
                            if (override!="") {
                                overrideString:=((override="on")?("off"):("on"))
                                this.hkref[id].thr.ahkFunction("turnOff",overrideString)
                                this.hkref[id].thr.ahkPause(overrideString)
                                this.hkref[id].status:=((overrideString="on")?("off"):("on"))
                                return
                            }
                            if (this.hkref[id].status="on") {
                                this.hkref[id].thr.ahkFunction("turnOff","on")
                                this.hkref[id].thr.ahkPause("on")
                                this.hkref[id].status:="off"
                            } else {
                                this.hkref[id].thr.ahkFunction("turnOff","off")
                                this.hkref[id].thr.ahkPause("off")
                                this.hkref[id].status:="on"
                            }
                            return
                        }

                        suspendAll(override:="") {
                            over:=((override!="")?(override):("off"))
                            for a,b in this.hkref
                                this.suspend(a,over)
                            return
                        }

                        windows(winTitles*) {
                            for a,b in winTitles
                                flatWT.=b . " "
                            waflatwt:="( " . base.filter(flatWT,base.patterns.keybindWindows) . ")"
                            ;DetectHiddenWindows, On`nsettitlematchmode, 2`n
                            this.allowedWindows:="" . waFlatWt . ""
                            ;this.allowedWindows:=waFlatWt
                             ;. "#if (!winActive(""mloop ahk_class AutoHotkey""))`n"
                            return this.allowedWindows
                        }
                    }
                    
                
                ;/time
                    wait(key:="",logi:="") {
                        if (key="") {
                            keywait, % this.hk, % logi
                            return
                        }
                        keywait, % key, % logi
                        return
                    }
    
                    sleep(_time) {
                        thread, priority, 100
                        if !(a_batchlines = -1)
                            this.error("BatchLines needs to be ""-1"", current: " a_batchlines)
                        DllCall("QueryPerformanceFrequency", "Int64*", freq)
                        DllCall("QueryPerformanceCounter", "Int64*", countatstart)
                        loop {
                            DllCall("QueryPerformanceCounter", "Int64*", countrnow)
                            timepassed := ((countrnow - countatstart) / freq )*1000
                            if (timepassed > _time) {
                                break
                            }
                        }
                        return
                    }
    
                    ;/clock
                        clock() {
                            DllCall("QueryPerformanceCounter", "Int64*", cS), this._clock["start"]:=cS, this._clock["last"]:=0
                            return
                        }
    
                        when(_time) {
                            if !(this._clock.start)
                                this.error("""_.clock()"" has not been started.")
                            baseTime:=_time, timeCheck:=this.filter(_time,"/(\+)\K.*/is"), _time:=((timeCheck)?(this._clock.last+timeCheck):_time)
                            DllCall("QueryPerformanceFrequency", "Int64*", f)
                            loop
                                DllCall("QueryPerformanceCounter", "Int64*", cN)
                            until (((cN - this._clock.start) / f )*1000 > _time)
                            this._clock["last"]:=((this._clock.last*10000000)+(baseTime*10000000))/10000000
                            return
                        }
                    
                    ;/anchor v3
                        anchor[] {
                            get {
                                DllCall("QueryPerformanceCounter", "Int64*", cS)
                                return {"最后的":0,"时间":cS,"base":this.__anchor}
                                return
                        }}
                        
                        class __anchor {
                            when(_time) {
                                regexmatch(_time,"is)^\+\K.*$",tc)
                                baseTime:=_time
                                _time:=((tc)?(this.最后的+tc):(_time))
                                DllCall("QueryPerformanceFrequency", "Int64*", f)
                                loop
                                    DllCall("QueryPerformanceCounter", "Int64*", cN)
                                until ((((cN - this.时间) / f )*1000)+0.0032 > _time)
                                return this["最后的"]:=((this.最后的*10000000)+(baseTime*10000000))/10000000
                            }
                            
                            time[] {
                                get {
                                    DllCall("QueryPerformanceFrequency", "Int64*", f)
                                    DllCall("QueryPerformanceCounter", "Int64*", cN)
                                    return ((cN - this.时间) / f )*1000
                            }}
                        }
                    
                
                ;/mouse
                    class mouse extends _ {
                        move(_x:="", _y:="") {
                            DllCall("SetCursorPos", "int", _x, "int", _y)
                            mousemove, _x, _y, 0
                            return
                        }
    
                        relative(_x:="",_y:="") {
                            DllCall( "mouse_event", int, 1, int, _x, int, _y, uint, 0, uint, 0 )
                            return
                        }
                    }
                
                ;/better send*
                    send(keys*) {
                        return this.__send.sendInput(keys*)
                    }

                    class __send extends _ {
                        static private
                        static ptrs:=a_ptrsize
                        static InputSize:=16+a_ptrsize*3
                        static ptrEnd:=8+a_ptrsize*2
                        static minputList:={"options": "is", "pattern": "^(?:[+^!]|\w+|.|@$|#$)"}
                        static siAdd:=DllCall("GetProcAddress","Ptr",DllCall("GetModuleHandle","Str","user32","Ptr"),"AStr","SendInput","Ptr")
                        static clickDict:={"lbutton":2,"rbutton":8,"mbutton":32}
                        static modDict:={"+":42,"^":29,"!":56}

                        sendInput(keys*) {
                            data:=this.parseCKeys(keys*),ki:=data[1],count:=data[2]
                            DllCall(this.siAdd, "UInt", count, "Ptr", ki[], "Int", sizeof(ki))
                            ;thing:=dynacall(this.siAdd,"uiuii",count,ki[],sizeof(ki))
                            return

                        }

                        parseCKeys(keys*) {
                            input:="DWORD type;`n{`nMOUSEINPUT mi;`nKEYBDINPUT ki;`nHARDWAREINPUT hi;`n}`n"
                            MOUSEINPUT:="LONG dx;`nLONG dy;`nDWORD mouseDATA;`nDWORD dwFlags;`nDWORD time;`nULONG_PTR dwExtraInfo;"
                            KEYBDINPUT:="WORD wVk;`nWORD wScan;`nDWORD dwFlags;`n DWORD time;`nULONG_PTR dwExtraInfo;"
                            HARDWAREINPUT:="DWORD uMsg;`nWORD  wParamL;`nWORD  wParamH;",inputlist:=[],endList:=[],type:=1,c:=0
                            ki:=Struct(input)
                            for a,b in keys {
                                crList:=base.mfilter(b,this.minputList),i:=0
                                loop {
                                    first:=crList[1+i], modDiff:=this.modDict[first]
                                    if (modDiff="")
                                        break
                                    inputList.push({"type":1,"sc":modDiff,"event":8})
                                    endList.push({"type":1,"sc":modDiff,"event":10})
                                    i++
                                } clickDiff:=this.clickDict[first]
                                if (clickdiff="") {
                                    sc:=getkeysc(first)
                                } else {
                                    sc:=clickDiff
                                    type:=0
                                } if (crList[2+i]="#") {
                                    inputList.push({"type":type,"sc":sc,"event":8},{"type":type,"sc":((type=0)?(sc*2):(sc)),"event":10})
                                } else {
                                    if (crList[2+i]="@") {
                                        if (type=0)
                                            sc:=sc*2
                                        event:=10
                                    } else {
                                        event:=8
                                    } inputList.push({"type":type,"sc":sc,"event":event})
                                } inputList.push(endList*),endlist:=[],i:=0
                            } for c,d in inputList {
                                cn++
                                switch type {
                                    case "1": {
                                        ki[cn].type:=1
                                        ki[cn].ki.wVk:=0
                                        ki[cn].ki.wScan:=d.sc
                                        ki[cn].ki.dwFlags:=d.event
                                        ki[cn].ki.time:=0
                                        ki[cn].ki.dwExtraInfo:=1
                                    } case "0": {
                                        ki[cn].type:=0
                                        ki[cn].mi.dx:=0
                                        ki[cn].mi.dy:=0
                                        ki[cn].mi.mouseData:=d.event
                                        ki[cn].mi.dwFlags:=d.sc
                                        ki[cn].mi.time:=0
                                        ki[cn].mi.dwExtraInfo:=1
                                    }
                                }
                            } inputList:=[],inputList:=""
                            return [ki,c]
                        }


                    }
                    
                
            
            ;/grouping
                class group extends _ {
                    static private
                    static groupList:={}
                    static compResList:={}
                    static args2Bind:={}
                    static allowedWindows
                    add(src*) {
                        for a,b in src {
                            if (fileexist(b)) {
                                id:=b,cont:=base.file.read(b),this.compResList[b]:=cont
                            } else {
                                if (a_iscompiled=1)
                                    try
                                        sz:=resget(zipData,a_scriptdir . "\" . a_scriptname,b,"groups")
                                if (sz) {
                                    unziprawmemory(&zipData,sz,data),id:=b,cont:=data
                                } else {
                                    id:=base.md5(b),cont:=b . "`n" . base.export() . "`n"
                                }
                            }
                            this.createGroupThread(id,cont)
                        }
                        return
                    }

                    re(all*) {
                        return all*
                    }

                    suspendAll(override:="") {
                        over:=((override!="")?(override):("off"))
                        for a,b in this.groupList
                            this.suspend(a,over)
                        return
                    }

                    suspend(id,override:="") {
                        if (override!="") {
                            overrideString:=((override="on")?("off"):("on"))
                            this.groupList[id].thr.ahkFunction("turnOff",overrideString)
                            this.groupList[id].thr.ahkPause(overrideString)
                            this.groupList[id].status:=((overrideString="on")?("off"):("on"))
                            return
                        }
                        if (this.groupList[id].status="on") {
                            this.groupList[id].thr.ahkFunction("turnOff","on")
                            this.groupList[id].thr.ahkPause("on")
                            this.groupList[id].status:="off"
                        } else {
                            this.groupList[id].thr.ahkFunction("turnOff","off")
                            this.groupList[id].thr.ahkPause("off")
                            this.groupList[id].status:="on"
                        }
                        return
                    }

                    createGroupThread(id,cont) {
                        this.groupList[id]:={},this.groupList[id].status:="on"
                        this.groupList[id].content:=objbindmethod(this,"re",cont),pR:=objshare(this.args2Bind.clone())
                        thread:=this.allowedWindows . "#noTrayIcon`nsetbatchlines, % ""-1""`nSetKeyDelay, -1, -1`nSendMode, input`n"
                         . "global $:=objshare(" . pR . ")`nturnOff(string:="""") {`nsuspend, % string`nreturn`n}`n" . cont
                        this.groupList[id].thr:=ahkthread(thread) ;$ group
                        /*
                        loop {
                            sleep, 1
                            temp:=this.groupList[id].thr.ahkgetvar["$"]
                        } until (temp!="")
                        */
                        return id
                    }

                    windows(winTitles*) {
                        for a,b in winTitles
                            flatWT.=b . " "
                        waflatwt:="( " . base.filter(flatWT,base.patterns.keybindWindows) . ")"
                        this.allowedWindows:="#if " . waFlatWt . "`n"
                        return this.allowedWindows
                    }
                }
            ;/qol
                ;/trayCLick
                    class __tray extends _ {
                        __hover(_args*) {
                            thread, priority, -1
                            switch _args[2] {
                                case 0x201: {
                                    oldParams:=base.per.data.params,base.per.data.delete("params"),base.__params.__open(oldParams,1,0)
                                    reload
                                    return
                                }
                            }
                            return
                        }
                    }
                
                ;/titlebar
                    class __gui extends _ {
                        titleBar(id,hwnd,width) {
                            local
                            static pic, pic1, mini, drag
                            barSize:=(width-109)
                            gui, % id . ":add", % "text", % "w" . (barSize) . " h21 x+0 y+0 BACKGROUNDTrans hwnddrag 0x201", % ""
                            fn:=objbindmethod(this,"__drag",hwnd)
                            guicontrol, % id . ":+g", % drag, % fn
                            gui, % id . ":Add", % "progress", % "wp hp xP+0 yP+0 BACKGROUND11111b section", % " >"
                            gui, % id . ":Add", % "ActiveX", % "xS+" . (barSize+1) . " yS+0 w109 h20 disabled +0x4000000 vpic", htmlfile
                            titleHtml:=""
                            . "<body style='margin: 0; overflow: hidden;'><div class='image'><img class='background-image' src='https://"
                            . "github.com/idgafmood/mhk_koi/releases/download/`%2B/buttons4.png' width='109' height='20' style='width: 1"
                            . "00%; height:100%;'></div></body>"
                            pic.Write(titleHtml)
            
                            gui, % id . ":add", % "text", % "w21 h21 xS+" . (barSize+1) . " yP+0 BACKGROUNDTrans hwndmini 0x201", % "-"
                            fn:=objbindmethod(this,"__minimize",hwnd)
                            guicontrol, % id . ":+g", % mini, % fn
            
                            gui, % id . ":add", % "text", % "w21 h21 x+18 yP+0 BACKGROUNDTrans hwndmini 0x201", % "#"
                            fn:=objbindmethod(this,"__enlarge",hwnd)
                            guicontrol, % id . ":+g", % mini, % fn
            
                            gui, % id . ":add", % "text", % "w21 h21 x+18 yP+0 BACKGROUNDTrans hwndmini 0x201", % "X"
                            fn:=objbindmethod(this,"__close",hwnd)
                            guicontrol, % id . ":+g", % mini, % fn
                            gui, % id . ":Add", % "progress", % "w109 h21 xS+" . (barSize) . " yS+0  disabled BACKGROUND11111b", % " >"
                            return
                        }
            
                        __minimize(hwnd) {
                            PostMessage, 0x0112, 0xF020,,, % "ahk_id " . hwnd
                            return
                        }
            
                        __enlarge(hwnd) {
                            ;PostMessage, 0x0112, 0xF030,,, % "ahk_id " . hwnd
                            return
                        }
            
                        __close(hwnd) {
                            PostMessage, 0x0112, 0xF060,,, % "ahk_id " . hwnd
                            return
                        }
            
                        __drag(hwnd) {
                            SendMessage 0xA1,2,,, % "ahk_id " . hwnd
                            return
                        }
                    }
                
                ;/html5 fix
                    class __html5 extends _ {
                        fix() {
                            static regKey := "HKCU\Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION"
                            SplitPath, % A_IsCompiled ? A_ScriptFullPath : A_AhkPath, exeName
                            RegRead, value, % regKey, % exeName
                            if (value != 11000)
                            RegWrite, REG_DWORD, % regKey, % exeName, 11000
                            Return !ErrorLevel
                        }
                    }
                
                ;/filter (regex PCRE2)
                    class __regex extends _ {
                        __pattern(_regex) {
                            if (isobject(_regex))
                                return _regex
                            final:={}
                            switch (regexmatch(_regex,"is)^(?:(\/).*(?<!(?<!\\)\\)\1.*\=.*)$")){
                                case "0": {
                                    final.pattern:=((regexmatch(_regex,"is)^(?:(\/)\K.*)(?=\1.*$)",_temp))?(_temp):"")
                                    final.options:=((regexmatch(_regex,"is)^(?:(\/)\K.*\1)\K.*$",_temp))?(_temp):"")
                                } default: {
                                    final.pattern:=((regexmatch(_regex,"is)^(?:(\/)\K(?:.)+?)(?=(?<!(?<!\\)\\)\1.*?(?=\=))",_temp))?(_temp):"")
                                    final.options:=((regexmatch(_regex,"is)^(?:(\/)(?:.)+?(?:(?<!(?<!\\)\\)\1\K.*?(?=\=)))",_temp))?(_temp):"")
                                    final.replace:=((regexmatch(_regex,"is)^(?:(\/)(?:.)+?(?:(?<!(?<!\\)\\)\1.*?\=))\K.*$",_temp))?(_temp):"")
                                }
                            } return final
                        }
        
                        __filter(_string,_regex*) {
                            while (i?(i++?"":""):((i:=1)?"":"")) (i <= _regex.maxindex()) ((current:=this.__pattern(_regex[i]))?"":"") {
                                switch (current.haskey("replace")) {
                                    case "0": regexmatch(_string,current.options ")" current.pattern,_string)
                                    case "1": _string:=regexreplace(_string,current.options ")" current.pattern,current.replace)
                            }} return _string
                        }

                        __filterAll(_string,_regex*) {
                            convertedRegex:=[],final:=[]
                            for a,b in _regex
                                convertedRegex.push(this.__pattern(b))
                            loop {
                                lastString:=_string
                                for a,b in convertedRegex {
                                    switch (b.haskey("replace")) {
                                        case "0": {
                                            regexmatch(_string,b.options . "O)" . b.pattern,tempObj)
                                            length:=tempObj.len(0), pos:=tempObj.pos(0)-1
                                            regexmatch(_string,b.options . ")" . b.pattern,temp)
                                            _string:=regexreplace(_string,"isO)^.{" . pos . "}\K.{" . length . "}(?=.*$)","")
                                        } case "1": _string:=regexreplace(_string,b.options . ")" . b.pattern,b.replace),temp:=_string
                                }} if (_string==lastString)
                                    break
                                final.push(temp)
                            } until ((_string="")||(replaceBreak=1))
                            return final
                        }
                    } ;!JANK: all front facing slashes inside regex pattern require escaping (this is due to the convienence of compactness)
        
                    filter(_string,_pattern*) {
                        return this.__regex.__filter(_string,_pattern*)
                    }

                    mfilter(_string,_pattern*) {
                        return this.__regex.__filterAll(_string,_pattern*)
                    }

                    regexRef(_pattern) {
                        return this.__regex.__pattern(_pattern)
                    }
                
                ;/char
                    char(_string,_amount) {
                        loop, % _amount
                            final:=final . _string
                        return final
                    }
                
                ;/uuid
                    uuid[] {
                        get {
                            return Format("{:L}",this.filter(comobjcreate("scriptlet.typelib").guid,this.patterns.uuid))
                        }
                    }
                
                ;/reload
                    reload(isActualReload:="") {
                        file:=a_scriptdir . "\" . a_scriptname
                        iscomp:=a_iscompiled
                        if !(iscomp) {
                            this.per.dump()
                            this.per.override:=1
                            if (isActualReload="")
                                reload
                            return
                        } else {
                            this.per.__metadata["ID"]:=this.bid
                            this.per.__metadata["TIME"]:=A_Now . A_MSec
                            this.per.__metadata["data"]:=this.per.data
                            hex:=this.filter(this.json.dump(this.per.__metadata),"/[""]/is=$0$0","/[$^]/is=``$0"),nm:=file
                            src:="Start-Sleep 0.2`n"
                            . "$args=@{data=""" . (hex) . """;name=""" . (nm) . """}`n$mdf = @""`n[DllImport(""kernel32.dll"", EntryPoint = ""BeginUpdateResou"
                            . "rceW"", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]`n"
                            . "public extern static IntPtr BeginUpdateResourceW(string pFileName,bool bDeleteExistingResources);`n[DllImport(""kernel32.dll"","
                            . " EntryPoint = ""UpdateResourceW"", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = Ca"
                            . "llingConvention.StdCall)]`npublic static extern bool UpdateResourceW(IntPtr hUpdate,string lpType,string lpName,UInt16 wLanguag"
                            . "e,string lpData,UInt32 cbData);`n[DllImport(""kernel32.dll"", EntryPoint = ""EndUpdateResourceW"", SetLastError = true, CharSet"
                            . " = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]`npublic static extern bool EndUpdateR"
                            . "esourceW(IntPtr hUpdate,bool fDiscard);`n""@`n$k32=Add-Type -MemberDefinition $mdf -Name 'Kernel32' -Namespace 'Win32' -PassThr"
                            . "u`n#* yuh`n$hUpdate=($k32::BeginUpdateResourceW($args.name,0))`n$result=($k32::UpdateResourceW($hUpdate,""data"",""persistent"""
                            . ",1033,$args.data,([System.Text.Encoding]::UTF8.GetByteCount($args.data)*2)))`n$final=($k32::EndUpdateResourceW($hUpdate,!($resu"
                            . "lt)))" ;$ resource dump powershell script for exe persistence /\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|
                            . ";Start-Process -filepath '" . (nm) . "';"
                            this.ps.import(src,"exePersDump"), this.ps.exePersDump()
                            this.per.override:=1
                            exitapp
                            return
                        }
                    }
                
                ;/suspend
                    suspend() {
                        state:=(((!a_issuspended))?("off"):("on"))
                        this.group.suspendAll(state)
                        return
                    }
                
                ;/bound func parser
                    funcLiteral(func2,args*) {
                        path:=this.mfilter(func2,this.patterns.funcLiteralParse)
                        for a,b in path
                            path[a]:=this.filter(b,this.patterns.pathComment1,this.patterns.pathComment2)
                        fnc:=path.pop()
                        if ((path.count()=0)&&(isfunc(fnc))) {
                            final:={},final.func:=(func(fnc).bind(args*)),final.path:=func2,final.args:=objbindmethod(this.__funcLiteral,"info",args)
                            final.call:=this.__funcLiteral.call
                            return final
                        } temp:=path[1],currentObj:=(%temp%),path.removeat(1)
                        for a,b in path {
                            if (currentObj.haskey(b))
                                currentObj:=currentObj[b]
                            else
                                return 0
                        } if (currentObj.haskey(fnc)) {
                            final:={},final.func:=(objbindmethod(currentObj,fnc,args*)),final.path:=func2,final.args:=objbindmethod(this.__funcLiteral,"info",args)
                            final.call:=this.__funcLiteral.call
                            return final
                        } return 0
                    }
                    
                    class __funcLiteral extends _ {
                        call() {
                            return this.func.call()
                        }

                        info(args) {
                            return args
                        }
                    }
                
                ;/search
                    class search extends _ { ;! probably gonna change
                        pixel(corner1,corner2,rgb,variation:="0",args:="") {
                            VarSetCapacity(dec,66,0),val:=DllCall("msvcrt.dll\_wcstoui64","Str",rgb,"UInt",0,"UInt",16,"CDECL Int64")
                            ,DllCall("msvcrt.dll\_i64tow","Int64",val,"Str",dec,"UInt",10,"CDECL") ;$ rgb/hex to decimal converter for speed
                            pixelsearch,outx,outy, % corner1.x, % corner1.y, % corner2.x, % corner2.y, % dec, % variation, % "Fast RGB " . args
                            return ({x:outx,y:outy,e:errorlevel})
                        }

                        image(corner1,corner2,image) {
                            imagesearch,outx,outy, % corner1.x, % corner1.y, % corner2.x, % corner2.y, % image
                            return ({x:outx,y:outy,e:errorlevel})
                        }
                    }
                
            
            ;/data
                ;/registry
                    class reg extends _ {
                        static defKey:="hkcu\SOFTWARE\.mood\"
                        set(_value,_string) {
                            a:=_value, b:=_string
                            gol:=base.filter(a,"/.+?(?=(\@\@))/is"), value:=((isobject(b))?(base.json.dump(b)):(b)), key:=(base.filter(a,"/(.+?(\@\@))?\K.*/is"))
                            path:=((gol)?(((base.filter(a,"/^(\\)/is"))?(this.defKey . (base.filter(a,"/^(\\)\K(.+?)(?=(\@\@))/is"))):(gol))):(this.defKey . base.info.packageName))
                            regwrite,REG_SZ, % path, % key, % value
                            return
                        }
    
                        get(_value) {
                            a:=_value, gol:=base.filter(a,"/.+?(?=(\@\@))/is"), key:=(base.filter(a,"/(.+?(\@\@))?\K.*/is"))
                            path:=((gol)?(((base.filter(a,"/^(\\)/is"))?(this.defKey . (base.filter(a,"/^(\\)\K(.+?)(?=(\@\@))/is"))):(gol))):(this.defKey . base.info.packageName))
                            regread,t, % path, % key
                            isJson:=base.filter(t,"/^(?:{|{).*(?:}|])$/is"), final:=((isJson)?(base.json.load(isJson)):(t))
                            return final
                        }
    
                        kill(_value*) {
                            for a,b in _value {
                                gol:=base.filter(b,"/.+?(?=(\@\@))/is"), key:=(base.filter(b,"/(.+?(\@\@))?\K.*/is"))
                                path:=((gol)?(((base.filter(b,"/^(\\)/is"))?(this.defKey . (base.filter(b,"/^(\\)\K(.+?)(?=(\@\@))/is"))):(gol))):(this.defKey . base.info.packageName))
                                regdelete, % path, % key
                            } return
                        }
                    }
                
                ;/persistent3
                    class per extends _ {
                        static private
                        static key:="30bf435d-89c8-4801-b275-62b3ab316f0c3e7f6d01dc4ec3293308c671b2489ad4"
                        static default:={}
                        static data:={}
                        static __metadata:={}
                        static override:=0
                        dump(overrideFile:="",iscompiled:="",overrideExit:="",rest*) {
                            ;_.print(overridefile,iscompiled,overrideexit,rest,this.override)
                            ;msgbox, % "we also end up here"
                            file:=((overrideFile!="")?(overrideFile):(a_scriptdir . "\" . a_scriptname))
                            iscomp:=((iscompiled!="")?(iscompiled):(a_iscompiled))
                            if (((rest[1]="reload")&&(iscomp=0))||(this.override!=0))
                                return
                            flag:="/(?:(?:`n|`r`n)\/\*\;\$" . this.key . "(?=`r`n\;\-\-\-))\K.+?(?=`r`n\*\/)/is"
                            this.__metadata["ID"]:=this.bid
                            this.__metadata["TIME"]:=A_Now . A_MSec
                            this.__metadata["data"]:=this.data
                            if (iscomp) {
                                ;_e:=objdump(this.__data,_b),hex:=bintohex(&_b,_e),nm:=file
                                hex:=base.filter(base.json.dump(this.__metadata),"/[""]/is=$0$0","/[$^]/is=``$0"),nm:=file
                                src:="Start-Sleep 0.2`n"
                                . "$args=@{data=""" . (hex) . """;name=""" . (nm) . """}`n$mdf = @""`n[DllImport(""kernel32.dll"", EntryPoint = ""BeginUpdateResou"
                                . "rceW"", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]`n"
                                . "public extern static IntPtr BeginUpdateResourceW(string pFileName,bool bDeleteExistingResources);`n[DllImport(""kernel32.dll"","
                                . " EntryPoint = ""UpdateResourceW"", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = Ca"
                                . "llingConvention.StdCall)]`npublic static extern bool UpdateResourceW(IntPtr hUpdate,string lpType,string lpName,UInt16 wLanguag"
                                . "e,string lpData,UInt32 cbData);`n[DllImport(""kernel32.dll"", EntryPoint = ""EndUpdateResourceW"", SetLastError = true, CharSet"
                                . " = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]`npublic static extern bool EndUpdateR"
                                . "esourceW(IntPtr hUpdate,bool fDiscard);`n""@`n$k32=Add-Type -MemberDefinition $mdf -Name 'Kernel32' -Namespace 'Win32' -PassThr"
                                . "u`n#* yuh`n$hUpdate=($k32::BeginUpdateResourceW($args.name,0))`n$result=($k32::UpdateResourceW($hUpdate,""data"",""persistent"""
                                . ",1033,$args.data,([System.Text.Encoding]::UTF8.GetByteCount($args.data)*2)))`n$final=($k32::EndUpdateResourceW($hUpdate,!($resu"
                                . "lt)))" ;$ resource dump powershell script for exe persistence /\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|/\|
                                base.ps.import(src,"exePersDump"), base.ps.exePersDump()
                                if (overrideExit="")
                                    exitapp
                                return
                            } data:=base.file.read(file),perData:=base.filter(data,flag)
                                perObj:=this.__metadata
                            ;_e:=objdump(perObj,_b),setupObjData:=bintohex(&_b,_e)
                            setupObjData:=base.json.dump(perObj)
                            finalObjData:=base.filter(setupObjData,"/.{1,130}/is=;---$0`r`n")
                            dumpData:="/*;$" . this.key . "`r`n" . finalObjData . "*/"
                            if (perData="")
                                data2write:=data . "`r`n`r`n" . dumpData
                            else
                                data2write:=base.filter(data,"/^.*(?=`r`n(?:`r`n\/\*\;\$" . this.key . "`r`n\;\-\-\-).*\*\/.*$)/is") . "`r`n`r`n" . dumpData
                            base.file.write(file,data2Write)
                            return
                        }

                        pull(overrideFile:="",iscompiled:="") {
                            file:=((overrideFile!="")?(overrideFile):(a_scriptdir . "\" . a_scriptname))
                            iscomp:=((iscompiled!="")?(iscompiled):(a_iscompiled))
                            flag:="/(?:(?:`n|`r`n)\/\*\;\$" . this.key . "(?=`r`n\;\-\-\-))\K.+?(?=`r`n\*\/)/is"
                            if (iscomp) {
                                resget(hexData,file,"persistent","data")
                                ;((hexData!=""&&hexData!="0000000000000000")?(add:=hextobin(bin,strget(&hexdata)),dataObjBack:=objload(add)):(dataObjBack:={}))
                                try
                                    dataObjBack:=base.json.load(strget(&hexdata))
                                if !(dataobjback.count())
                                    dataObjBack:={"data":{}}
                                this.data:=dataObjBack.data
                                return
                            } data:=base.file.read(file), perData:=base.filter(data,flag)
                            if (perData="")
                                return this.data:=this.default
                            hexdata:=base.filter(perData,"/(?:`r`n\;\-\-\-)/is=")
                            ;add:=hextobin(bin,strget(&hexdata)),_f:=objload(add)
                            _f:=_.json.load(hexdata)
                            if !(_f.id)
                                _fr:={}, _fr.data:=_f, this.__metadata.ID:=this.bid, this.__metadata.TIME:=A_Now . A_MSec
                            else
                                _fr:=_f, this.__metadata.ID:=_fr.id, this.__metadata.TIME:=_fr.time
                            return this.data:=_fr.data
                        }
                        
                    }
                    

                ;/json
                    class JSON extends _ {
                        static version := "0.4.1-git-built"

                        BoolsAsInts[]
                        {
                            get
                            {
                                this._init()
                                return NumGet(this.lib.bBoolsAsInts, "Int")
                            }

                            set
                            {
                                this._init()
                                NumPut(value, this.lib.bBoolsAsInts, "Int")
                                return value
                            }
                        }

                        EscapeUnicode[]
                        {
                            get
                            {
                                this._init()
                                return NumGet(this.lib.bEscapeUnicode, "Int")
                            }

                            set
                            {
                                this._init()
                                NumPut(value, this.lib.bEscapeUnicode, "Int")
                                return value
                            }
                        }

                        _init()
                        {
                            if (this.lib)
                                return
                            this.lib := this._LoadLib()

                            ; Populate globals
                            NumPut(&this.True, this.lib.objTrue, "UPtr")
                            NumPut(&this.False, this.lib.objFalse, "UPtr")
                            NumPut(&this.Null, this.lib.objNull, "UPtr")

                            this.fnGetObj := Func("Object")
                            NumPut(&this.fnGetObj, this.lib.fnGetObj, "UPtr")

                            this.fnCastString := Func("Format").Bind("{}")
                            NumPut(&this.fnCastString, this.lib.fnCastString, "UPtr")
                        }

                        _LoadLib32Bit() {
                            static CodeBase64 := ""
                            . "FLYQAQAAAAEwVYnlEFOB7LQAkItFFACIhXT///+LRUAIixCh4BYASAAgOcIPhKQAcMdFAvQAFADrOIN9DAAAdCGLRfQF6AEAQA+2GItFDIsAAI1I"
                            . "AotVDIkACmYPvtNmiRAg6w2LRRAAKlABwQAOiRCDRfQAEAViIACEwHW5AMaZiSBFoIlVpAEhRCQmCABGAAYEjQATBCSg6CYcAAACaRQLXlDHACIA"
                            . "DFy4AZfpgK0HAADGRfMAxAgIi1AAkwiLQBAQOcJ1RwATAcdFCuwCuykCHAyLRewAweAEAdCJRbACiwABQAiLVeyDAMIBOdAPlMCIAEXzg0XsAYB9"
                            . "EPMAdAuEIkXsfIrGgkUkAgsHu1sBJpgFu3uCmYlOiRiMTQSAvYGnAHRQx0Wi6Auf6AX5KJ/oAAQjhRgCn8dF5AJ7qQULgUGDauSEaqyDfeSwAA+O"
                            . "qYAPE6EsDaGhhSlSx0XgiyngqilO4AACRQyCKesnUyAgIVUgZcdF3EIgVMdERdiLItgF/Kgi2EcAAkUMgiKDRdyABBiAO0XcfaQPtoB5gPABhMAP"
                            . "hJ/AwIHCeRg5ReR9fOScGItFrMCNALCYiVVKnA2wmAGwZRlEXxfNDxPpgTjKE+nKQgSAIaIcgCEPjZ9C3NQLQOjUBf4oQNQAAkUMRNyhxCyQiVWU"
                            . "zSyQYRaUsRiYbivqC+scwwlgi1UQiVTgCOAEVKQkBIEIYBqVCDqtKAN/Q4ctDIP4AXUek0EBLg76FwBhnAIBKKEDBQYPhV7COqzAmIbkICAAgVXH"
                            . "RdDLKbjQBQcAB98pwynQAAETJQbCKekqJA4QodzFRgzMSwzMBQxfDEYM7swAASUGQwzHphiBsUMMYshLDMgFEl8MRgzIFwABJQZDDGRCDBiNSBAB"
                            . "D7aVg7+siwAoiUwkoSwMjy3N+TD//+kv5BKBLQV1liBCBk8FVsBJ6QRIBYgCdWlAAY1VgCUEVNQUwVzEIho3IhogAItViItFxAHAiI0cAioaD7cT"
                            . "ERoExAEFBgHQD7cAgGaFwHW36ZCiZ2LACyXABRcfJeYKwM8AASUGpmcuHIAVv9RGCgbkAAHjyeQPjEj6RP//ZJ4PhLXiFbzt6xW8P6+IC7wAASUG"
                            . "BMRv4uLhqGH7CAu0/6iIBbQXgAAVA3RUuCABuDtFqBh8pFpxXVNxfV9xA11xkgmLXfzJw5DOkLEaAgBwiFdWkIizUYoMMBQUcQDHQAjRAdjHQAxS"
                            . "DIAECIEEwCEOCJFBwABhH4P4IHQi5dgACnTX2AANdCLJ2AAJdLvYAHsPjIVygjxoBcdFoDIHVkWBj2AAqGMArGEAoYaM8AjQLkAYixWhAJDHRCQg"
                            . "4gFEJCCLIAAAjU2QwDMYjdRNoGAAFFABEEGWcAAf8gtwAOMMQFdxAIkUJED/0IPsJItAY0U+sN8N3w3fDd8N1wB9D6yEVARuEgGFEG9DCQFAg/gi"
                            . "dAq4YCj/xOm/EAqNRYDxYOEHAeAtaf7//4XAdPoX8wGf8AH/Cf8J/wn/CXXVADrFB0LPBZJplAjfVv2SCMQCFcICiIM4CP1jArCyZ4ABTxRPCk8K"
                            . "TwqR1wAsdRIqBelUcBFmkFkWhQl8C18MgCwJQQIxVbCJUAjDqlTDdQLzA1sPhfBFGTYovIVwwUGxIjK5kwB4lgDOfJQA/yj8KI1gkAIiKZ6NEQVf"
                            . "KV8pVimFaBED/EW00KbxAq8VrxWvFa8VYdcAXQ+EtpSP9imlkwNA2B/h+9kfFwr1AdXgi+RjArRhArpQFS8Kby8KLwovCtkfFioFgVzplgGACBkg"
                            . "XcUJegkfIDUXILQWIFJ1AkQ4D4VMYwPvNYB4ReCSA+DDkAOjBAgA6e8FSxRvDbQH/pEgNwVcD4WqF51NKQdxe+CAAYlV4LsCazsuizkGwATbAlzc"
                            . "Aqpd2wIv2wIv3AIv2wKqYtsCCNwCAdsCZtsCqgzcAtPbTW7bAgrcAqql2wJy2wIN3AJ32wIudNsCMR7ZAknbAnUPfIURTT7gA4ADsWVCz+nPwdcw"
                            . "AQADoNyJwuEBOhuIL34w2AA5fyLDAoORAlMBAdCD6DCFAwTpgKk1g/hAfi0B2ADAtwBGfx+LReAPtwAAicKLRQiLAEEAkAHQg+g3AXDgIGaJEOtF"
                            . "BVhmg1D4YH4tCDRmE+hXEQZ0Crj/AADpbQZEAAACQI1QAgAOiQAQg0XcAYN93BADD44WAD6DReAoAusmAypCBCoQjQpKAioIAEmNSAKJGk0AZhIA"
                            . "Ugh9Ig+FAP/8//+LRQyLEkgBJinIAXcMi0AQCIPoBAEp4GbHCgAMeLgAEADp3QUjBBYDSC10JIgGLw8IjrEDig85D4+foYAIx0XYAYInDIArIhSB"
                            . "A8dACIEnx0DmDAEDiSh1FIAWAWiKPjGIEDB1IxMghRXpjhELKTB+dQlJf2frCkcBdlCBd2vaCmtAyAAB2bsKgBn3AOMB0YnKi00IAIsJjXECi10I"
                            . "AIkzD7cxD7/OAInLwfsfAcgRANqDwNCD0v+LAE0MiUEIiVEMSck+fhoJGX6dRXCrEAQAAJCIBi4PhYalTSyGI2YPbsDAAADKZg9iwWYP1mSFUEAQ"
                            . "361BAYAI3VZYwGpBUAUAVNQBVOsAQotV1InQweAAAgHQAcCJRdQBQxVIAotVCIkKAcAbmIPoMImFTIXAD9tDAUXU3vmBErBACN7BhRTIMA7KMCKi"
                            . "SANldBJIA0UPHIVVACANMQMHFHUxVQk00MAA2gA00wA0lVEVNMZF00uBE0AEAY3KF+tAzAYIK3URhgxX0IhNMsRiH8KizEGM61Ani1XMh07DUU4B"
                            . "ENiJRcxYFb3HRSLIwTDHRcRCChOLhFXIqDHIg0XEQBgAxDtFzHzlgH0Q0wB0E0Mv20XIoaMwWAjrEUcCyUYiFeUoKyR0WCBN2JmJAN8Pr/iJ1g+v"
                            . "APEB/vfhjQwWk2FVJFHrHcYGBXVmCibYcApELgMAA3oMAqFqZXQPhasiGsAiGgA3i0XABQcXAAAAD7YAZg++0FEmBTnCdGQqy+1AgwxFwKAexgaE"
                            . "wHW6lA+2wIYAQAF0G6UPJ0N4oidDeOssQwMJABCLFeQWgoWJUAhCoUIBAItABKMCiYAUJP/Qg+wEgxcuT2UPhKqFF7yFF7wF6gyaFw6PF7yAF8YG"
                            . "mhf76I+JF9yHF0IBgxdBAYsXgpKrlG51f8dFIgOA6zSLRbgFEhMX0gcCF+tYrBa4oBZmBvWgFr3nEeDnEUIB4xFBAQnqEesFIguNZfRbMF5fXcNB"
                            . "AgUAIlUAbmtub3duX08AYmplY3RfAA0KCiALIqUBdHJ1ZQAAZmFsc2UAbgh1bGzHBVZhbHUAZV8AMDEyMzQANTY3ODlBQkMAREVGAFWJ5VNAg+xU"
                            . "x0X0ZreLAEAUjVX0iVQkIBTHRCQQIitEJKIMwUONVQzAAgjAAQ8AqaAF4HPDFhjHReSpAgVF6MMA7MMA8IMKcBCJReRgAuPOIgwYqItV9MAIIKQL"
                            . "HOQAghjhAI1N5IlMgw/fwQyBD8QDwjwgEAQnD2De0hCDNgl1MCEQcE7xBUAIi1UQi1JFAgTE62hmAgN1XGECElESu0AWf7lBBTnDGSjRfBWGAT0g"
                            . "AYCJQNCD2P99LvAajTRV4HEPiXAPMR4EJATooQAChcB0EYsETeBGA4kBiVEEAJCLXfzJw5CQAXAVg+xYZsdF7ikTH0XwIBYUARBNDAC6zczMzInI"
                            . "9xDiweoDNkopwYkCyhAHwDCDbfQBgSGA9GaJVEXGsAMJ4gL34pAC6AOJRQAMg30MAHW5jUJVoAH0AcABkAIQDYAJCGIRwwko/v//hpBACLMdYMdF"
                            . "+EIuBhrkRcAKRfjB4AQgAdCJRdgBAUAYwDlF+A+NRPAZAAsKzlEC2PEMRfTGRQDzAIN99AB5B2GQAAH3XfRQHEMM9KC6Z2ZmZkAM6nAJhPgCUnkp"
                            . "2InC/wyog23s8gzs8QymngNAwfkficopoAj0AYEGdaWAffMAdAYOQQMhA8dERaYtHXAnpsAAwA5gAtDGRYbrkCXiJotF5I0hjCDQAdAPtzBn5I3S"
                            . "DMEWAcgDOnWQOQgCQABmhcB1GSUBDGUmAQYQBQHrEKG8AnQDUIS8AnQHg0XkAQDrh5CAfesAD2aEoWbhH1XYMJnRLemSyiQuQBwhFYyj4gChwxTU"
                            . "xkXjgAvcgwvq3IIF1IQL3I8LCAKFC/sjAYoL44ILvAKBC7wCgQtC3IML4wB0D0oL65AYg0X48n1AEFIL8Nf9//9ySLosvz1iABNyQ2Aj6AWBD90A"
                            . "3RpdkC7YswGyDsdF4ONjACIbjUXoUCcwAZEH7KGIED3jQBWhAB1BIXXATCQYjU3YBUFCav8MQeVIFUEhCz8LPwvAATES0QAxBIsAADqJIEmfC3+f"
                            . "C58LnwufC58Lnws2O2Q9wAnmkgrSNjQKV0l8GIM1AStMfW6NRahoSib2kEBUD+s3gUN0IACLVbCLRfABwFSNHPBqDHSWDHGWE12xzg2hIcBs8CAQ"
                            . "wWzw1gEFA2YntzNzPvR60xMA7IN97AB5bYtMTeyPQY9BuDAQBCk60KpOvr4DpkHCBXWjB+ECwQJAQb4tAOtbX88GzwZfVa8GrwalhCPrQj5CEyeN"
                            . "Vb7WVuhnvxO/E7IT6AF8AyYUqWvpNbMqGJIGF3oFUIMimADpyXLcmAXpt5PdKQTkdVaiAxStA1wAVx0JHwYTBmMeBlEZBlxPHwYfBh8GaALpAR4G"
                            . "73vTaBMGCB8GHwYfBmYCYgAAgrEA6Z8CAACLRRAgiwCNUAEAcIkQBOmNAogID7cAZgCD+Ax1VoN9DEAAdBSLRQwAjEgAAotVDIkKZsdgAFwA6w0K"
                            . "3AJMF6ENTGYA6T0OwisJwoIKPGFuAOnbAQ1hFskCEQRhDTxhcgDpKnmOMGeJMAm8MHQAFOkXjjAFgAgPtgUABAAAAITAdCkRBjYfdgyGBX52B0K4"
                            . "ABMA6wW4gAIAoIPgAeszCBQYCBTCE4QFPaAAdw0awBc2bykwjgl1jQkDGw+3AMCLVRCJVCQIAQEKVCQEiQQk6DptgR4rwhHAJ8gRi1UhwAwSZokQ"
                            . "jRxFCAICBC+FwA+FOvwU//9TISJNIZDJwwCQkJBVieVTgwTsJIAQZolF2McARfAnFwAAx0UC+AE/6y0Pt0XYAIPgD4nCi0XwAAHQD7YAZg++ANCL"
                            . "RfhmiVRFQugBB2bB6AQBDoMARfgBg334A36gzcdF9APBDjOCIQAci0X0D7dcRZLoiiOJ2hAybfRAEBD0AHnHAl6LXfwBwic="
                            static Code := false
                            if ((A_PtrSize * 8) != 32) {
                                base.error("_LoadLib32Bit does not support " (A_PtrSize * 8) " bit AHK, please run using 32 bit AHK")
                            }
                            ; MCL standalone loader https://github.com/G33kDude/MCLib.ahk
                            ; Copyright (c) 2021 G33kDude, CloakerSmoker (CC-BY-4.0)
                            ; https://creativecommons.org/licenses/by/4.0/
                            if (!Code) {
                                CompressedSize := VarSetCapacity(DecompressionBuffer, 3935, 0)
                                if !DllCall("Crypt32\CryptStringToBinary","Str",CodeBase64,"UInt",0,"UInt",1,"Ptr",&DecompressionBuffer,"UInt*",CompressedSize,"Ptr",0,"Ptr",0,"UInt")
                                    base.error("Failed to convert MCLib b64 to binary")
                                if !(pCode := DllCall("GlobalAlloc", "UInt", 0, "Ptr", 9092, "Ptr"))
                                    base.error("Failed to reserve MCLib memory")
                                DecompressedSize := 0
                                if (DllCall("ntdll\RtlDecompressBuffer","UShort",0x102,"Ptr",pCode,"UInt",9092,"Ptr",&DecompressionBuffer,"UInt",CompressedSize,"UInt*",0,"UInt"))
                                    base.error("Error calling RtlDecompressBuffer",, Format("0x{:08x}", r))
                                tArr:=[33, 66, 116, 385, 435, 552, 602, 691, 741, 948, 998, 1256
                                , 1283, 1333, 1355, 1382, 1432, 1454, 1481, 1531, 1778, 1828
                                , 1954, 2004, 2043, 2093, 2360, 2371, 3016, 3027, 5351, 5406
                                , 5420, 5465, 5476, 5487, 5540, 5595, 5609, 5654, 5665, 5676
                                , 5725, 5777, 5798, 5809, 5820, 7094, 7105, 7280, 7291, 8610
                                , 8949]
                                for k, Offset in tArr {
                                    Old := NumGet(pCode + 0, Offset, "Ptr")
                                    NumPut(Old + pCode, pCode + 0, Offset, "Ptr")
                                }
                                OldProtect := 0
                                if !DllCall("VirtualProtect", "Ptr", pCode, "Ptr", 9092, "UInt", 0x40, "UInt*", OldProtect, "UInt")
                                    base.error("Failed to mark MCLib memory as executable")
                                Exports := {}
                                tObj:={"bBoolsAsInts":0,"bEscapeUnicode":4,"dumps":8,"fnCastString":2184,"fnGetObj":2188,"loads":2192,"objFalse":5852,"objNull":5856,"objTrue":5860}
                                for ExportName, ExportOffset in tObj {
                                    Exports[ExportName] := pCode + ExportOffset
                                }
                                Code := Exports
                            }
                            return Code
                        }
                        _LoadLib64Bit() {
                            static CodeBase64 := ""
                            . "xrUMAQALAA3wVUiJ5RBIgezAAChIiU0AEEiJVRhMiUUAIESJyIhFKEggi0UQSIsABAWVAh0APosASDnCD0SEvABWx0X8AXrrAEdIg30YAHQtAItF"
                            . "/EiYSI0VQo0ATkQPtgQAZkUCGAFgjUgCSItVABhIiQpmQQ++QNBmiRDrDwAbICCLAI1QAQEIiRDQg0X8AQU/TQA/AT4QhMB1pQJ9iUWgEEiLTSAC"
                            . "Q41FoABJichIicHoRhYjAI4CeRkQaMcAIgoADmW4gVfpFgkAMADGRfuAZYFsUDBJgwNAIABsdVsADAEox0X0Amw1hBAYiwRF9IBMweAFSAGa0IBG"
                            . "sIALgAFQEIALGIPAAQANAImUwIgARfuDRfQBgH2Q+wB0EwEZY9AILRR8sgNWLIIPCEG4wlsBMQZBuHsBuw9gBESJj1+AfSgAdFBkx0XwjLvwgpsm"
                            . "mhyxu/DAXcMP5hvHXcjHRezCSqUGAidEQQLsSUGog33sAA8sjsqBL5hhLJQxZsfUReiMMeiCIV+AIa8xluiAMcMPH4gx6y+ZJkIglCZ5x0XkgiZo"
                            . "KMdF4Mwo4MIYvhpt8SjgwCjDD37AD8UogwRF5MAFMDtF5H0IkA+2wJDwAYTAuA+E6EDpQVwGkTBBmdyNiZxbUL1AAajgB+FoSpjoaJjkaP4fJQoc"
                            . "mTQK6f5DVIkK6epgAo3qEzjiE0Fsx0XcrCay3KIeihm/Jq8m3KAjXeMHSuAHCIOFGpCIGpAthBophhrWJCwsDesbp2YK5AlkCb0gewk6UC4Dv04t"
                            . "NItAGIP4AU51YTCAEAoQXB4gcReGA2Iw4wQGD4Wf4EMzYwVhswkYoAHgl2nH1EXYbC/YYicXAAR/L01tL9hgL+MH1xdnL+m0iwJpD21AA2QP1GwP"
                            . "utRiB6AABH8PbQ/UYA9V4wdgaQ8Pag8BZw/QtWwP0GIHKn8PcA/QYA8p4wfqFmgPk2JyMI00SAFACk1B48AQAExDgAZBColMJCDBNa1g+P//6WjE"
                            . "M8I1Bax1H2QFLDtiITs9SQUQAg+Fg6NtqEiNoJVw////4QSKYJoox0XMIhxIIxwuSIiLlXjAA4tFzAAVYAHATI0EABttHEHoD7cQUxzMkAAKBFBd"
                            . "AA+3AGaFwHWeVOmqUjzIHBXIEhHdbhUfFR8V7QbIEBXzA5338ANbPCoRb6AO7zMPTtoFDuzQBahI8XYPjET5RP//8VwPhN3iDMTl7AzE4gjwFO8M"
                            . "7wwNB/bEAAfzA7DwA1dzMZRyY+sBkskGvMIChs8GzwbOBha8wAbzA0bIBoNFwIFwAcA7RTB8kKyFOl2khX2vha+FqJFIgeLEAQxdw5AKAOyiDgAK"
                            . "VcCjMEEsjawkgBVCpI2zpJURJEiLhQthAKAbFLUASMdACNvyEZAJhaICAQpQAArTAAcRUXUBMSmD+CB01REtAQp0wi0BDXSvES0BCXScLQF7D4WO"
                            . "KcJUrweiB8dFUMIQKMdFWHQAYHIAiwWOA+E4AT9BowX1/tAAEMdEJEBTAkQkOAGCAI1VMEiJVCSqMIAAUIEAKJABICG3VEG58QFBkha6ogKJUMFB"
                            . "/9LwFzhQbGh/zxDPEM8QzxDPEM8QJwF9WA+EwvJHaQGF8IesgV4Bg/gidAq4IBDw/+lmEYEOoblgB8IeAOj3/f//hcB0+iIDAkUBAu8M7wzvDO8M"
                            . "l+8M7wwkAToVCsQQDwi3CAhSKMcLOsMLtAOIsgNJsDKLjQMsRWjESQL/YA1/Go8Njw2PDY8Njw0nAZgsdR1vB2MH6cLQC+dAkIwd1Qy6D58QnBCw"
                            . "OQIJtjmLVWhIiVAaCLPSfcoDkwVbD4W+ZUJ4PwX0M/LJcAD4dADTUkIQM8P7+TO10QD/M+yNVdDF8zPw/zP/M+AZwtjwM3DHhay07R8aPx8aHxof"
                            . "Gh8aHxonAV0PNoRh45803kdQKCfH+pkpJxUOMQLiJouVcQz1UA1wRCftMBgvDS8NLw0BJAH+tQAKdMJIi4XAAAAAAEiLAA+3AEBmg/gNdK8NkAlE"
                            . "dJwNSCx1JAdISAiNUAIFGokQg4UCrAAQAemq/v//gpANbl10Crj/AAC46T4NASoTggAJyAAJMGbHAAkBIwELSIuAVXBIiVAIuAALGADpAQo8A1ki"
                            . "D4WMEwUaUwUXiYWgAgkdBFiVggaALQc7CADpRFkEDTGFwHWEXYKCDA8/XA+F9gMhP7mEVnU0AAmCPIETiQJC5YA8IpYg6ccKL4Q6FCOqXBcjgBAj"
                            . "L5QRL5cRKjmQEWKUEQiXEfICVY8RZpQRDJcRq5ARblWUEQqXEWSQEXKUEQ11lxEdkBF0lBFCuJMR1sIBjxF1D4WFigWOmcHEFQAAx4WcAcvByw47"
                            . "gwyBBoARweAEiUeB/UIKT1MvfkJNAjkcfy/HB2IHxwMB0INk6DDpCemuo2sqCEBEfj9NAkZ/LJoKN6mJCutczQdgLwpmPAqmVyoKhHm1CNcpg0Io"
                            . "CAGDvcEAAw+OuIlAmkiDIggC6zrjB8J16QcQSI1K5wchitUjPkggPo0DExJQLmCXLJD7QAtFkkgmBynIBkiCFuMCQAhIg+hOBMs8dRcjpdcHbzEt"
                            . "xHQubj4PjgyKp+Q+iA+P9eCgx4WYwSDLh6YADxQGqMdAICCwDDx1IuMGoSTfooMGMHUPITjTCk1+cA4wD46JwdACOX9260yGKAC9AInQSMHgAkgB"
                            . "gNBIAcBJicBpDCkgNYuVYwwKoAdID6C/wEwBwGAP0AUISyPFTGYfbg5+jiVMUwgGAAAO4S4PheYD2BtIPmYP78DySIwPKsEUYQLyDxHgQBUGMQXA"
                            . "M5TEM+tsixKVYQGJ0MAbAdAB7MCJQgP4G5jAOwIG8AUNcADScAASBGYPKMgQ8g9eyjYHEEAIsPIPWME8CFwQFw8kTI5q6h9jAWV0ngJFuA+F+I9N"
                            . "/RCzAhRXImP/Ef8RxoWTDyoBKiFNkwEBTwdDB+syPQMr3HUf3gQfLUsRE68hhCEKOrI1jFRa6zqLlduxAMYbQZ8pnBtEER4xA4NfB18HfqDHhYiE"
                            . "IojHhYRVBxyLlVEBSygj4QCDAgIBi2IAOyEyBnzWgL2iD3Qq61kh4BfJUCONUQMQIxoilOsolwJIgxoPKvIFePIPWb0k+R3BpdU6i0FSREiYSA+v"
                            . "OTjr8jg6AwV1vwawBqEDvwalugYMtyIDAFNToQ98oPh0D4XfkhOAlROMUouyAJAJjRXSEAOAD7YEEGYPvkEK6ZgDOcIlr0taBZ1moQQL8BYWBYAU"
                            . "BYTAdZcAD7YFUuT//4T4wHQdyQqoUtI/FRFkhcwVDgMHV0sF/CI2Q1AIiwXu0QCJwf/SBVMPq/+G+GYPhdMJUQ9FfCIPTItFfN3SCeewAv8O+w5b"
                            . "/zz3DmhFfAG1BJu0BJAOoLmQDmjjnw5MYZ4OBKMGbZgO8lQHkw7kggGWDsFBLzP4bg+FpZIOeKESBkmLRXjSCQOfDmWXDgeSDut0bw5lDnhbYA6D"
                            . "BLoxJ2MOo+wLVSv4yOMLQ+oLNeoL6wUhUgdIgcQwsAldwz6QBwCkKQ8ADwACACJVAG5rbm93bl9PAGJqZWN0XwANCgoQCSLVAHRydWUAAGZhbHNl"
                            . "AG4IdWxs5wJWYWx1AGVfADAxMjM0ADU2Nzg5QUJDAERFRgBVSInlAEiDxIBIiU0QAEiJVRhMiUUgaMdF/ANTRcBREVsoAEiNTRhIjVX8AEiJVCQo"
                            . "x0QkEiDxAUG5MSxJicgDcRJgAk0Q/9BIx0RF4NIAx0XodADwwbQEIEiJReDgAFOJAaIFTItQMItF/IpIEAVA0wJEJDiFAOIwggCNVeBGB8BXQAcH"
                            . "ogdiFXGWTRBB/9Lz0QWE73UeogaBl8IYYAYT5ADRGOtgpwIDdVODtQEBDIBIOdB9QG4V1AK68Bp/Qhs50H9l4FNF8Q/YSXCIUwfooUE2hcB0D6AB"
                            . "2LDuBVADUjAGEJBIg+xmgBge8xXsYPEV5BVmo7IREAWJRfigFhSABACLTRiJyrjNzATMzDBTwkjB6CAgicLB6gMmXinBAInKidCDwDCDzLQAbfwB"
                            . "icKLRfwASJhmiVRFwIsARRiJwrjNzMwAzEgPr8JIwegAIMHoA4lFGIMAfRgAdalIjVUDAIQArEgBwEgB0ABIi1UgSYnQSACJwkiLTRDoAQD+//+Q"
                            . "SIPEYAhdw5AGAFVIieUASIPscEiJTRAASIlVGEyJRSAQx0X8AAAA6a4CAAAASItFEEiLRFAYA1bB4AUBV4k0RdABD2MAYQEdQDAASDnCD42aAQBg"
                            . "AGbHRbgCNAAaQAEAUEXwxkXvAEhAg33wAHkIAAoBAEj3XfDHRegUgwBfAJTwSLpnZgMAgEiJyEj36kgArgDB+AJJichJwWD4P0wpwAG8gQngBgIB"
                            . "PABrKcFIicoAidCDwDCDbegVgo3og42QmCdIwflSPwAbSCmBXfACR3WAgIB97wB0EIEigYMhx0RFkC0AgKEGkIIHhKGJRcDGRSDnAMdF4IGJi0Uy"
                            . "4IAMjRQBcQEPD7cKEAQJDAEJGEgByAAPtwBmOcJ1b4EPFQBmhcB1HokLi4AXhQsGgDIB6zqTGgR0IlMNdAqDReAQAelm/0B2gH3nkAAPhPYCVkUg"
                            . "wH6JwC4QuMBkAOkBQAFlCmw4AWyMysMKhWrIqMZF38A52MM52IYb/sjFOYIE0DmNCsU5xwXLOb7fwjlRDcE5UQ3BOdjGORDfAHQSzTjrIIMsRfwA"
                            . "cgg5IAI5O/0M//+ApEA6g8RwXWLDwruB7JABBIS8SGvEdsAB6MQB8MEBwLLgAgUCwPIPEADyD6IRQIXHRcCECMjEAXrQwgGNgGdAioADASNIAIsF"
                            . "hOb//0iLoABMi1AwQAN2QQMQx0QkQAMNRCQ4hQICiwAfiVQkMMHtlQECKEAGIAEQQbnBBwpBwi26QgWJwUH/sNJIgcQBF/B3QOl3fwAXABmgeKNs"
                            . "gSEACOReD0yJm39veW+4MOAHKRzQgyyTv2+pbw+Feg9gOWEIIwhgb8AtAOkegF8T34IfE9qCx0XsCSEu61DgARgAdDYLi6oAC+xCAUyNBAIzYlRg"
                            . "K41IQAFhOQpBQQBlZokQ6w/hU4sQAI1QAQEBiRCDWEXsARQJR2OO5VRAWyc85Dsg6TsDExyvD2aAxwAiAOleBEOAKcgP6UpjAhAhDYP4KCJ1ZmMI"
                            . "GXIIXADT7hdcDuYDTw7SYwJEDk5cXw5fDsgF6XNQDl8dSg4IXw5fDsYFYgDp2gBQDuxk5EMODF8OXw5hxgVmAOmNwwsqB3l9KgcKLwcvBy8HLwfi"
                            . "Am5IAOkaLwfpBioHDR8vBy8HLwcvB+ICcgDptqcwTy0HkzMBJAcJLwcPLwcvBy8H4gJ0AOk0BS8H6aFXD7YFmdZA//+EwHQr1wcfRHYNxwB+dgcT"
                            . "ZwVB4jqD4AHrNqkCGoWpAhTFAD2gAHd9A31ABnxfDV8NXg3vAuECdbPvAtQHD7dRUPFyGCBUUInB6IZxCDTDBB43zwRgAGADEo9MAQhFEANxT0IN"
                            . "hcAPhab736BtXwnYQT4EQaggJE71TQtgWdVriQBrjQVC8wdwBVBZxKjrMg+3RXAQg+AP0qzAWlBTtrAAZg++kqiSXugRAjBmwegEEQTRgIN9gPwD"
                            . "fsjHRfhwOwgA6z9TCiWLRfjASJhED7dE4HwOC5hEicJfD+BbbfjQBDD4AHm7JVr1Cw=="
                            static Code := false
                            if ((A_PtrSize * 8) != 64) {
                                base.error("_LoadLib64Bit does not support " (A_PtrSize * 8) " bit AHK, please run using 64 bit AHK")
                            }
                            ; MCL standalone loader https://github.com/G33kDude/MCLib.ahk
                            ; Copyright (c) 2021 G33kDude, CloakerSmoker (CC-BY-4.0)
                            ; https://creativecommons.org/licenses/by/4.0/
                            if (!Code) {
                                CompressedSize := VarSetCapacity(DecompressionBuffer, 4249, 0)
                                if !DllCall("Crypt32\CryptStringToBinary","Str",CodeBase64,"UInt",0,"UInt",1,"Ptr",&DecompressionBuffer,"UInt*",CompressedSize,"Ptr",0,"Ptr",0,"UInt")
                                    base.error("Failed to convert MCLib b64 to binary")
                                if !(pCode := DllCall("GlobalAlloc", "UInt", 0, "Ptr", 11168, "Ptr"))
                                    base.error("Failed to reserve MCLib memory")
                                DecompressedSize := 0
                                if (DllCall("ntdll\RtlDecompressBuffer","UShort",0x102,"Ptr",pCode,"UInt",11168,"Ptr",&DecompressionBuffer,"UInt",CompressedSize,"UInt*",0,"UInt"))
                                    base.error("Error calling RtlDecompressBuffer",, Format("0x{:08x}", r))
                                OldProtect := 0
                                if !DllCall("VirtualProtect", "Ptr", pCode, "Ptr", 11168, "UInt", 0x40, "UInt*", OldProtect, "UInt")
                                    base.error("Failed to mark MCLib memory as executable")
                                Exports := {}
                                tObj:={"bBoolsAsInts":0,"bEscapeUnicode":16,"dumps":32,"fnCastString":2624,"fnGetObj":2640,"loads":2656,"objFalse":7632,"objNull":7648,"objTrue":7664}
                                for ExportName, ExportOffset in tObj {
                                    Exports[ExportName] := pCode + ExportOffset
                                }
                                Code := Exports
                            }
                            return Code
                        }
                        _LoadLib() {
                            return A_PtrSize = 4 ? this._LoadLib32Bit() : this._LoadLib64Bit()
                        }

                        Dump(obj, pretty := 0)
                        {
                            this._init()
                            if (!IsObject(obj))
                                base.error("Input must be object")
                            size := 0
                            DllCall(this.lib.dumps, "Ptr", &obj, "Ptr", 0, "Int*", size
                            , "Int", !!pretty, "Int", 0, "CDecl Ptr")
                            VarSetCapacity(buf, size*2+2, 0)
                            DllCall(this.lib.dumps, "Ptr", &obj, "Ptr*", &buf, "Int*", size
                            , "Int", !!pretty, "Int", 0, "CDecl Ptr")
                            return StrGet(&buf, size, "UTF-16")
                        }

                        Load(json)
                        {
                            this._init()
                            if (isobject(json)) {
                                for a,b in json
                                    temp:=temp . b
                                json:=temp
                            }
                            t:=base.filter(json,"/(?:(?:\{|\[).*(?:\}|\])(?!\s*(?:\,|\}|\])))/is"), json:=((t)?(t):base.error("invalid input","-2"))

                            _json := " " json ;\\Prefix with a space to provide room for BSTR prefixes
                            VarSetCapacity(pJson, A_PtrSize)
                            NumPut(&_json, &pJson, 0, "Ptr")

                            VarSetCapacity(pResult, 24)

                            if (r := DllCall(this.lib.loads, "Ptr", &pJson, "Ptr", &pResult , "CDecl Int")) || ErrorLevel
                            {
                                base.error("Failed to parse JSON (" r "," ErrorLevel ")", -1
                                , Format("Unexpected character at position {}: '{}'"
                                , (NumGet(pJson)-&_json)//2, Chr(NumGet(NumGet(pJson), "short"))))
                            }

                            result := ComObject(0x400C, &pResult)[]
                            if (IsObject(result))
                                ObjRelease(&result)
                            return result
                        }

                        file(_file) {
                            isRoot:=base.filter(_file,"/(^(?:\\).*$)/is"), ((isRoot)?(_file:=a_scriptdir isRoot):(""))
                            fileread, content, % "" _file ""
                            if (errorlevel="1")
                                base.error("file doesn't exist",-2)
                            return this.load(content)
                        }

                        open(_obj) {
                            if !(isobject(_obj))
                                base.error("input has to be object","-2")
                            return base.file.edit(_obj)
                        }

                        True[]
                        {
                            get
                            {
                                static _ := {"value": true, "name": "true"}
                                return _
                            }
                        }

                        False[]
                        {
                            get
                            {
                                static _ := {"value": false, "name": "false"}
                                return _
                            }
                        }

                        Null[]
                        {
                            get
                            {
                                static _ := {"value": "", "name": "null"}
                                return _
                            }
                        }
                    } ;@ json
                    /* info
                        ?\ this json library works with extensions.
                        ?\ meant for _.urlLoad()
                        will accept arrays as input, will collapse each index into a continous string
                        auto detects json objects out of said collapsed string, maybe lol :>
                        *\ regex might need to be updated later, rn it works
                    */
                
                ;/backup
                    class backup extends _ {
                        static private
                        start() {
                            if (this.thr)
                                return 0
                            base.per.bid:=((base.per.__metadata.ID!="")?(base.per.__metadata.ID):(base.uuid))
                            regkey:="\" . base.info.packageName . "\" . base.per.bid . "@@backup"
                            backupData:=base.reg.get(regkey)
                            if (backupdata.time>base.per.__metadata.time) {
                                base.per.__metdata.id:=backupdata.id
                                base.per.__metdata.time:=backupdata.time
                                base.per.data:=backupdata.data
                            }
                            className:=base.__class, trayIcon:="#noTrayIcon`n"
                            backupTime:="900000" ;420000
                            thread:="#persistent`n" . trayIcon . "setbatchlines, % ""-1""`nSetKeyDelay, -1, -1`nSendMode, input`n#MaxHotkeysPerInterval 99999`n"
                             . "#MaxThreadsPerHotkey 1`n" . className . ":=objshare(" . objshare(_) . ")`nbfc:=objbindmethod(_.backup,""force"")`nsettimer, % "
                             . "bfc, " . backupTime . "`nreturn`nturnOff(string:="""") {`nsuspend, % string`nreturn`n}`n"
                            this.thr:=ahkthread(thread)
                            return 1
                        }

                        force() {
                            regkey:="\" . base.info.packageName . "\" . base.per.bid . "@@backup"
                            temp:={}
                            temp["ID"]:=base.per.bid
                            temp["TIME"]:=A_Now . A_MSec
                            temp["data"]:=base.per.data
                            base.reg.set(regkey,temp)
                            return
                        }
                    }
                
                ;/fco
                    fco(obj) {
                        try
                            final:=ObjClone(obj)
                        for a,b in final {
                            ;_.print(a,b,"#")
                            if ((isobject(b)))
                                try
                                    final[a]:=this.fco(b)
                            if (final[a]="")
                                final[a]:=b
                        }
                        return final
                    }
                
            
            ;/managment
                log(_content:="Exception thrown",_bypass:="0") {
                    this.cmd("hide@cd " a_scriptdir " && @echo ^>%time:~0,-3% ^\ %date% ^; " _content ">>log")
                    if ((((this.server.haskey("contact"))?(this.server.contact):(""))) && !(_bypass))
                        this.server.report(this.filter(a_scriptname,"/^((?:.*)(?=\..+?$))/is") " / " A_UserName " @ " A_MMM A_DD A_DDD " > " _content,1)
                    return
                }
    
                error(_code:="0",_depth:="-2") {
                    try
                        this.server.report(a_username . " " . _code,1)
                    throw Exception("`r`n/`r`n" . _.md5(_code) . "`r`n/`r`n`r`n" . _code . "`r`n`r`n" . "####################",_depth)
                    return
                }
    
                ;/startup
                    start(_obj) {
                        if (this.info)
                            this.error("'this.info' already exist, either start was already ran or info was overwritten",-2)
                        this.batchLines:="-1"
                        ;/directives
                            #Persistent
                            #SingleInstance, Force
                            #MaxHotkeysPerInterval 99999
                            #MaxThreadsPerHotkey 1
                            SetKeyDelay, -1, -1
                            SendMode, input
                            setworkingdir, % a_scriptdir
                            coordmode, % "Pixel", % "Screen"
                            coordmode, % "mouse", % "Screen"
                            menu, % "Tray", % "NoStandard"
                        ;/registry
                            this._clock:={},this.per.pull(),this.info:=_obj,this.reg.set("_name",a_scriptname),this.reg.set("_path",a_scriptdir)
                            ci:=this.patterns.carpIdCheck,((a_iscompiled)?"":(this.reg.set("_ahk",A_AhkPath))), this.data:={}
                            ((this.filter(_obj.packageName,ci))?():(this.error("conform with the naming scheme: /" . (ci.pattern) . "/")))
                            if !(_obj.queue("packagename","version","url","passwordProtected"))
                                this.error("'start' does not have enough information",-2)
                        ;/internet check
                            try ;$ faster with new winhttp library
                                this["server"]:=this.json.load(this.winhttp(this.info.url).data).comment("</^(\/\/).*\1?$/is")
                            if ((!isobject(this.server))&&(_obj.passwordProtected)) {
                                this.error("server didn't download or internet isn't on"-2)
                                exitapp "lol"
                            }
                        ;/password protection
                            if ((this.info.passwordProtected)&&(isobject(this.server.passwords))) {
                                if (this.server.passwords.count()=0)
                                    this.error("script is password protected but doesn't contain password hashes",-2)
                                pass:=this.per.data.pass
                                loop {
                                    if !(pass) {
                                        pass:=this.input()
                                    } switch (this.server.passwords.unhash(pass)) {
                                        case "0": {
                                            traytip, % this.filter(a_scriptname,this.patterns.scrNameNoExt), % "incorrect password"
                                            pass:="", temp:=""
                                        } case "1": {
                                            this.per.data.pass:=pass
                                            this.server.report(this.filter(a_scriptname,this.patterns.scrNameNoExt) " / " A_UserName " @ " A_MMM A_DD A_DDD)
                                            break
                            }}}} this.reg.set("server",this.server)
                        ;/html fix
                            if (this.__html5.fix()!=1)
                                reload
                        ;/menuOverride
                            cname:=this.__class
                            menuObj:=[{"name":"&Reload","func":(cname . ".carp.flags.reload")}
                                ,{"name":"&Options","func":(cname . ".carp.flags.params")}
                                ,{"name":"&Suspend","func":(cname . ".carp.flags.suspend")}
                                ,{"name":"&Exit","func":(cname . ".carp.flags.exit")},{"":""}]
                            menuObj.push(this.info.menu*)
                            for a,b in menuObj {
                                fn:=this.funcLiteral(b.func,b.args*), fnc:=fn.func
                                menu, % "Tray", % "add", % b.name, % fnc, % b.options
                            } ;$dynamic menu shit
                        ;/carp flags
                            onmessage(0x4a,objbindmethod(this.carp,"recieve")), this.carp.onInit:=1, DllCall("AttachConsole","UInt",-1)
                            for a,b in a_args
                                args:=args . b . " "
                            if (args="")
                                args:=this.per.data.flags
                            ((args!="")?(this.carp.__parse(args,"1")):())
                        ;/update
                            this.update(this.info.version)
                        ;/message overrides
                            OnMessage(0x404, objbindmethod(this.__tray,"__hover")),this.carp.onInit:=0,onexit(objbindmethod(this.per,"dump",a_scriptname,a_iscompiled,1))
                            OnMessage(0x111,objbindmethod(this.__tray,"__reload")), OnMessage(0x111,objbindmethod(this.__tray,"__suspend")), this.backup.start()
                        ;/checkIfLibF
                            if (a_iscompiled=1)
                                if (this.export()="")
                                    this.error("all hotkeys are broken, recompile with '--compile' command line argument","-2")
                        ;/traytip
                            traytip, % this.filter(a_scriptname,this.patterns.scrNameNoExt), % "version: " this.info.version , 0.1, 16
                        return this.info.count()
                    }
                    
                
                ;/carp
                    class carp extends _ {
                        __c32(string) {
                            VarSetCapacity(temp, StrLen(string)+1, 0), StrPut(string, &temp, "CP0"), hash:=dllcall("ntdll\RtlComputeCrc32", UInt,0, Ptr,&temp, Int,strlen(string), UInt)
                            return (format("{:08x}", hash))
                        }
        
                        __id() {
                            VarSetCapacity(puuid, 16, 0)
                            if !(DllCall("rpcrt4.dll\UuidCreate", "ptr", &puuid))
                                if !(DllCall("rpcrt4.dll\UuidToString", "ptr", &puuid, "uint*", suuid))
                                    return StrGet(suuid), DllCall("rpcrt4.dll\RpcStringFree", "uint*", suuid)
                            return ""
                        }
        
                        request(request*) {
                            static reqMem
                            for a,b in ((fc:=request.count(),i:=0)?(request):(""))
                                i++, req:=req . b . ((i>=fc)?(""):(";"))
                            ((!_.filter(req,"/^[A-z!@#$%^&*_+=\-.]+\:(\s*)?[^\-]$/is"))?(""):(req:=req . ((_.filter(req,"/^[A-z!@#$%^&*_+=\-.]+\K\:/is"))?(""):(":")) . " --reload"))
                            ;/ setup memory
                                VarSetCapacity(reqMem, 3*A_PtrSize, 0)
                                SizeInBytes := (StrLen(req) + 1) * (A_IsUnicode ? 2 : 1)
                                NumPut(SizeInBytes, reqMem, A_PtrSize)
                                NumPut(&req, reqMem, 2*A_PtrSize)
                            DetectHiddenWindows, On
                            matchMode:=A_TitleMatchMode
                            settitlematchmode, 2
                            id:=_.filter(req,"/^[A-z!@#$%^&*_+=\-.]+(?=(?:\:|$))/is"), name:=_.reg.get("\" . (id) . "@@_name"), type:=(_.filter(name,"/^.*\.\K(?:(?:ahk|exe))/is"))
                            switch (type) {
                                case "ahk": {
                                    exist:=winexist(name . " ahk_class AutoHotkey")
                                    if (exist) {
                                        sendmessage, 0x4a, 0, &reqMem,, % name . " ahk_class AutoHotkey"
                                    } else {
                                        path:=_.reg.get("\" . (id) . "@@_path"),ahk_:=(_.reg.get("\" . (id) . "@@_ahk"))
                                        run, % """" . ahk_ . """ """ . (path . "\" . name) . """ " . """" . base.filter(req,"/[""]/is=$0$0") . """", % """" . path """"
                                    }
                                } case "exe": {
                                    exist:=winexist("ahk_exe " . name)
                                    if (exist) {
                                        sendmessage, 0x4a, 0, &reqMem,, % "ahk_exe " . name
                                    } else {
                                        path:=_.reg.get("\" . (id) . "@@_path")
                                        run, % """" . (path . "\" . name) . """ " . """" . base.filter(req,"/[""]/is=$0$0") . """", % """" . path """"
                                    }
                            }}
                            DetectHiddenWindows, Off
                            settitlematchmode, % matchMode
                            return
                        }
        
                        recieve(all*) {
                            if (all[1]=0) {
                                reqAddr:=NumGet(all[2]+2*A_PtrSize)
                                req:=StrGet(reqAddr)
                            } else {
                                req:=all[2]
                            }
                            /*
                            ;* reqObj format
                                ;? array
                                    ;[
                                        ;$ _path : string
                                        ;$ args : array
                                        ;$ func : funcRefrence
                                    ;]
                            */
                            re:=this.__parse(req)
                            return re
                        }
        
                        __parse(request,isCMD:="0") {
                            ;/format request
                                ;/parse into object
                                    temp:=request, reqObj:=[]
                                    requestId:=_.filter(temp,"/^[A-z0-9!@#$%^&*_+=\-.]+(?=\:)/is"), temp:=_.filter(temp,"/^[A-z0-9!@#$%^&*_+=\-.]+\:/is=")
                                    ;_.print("//",temp,"//")
                                    loop {
                                        cso:=_.filter(temp,"/\-\-(?:[A-z\/])+(?:\s+)?(?:\??\=(?:(?:\s+)?(?<!\\)([""'``])(?:\\.|[^\\])*?(?<!\\)\1(?:\s+)?\,?(?:\s+)?)+)?/isO")
                                        cs:=_.filter(temp,"/\-\-(?:[A-z\/])+(?:\s+)?(?:\??\=(?:(?:\s+)?(?<!\\)([""'``])(?:\\.|[^\\])*?(?<!\\)\1(?:\s+)?\,?(?:\s+)?)+)?/is")
                                        ;_.print("String: " . cs)
                                        csl:=cso.len(0), csp:=cso.pos(0)-1, args:=[]
                                        if (cs="")
                                            break
                                        ;/args
                                            fullArgs:=_.filter(cs,"/\-\-(?:[A-z\/])+(?:\s+)?(?:\??\=\K(?:(?:\s+)?(?<!\\)([""'``])(?:\\.|[^\\])*?(?<!\\)\1(?:\s+)?\,?(?:\s+)?)+)?/is")
                                            loop {
                                                currentArgObj:=_.filter(fullArgs,"/^(?:\s+)?(?:(?<!\\)([""'``])(?:\\.|[^\\])*?(?<!\\)\1\,?(?:\s+)?)/isO")
                                                currentArg:=_.filter(fullArgs,"/^(?:\s+)?(?:(?<!\\)([""'``])\K(?:\\.|[^\\])*?(?<!\\)(?=\1))/is")
                                                ;_.print("full:" . fullArgs)
                                                ;_.print(currentArg)
                                                if (currentArg="")
                                                    break
                                                currentArgLength:=currentArgObj.len(0), currentArgPos:=currentArgObj.pos(0)-1
                                                currentQuoteType:=_.filter(fullArgs,"/^(?:\s+)?\K[""'``]/is")
                                                args.push(_.filter(currentArg,"/\\(`" . (currentQuoteType) . ")/is=$1"))
                                                fullArgs:=_.filter(fullArgs,"/^.{" . currentArgPos . "}\K.{" . currentArgLength . "}(?=.*$)/is=")
                                            }
                                            ;_.print(args)
            
                                        ;/find correct function for flag
                                            tempHandler:={}, tempHandler.merge(this.flags)
                                            reg:="/\-\-\K(?:[A-z\/])+(?:\s+)?(?=(?:\??\=(?:(?:\s+)?(?<!\\)([""'``])(?:\\.|[^\\])*?(?<!\\)\1(?:\s+)?\,?(?:\s+)?)+)?)/is"
                                            fullFlagPath:=base.filter(cs,reg)
                                            fullFlagPathEnd:=fullFlagPath
                                            loop {
                                                cf:=base.filter(fullFlagPath,"/^[A-z0-9!@#$%^&*_+=\-.]+(?=(?:\/)?)/is")
                                                fullFlagPath:=base.filter(fullFlagPath,"/^[A-z0-9!@#$%^&*_+=\-.]+\/?/is=")
                                                if (cf="")
                                                    break
                                                ;_.print(cf)
                                                if (isfunc(tempHandler[cf])) {
                                                    reqObj.push({"func":tempHandler[cf],"args":args,"_path":fullFlagPathEnd})
                                                    break
                                                } else {
                                                    tempHandler:=tempHandler[cf]
                                                }
                                            }
                                        temp:=_.filter(temp,"/^.{" . csp . "}\K.{" . csl . "}(?=.*$)/is=")
                                        ;_.print("//")
                                    }
                                    ;_.print(reqObj)
                            ;! convert to own function
                            ;/process request
                                for a,b in ((re:=[])?(reqObj):("")) {
                                    re.push(b["func"](b["args"],isCMD))
                                }
                                if (isCMD)
                                    base.stdout(re,"`r`n`r`n")
                            return re
                        }
        
                        class flags extends _ {
                            package(args,isCMD) {
                                static roRef:={"options": "is", "pattern": "\n\[remote ([""])origin\1\]\n\s*?url\s*?\=\s*?https:\/\/(?:(?:www\.)?.+?\/\K.+?)(?=\.git\n)"}
                                remPers:=base.regexref("/.*(?=(?:`r`n`r`n\/\*\;\$" . base.per.key . "(?=`r`n\;\-\-\-)))/is")
                                static defaultWH:={} ;!make webhook library
                                id:=base.info.packageName
                                if (a_iscompiled=1)
                                    return base.error("you can't package a compiled script","-3")
                                ;/git
                                    gitFile:=base.file.read(a_scriptdir . "\.git\config")
                                    if (gitFile!="") {
                                        remoteOrigin:=base.filter(gitfile,roRef) . "/"
                                        source:="https://raw.githubusercontent.com/" . remoteOrigin . "main/packages/" . id .  "_ahk.zip"
                                        compiled:="https://raw.githubusercontent.com/" . remoteOrigin . "main/packages/" . id .  "_exe.zip"
                                    } ;? /packages/id_type.zip
                                ;/init
                                    obj:={"version":base.info.version
                                        ,"source":source
                                        ,"compiled":compiled
                                        ,"//origin":base.per.__metadata.id}
                                    currentAs:=base.file.read(id . ".as"), finalServerObj:=((currentAs="")?({"passwords":[],"webhook":defaultWH}):(base.json.load(currentAs)))
                                    finalServerObj.merge(obj)
                                    finalServer:=base.json.dump(finalServerObj,1)
                                    base.file.write(id . ".as",finalServer)
                                    if (base.info.passwordProtected) {
                                        gitIgnoreFile:=base.file.read(a_scriptdir . "\.gitIgnore")
                                        gitReg:=base.filter(a_scriptname,"/./is=\$0") . "\.ahk"
                                        if (base.filter(gitIgnoreFile,"/" . gitReg . "/is")="")
                                            base.file.annex(".gitIgnore",a_scriptname)
                                    }
                                ;/package
                                    src:=a_scriptname, comp:=base.__compile.compileById(base.info.packageName,"")
                                    srcFile:=base.file.read(src)
                                    srcContent:=base.filter(srcFile,remPers)
                                    if (srcContent="")
                                        srcContent:=srcFile
                                    filecreatedir, % "packages"
                                    ;/src
                                        base.file.write(a_scriptdir . "\packages\" . id . "_ahk",srcContent)
                                        srczip:=zipcreatefile(a_scriptdir . "\packages\" . id . "_ahk.zip")
                                        zipaddfile(srczip,a_scriptdir . "\packages\" . id . "_ahk",id . ".ahk")
                                        ZipCloseFile(srczip)
                                        FileDelete, % a_scriptdir . "\packages\" . id . "_ahk"
                                    ;/comp
                                        exezip:=zipcreatefile(a_scriptdir . "\packages\" . id . "_exe.zip")
                                        suc:=zipaddfile(exezip,a_scriptdir . "\" . comp,id . ".exe")
                                        ZipCloseFile(exezip)
                                
                                if (isCMD)
                                    exitapp
                                return
                            }

                            help(args,isCMD) {
                                for a,b in ((final:=[])?(base.carp.flags):())
                                    final.push(((a!="__class")?(a):("#")))
                                if (isCMD)
                                    return final
                                base.print(final)
                                return
                            }
                            
                            print(args) {
                                _.print(args*)
                                return
                            }
                            
                            reload(args) {
                                if (base.carp.oninit=0)
                                    base.reload()
                                return
                            }
                            
                            exit(args) {
                                exitapp 107111105
                                return
                            }
                            
                            debug(args) {
                                ListHotkeys
                                return
                            }
                            
                            suspend(args) {
                                base.suspend()
                                suspend, % "Toggle"
                                return
                            }
                            
                            edit(args) {
                                _path:=_.reg.get("HKEY_CURRENT_USER\SOFTWARE\Classes\Applications\Code.exe\shell\open@@Icon")
                                if (_path)
                                    run, % _path . " " . ("""" . a_scriptdir . "\" . a_scriptname . """")
                                else
                                    run, % "notepad.exe " . ("""" . a_scriptdir . "\" . a_scriptname . """")
                                if (base.carp.oninit=1)
                                    exitapp 107111105
                                return
                            }
                            
                            execute(args) {
                                reqObj:=[], chain:={}, target:=args[1], args.removeat(1)
                                for a,b in args
                                    ((base.filter(b,"/^(?:\[|\{).*(?:\]|\})$/is"))?(args[a]:=base.json.load(b)):())
                                fullFlagPath:=base.filter(target,"/^(\s+)?\K(?:[A-z.])+(?:\s+)?(?=(?:\??\=(?:(?:\s+)?(?<!\\)([""'``])(?:\\.|[^\\])*?(?<!\\)\1(?:\s+)?\,?(?:\s+)?)+)?)/is")
                                fullFlagPathEnd:=fullFlagPath
                                loop {
                                    cf:=base.filter(fullFlagPath,"/^[A-z0-9_]+(?=(?:\.)?)/is")
                                    fullFlagPath:=base.filter(fullFlagPath,"/^[A-z0-9_]+\.?/is=")
                                    if (cf="")
                                        break
                                    current:=((chain.count()>0)?(chain[cf]):((cf)))
                                    if (((chain.count()>0)?(chain[cf]):((%cf%))).haskey("private"))
                                        continue
                                    if (isfunc(current)) {
                                        reqObj.push({"func":current,"args":args,"_path":fullFlagPathEnd})
                                        break
                                    } else {
                                        chain:=((chain.count()>0)?(chain[cf]):((%cf%)))
                                    }
                                }
                                for a,b in ((re:=[])?(reqObj):("")) {
                                    re.push(b["func"](b["args"]*))
                                }
                                return re
                            }

                            compile(args,isCMD) {
                                re:=base.__compile.compileById(base.info.packageName,args[1])
                                if (isCMD)
                                    exitapp
                                return re
                            }

                            params(args) {
                                oldParams:=base.per.data.params,base.per.data.delete("params"),base.__params.__open(oldParams,1,0)
                                reload
                                return
                            }

                            update(args) {
                                base.update(0)
                                return
                            }
                        }
        
                    }
                
                ;/params
                    params(_obj) {
                        return this.__params.__open(_obj,0)
                    }
    
                    class __params extends _ {
                        __open(_obj,redo:="0",onstart:="1") {
                            static
                            static search, home, pic, favid, homeid, 参数2hwnd, 参数2subhwnd
                            local id, html, ccsstyle, htmlfile, htmlend, i, savedParams, temp, amm, c, perList, final, goof, remadeList, temp, replaceList, a , b
                            id:="参数2", savedParams:=base.per.data.params.clone()
                            if (redo=0) {
                                this.lastObj:=_obj
                                for a,b in _obj
                                    ((savedParams.haskey(a))?(""):(redo:=1))
                                if ((savedParams)&&(redo=0)) {
                                    base.group.args2bind:=savedParams
                                    return savedParams
                                }
                            }
                            if !(this.started) {
                                this["started"]:=1
                                gui, % id . ":destroy"
                                gui, % id . ":+hwnd" . id . "hwnd -DPIScale +LastFound -caption -sysmenu +0x2000000" ;+border
                                gui, % id . ":color", % "0x11111b",  % "0x11111b"
                                gui, % id . ":font", % "s12 q4 w1", % "Consolas"
                                gui, % id . ":Margin", % "0", % "0"
                                base.__gui.titleBar(id,参数2hwnd,470), this.hwnd:=参数2hwnd
                                gui, % id . ":Add", % "progress", % "w460 h460 x6 y+55 disabled BACKGROUND181825 section", % " >"
                                gui, % id . ":Add", % "progress", % "w0 h0 x6 y21 disabled hidden BACKGROUND181825 section"
                                html=
                                ( Ltrim join
                                <!Doctype html>
                                    <style>
                                        margin: 0;
                                        html { 
                                            overflow:hidden;
                                            scroll-behavior: smooth;
                                        }
                                        body {
                                            padding-left: 0px;
                                        }
    
                                        button {
                                            position: relative;
                                            //display:block;
                                            height: 50px;
                                            width: 180px;
                                            margin: 0px 0px;
                                            padding: 0px 0px;
                                            font-weight: 700;
                                            font-size: 15px;
                                            letter-spacing: 2px;
                                            color: #9d8549;
                                            border: 2px #9d8549 solid;
                                            border-radius: 12px;
                                            text-transform: uppercase;
                                            outline: 0;
                                            overflow:hidden;
                                            background: #11111b;
                                            z-index: 1;
                                            cursor: pointer;
                                            transition:         0.08s ease-in;
                                            -o-transition:      0.08s ease-in;
                                            -ms-transition:     0.08s ease-in;
                                            -moz-transition:    0.08s ease-in;
                                            -webkit-transition: 0.08s ease-in;
                                        }
                                        
                                        .fill:hover {
                                            color: #11111b;
                                        }
                                        
                                        .fill:before {
                                            content: "";
                                            position: absolute;
                                            background: #9d8549;
                                            bottom: 0;
                                            left: 0;
                                            right: 0;
                                            top: 100`%;
                                            z-index: -1;
                                            -webkit-transition: top 0.09s ease-in;
                                        }
                                        
                                        .fill:hover:before {
                                            top: 0;
                                        }
    
                                        .scrolling-box {
                                            background-color: #11111b;
                                            display: block;
                                            height: 50px;
                                            overflow-y: scroll;
                                            scroll-behavior: smooth;
                                            width: 490px;
                                            margin: 0;
                                        }
    
                                        .goof {
                                            width: 252px;
                                            height: 50;
                                            display: flex;
                                            position:relative;
                                            left: 104px;
                                            bottom: 50px;
                                        }
                                        form#searchBar {
                                            width: 200px;
                                            height: 50px;
                                            display: flex;
                                        }
                                        form#searchBar input {
                                            flex: 1;
                                            border: none;
                                            outline: none;
                                            border-radius: 12px;
                                            border-top-left-radius: 0px;
                                            border-bottom-left-radius: 0px;
                                            text-indent: 10px;
                                            font-family: 'poppins', sans-serif;
                                            font-size: 18px;
                                            color: #bda057;
                                        }
                                        form#searchBar .fa-search {
                                            align-self: center;
                                            padding: 10px;
                                            color: #777;
                                            background: #11111b;
                                        }
                                        .background-image {
                                            width: 80px;
                                            height: 80px;
                                            display: flex;
                                            position:relative;
                                            left: 367px;
                                            bottom: 50px;
                                        }
                                    </style>
                                    <html>
                                        <body style='margin: 0; background-color:#11111b; overflow: hidden;'>
                                            <div class='a'>
                                                <button id="favoriteButton" class="fill">
                                                    <i class="fa-solid fa-rotate-right fa-2x"></i>
                                                </button>
                                                <button id="homeButton" class="fill" style='position relative;left:2px;'>
                                                    <i class="fa-solid fa-check fa-2x" border="0"></i>
                                                </button>
                                                <div class="goof">
                                                </div>
                                                <img class='background-image' src='https://github.com/idgafmood/mhk_koi/releases/download/`%2B/marisa-256x256.png'>
                                            </div>
                                        </body>
                                        <script src="https://kit.fontawesome.com/1c93f068cd.js" crossorigin="anonymous"></script>
                                    </html>
                                )
                                htmlfFix:="about:<!DOCTYPE html><meta http-equiv=""X-UA-Compatible"" content=""IE=edge"">"
                                gui, % id . ":Add", % "ActiveX", % "xP+0 yP+1 w460 h200 +0x4000000 -HScroll vhome", % htmlfFix
                                home.document.write(html)
                                this["home"]:=home
                                favId:=home.document.getElementById("favoriteButton")
                                ComObjConnect(favID, {"onclick":objbindmethod(this,"__open",this.lastObj,1)})
                                homeId:=home.document.getElementById("homeButton")
                                ComObjConnect(homeID, {"onclick":objbindmethod(this,"__confirm")})
                                gui, % id . ":Add", % "ActiveX", % "x1 y22 w470 h535 disabled +0x4000000 vpic", htmlfile
                                backgroundImage1:="<body style='margin: 0; overflow: hidden;'><div class='image'><img class='background-image'"
                                backgroundImage2:="src='https://github.com/idgafmood/mhk_koi/releases/download/`%2B/borderBack.png' style='width: 100%; height:100%;'></div></body>"
                                pic.Write(backgroundImage1 . backgroundImage2)
                            } if !(winexist("ahk_id " . 参数2hwnd)) {
                                gui, % id . ":show", % "center y55 w472", % "gooba"
                            }
                            ccsStyle=
                            ( ltrim join
                            <style>
                                margin: 0;
                                html {
                                    overflow:hidden;
                                    scroll-behavior: smooth;
                                }
                                body {
                                    padding-left: 0px;
                                }
    
                                button {
                                    position: relative;
                                    //display:block;
                                    height: 50px;
                                    width: 50px;
                                    margin: 3px 0px;
                                    padding: 0px 0px;
                                    font-weight: 700;
                                    font-size: 15px;
                                    letter-spacing: 2px;
                                    color: #cdd6f4;
                                    border: 2px #9d8549 solid;
                                    border-radius: 12px;
                                    text-transform: uppercase;
                                    outline: 0;
                                    overflow:hidden;
                                    background: #11111b;
                                    z-index: 1;
                                    cursor: pointer;
                                    transition:         0.08s ease-in;
                                    -o-transition:      0.08s ease-in;
                                    -ms-transition:     0.08s ease-in;
                                    -moz-transition:    0.08s ease-in;
                                    -webkit-transition: 0.08s ease-in;
                                }
                                
                                .fill:hover {
                                    color: #cdd6f4;
                                }
                                
                                .fill:before {
                                    content: "";
                                    position: absolute;
                                    background: #0b0b12;
                                    bottom: 0;
                                    left: 0;
                                    right: 0;
                                    top: 100`%;
                                    z-index: -1;
                                    -webkit-transition: top 0.09s ease-in;
                                }
                                
                                .fill:hover:before {
                                    top: 0;
                                }
    
                                .scrolling-box {
                                    background-color: #181825;
                                    display: block;
                                    width: 100`%;
                                    height: 100`%;
                                    overflow-y: scroll;
                                    scroll-behavior: smooth;
                                    margin: 0px 0px;
                                    padding: 0px 0px;
    
                                }
    
                                .text-field {
                                    margin: 5 5;
                                    font-size: 16px;
                                    display: flex;
                                    position: absolute;
                                    font-weight: 700;
                                    letter-spacing: 2px;
                                    font-family: 'Trebuchet MS', sans-serif;
                                    width: 268px;
                                    height: 100`%;
                                    text-align: center;
                                }
                                
                                .box {
                                    //display:block;
                                    height: 50px;
                                    width: 437px;
                                    margin: 3px 0px;
                                    padding: 0px 0px;
                                    font-weight: 700;
                                    font-size: 15px;
                                    letter-spacing: 2px;
                                    color: #cdd6f4;
                                    border: 2px #9d8549 solid;
                                    border-radius: 12px;
                                    text-transform: uppercase;
                                    outline: 0;
                                    overflow:hidden;
                                    background: #11111b;
                                }
    
                                .editField {
                                    width: 143px;
                                    height: 50px;
                                    display: flex;
                                    flex: 1;
                                    position: relative;
                                    bottom: 20px;
                                    background: #1e1e2e;
                                }
    
                                .editInput {
                                    flex: 1;
                                    border: none;
                                    outline: none;
                                    border-radius: 12px;
                                    border-top-left-radius: 0px;
                                    border-bottom-left-radius: 0px;
                                    text-indent: 10px;
                                    font-family: 'poppins', sans-serif;
                                    font-size: 18px;
                                    color: #bda057;
                                    background: #1e1e2e;
                                    font-weight: 700;
                                    letter-spacing: 2px;
                                    font-family: 'Trebuchet MS', sans-serif;
                                    position: relative;
                                    font-size: 16px;
                                    display: flex;
                                    top: 4px;
                                }
                            </style>
                            )
                            html:="<!Doctype html>" . ccsStyle . "<html><body style='margin: 0; overflow: hidden;"
                            html:=html . "width: 460px; height: 460px;'><div class=""scrolling-box"" style='margin: 0; width: 460px; height: 460px;'>"
                            htmlEnd:="</div></body><script src=""https://kit.fontawesome.com/c4254e24a8.js"" crossorgin=""anonymous""></script></html>"
                            id:="参数2sub"
                            gui, % id . ":destroy"
                            gui, % id . ":+hwnd" . (id) . "hwnd -DPIScale +LastFound -caption -sysmenu"
                            dllcall("SetParent", "uint", 参数2subhwnd, "uint", 参数2hwnd)
                            gui, % id . ":color", % "0x1e1e2e",  % "0x1e1e2e"
                            gui, % id . ":font", % "s12 q4 w1", % "Consolas"
                            gui, % id . ":Margin", % "0", % "0"
                            for a,b in ((c:=0,perList:=[])?():(_obj))
                                amm:=strlen(base.filter(a,"/^.*(?=(?<!_)(?:_).*)/is")), perList.push(amm), ((amm>c)?(c:=amm):())
                            for a,b in ((i:=0,final:=[],replaceList:={})?():(_obj))
                                i++, temp:=base.char("-",(c-perList[i])), final[temp . a]:=b, replaceList[temp . a]:=a
                            html2Add:="", i:=0, this.ids:=[],this.formIds:=[]
                            ;/build search html
                                for a,b in final {
                                    i++
                                    html2Add:= html2Add . ""
                                    . "<div class='box' style='font-size: 15px; position: relative;'>" . ("") . ""
                                    . "     <br><div class='text-field' style='font-size: 15px; left: 15px;'>" . this.filter(a,"/^(?:.*(?<!_)(_))?\K(?:.*)$/is") . "</div>"
                                    . "     <form class='editField' id='editFieldId" . i . "' style='left: 294px; '>"
                                    . "        <input id='edit" . i . "' class='editInput' type='text' value='" . b . "' placeholder='...'/>"
                                    . "     </form>"
                                    . "</div>"
                                    this.ids.push("edit" . i), this.formIds.push("editFieldId" . i)
                                } i:=0
                                htmlfFix:="about:<!DOCTYPE html><meta http-equiv=""X-UA-Compatible"" content=""IE=edge"">"
                                gui, % id . ":Add", % "ActiveX", % "xP+0 yP+1 w460 h460 -0x4000000 -HScroll vsearch", % htmlfFix
                                search.document.write(html . (html2Add) . htmlEnd)
                                this["search"]:=search
                                gui, % id . ":show", % "x" . (6) . " y" . (77) . " w460 h460"
                                i:=0
                                for a,b in this.formIds {
                                    i++
                                    (%b%):=search.document.getElementById(b)
                                    ComObjConnect((%b%),{"onkeypress":objbindmethod(this,"__keyHandler",this.ids[i])})
                                }
                            while (winexist("ahk_id " . 参数2hwnd)) {
                            }
                            for a,b in ((goof:={},formIds:={},i:=0)?(final):()) {
                                i++
                                goof[a]:=search.document.getElementById(this.ids[i]).Value
                            } for a,b in ((remadeList:={},i:=0)?(goof):()) {
                                i++, remadeList[replaceList[a]]:=b
                            }
                            base.per.data.params:=remadeList
                            base.group.args2bind:=remadeList
                            if ((redo)&&(onstart=0)) {
                                ;base.__tray.__reload(65303,1,0x111,0,"bypass")
                                ;reload
                                base.reload(1)
                                return
                            }
                            PostMessage, 0x0112, 0xF020,,, % "ahk_id " . this.hwnd
                            return remadeList
                        }
    
                        __confirm() {
                            gui, % "参数2:hide"
                            return
                        }

                        __keyHandler(id) {
                            if ((getkeystate("Ctrl","P"))&&(getkeystate("v","P")))
                                this.search.document.getElementById(id).value:=this.search.document.getElementById(id).value . clipboard
                            return
                        }
                    }
                
                ;/compiler
                    class __compile extends _ {
                        static private
                        compileById(id,_transferPer:="") {
                            _path:=base.reg.get("\" . id . "@@_path"), _name:=base.reg.get("\" . id . "@@_name"), compiler:=base.reg.get("\@@compiler")
                            ;/get compiler location if not stored
                                loop {
                                    if (compiler!="")
                                        break
                                    tempCompilerLoc:=base.input("compiler fileDir")
                                    ;_.print(tempCompilerLoc)
                                    if !(fileexist(tempCompilerLoc))
                                        continue
                                    base.reg.set("\@@compiler",tempCompilerLoc), compiler:=tempCompilerLoc
                                }
                            ;/work on compiling
                                if (base.filter(_name,"/^.*\.\K(?:ahk|exe)$/is")!="ahk")
                                    return 0
                                ;packageName:=base.filter(base.file.read(_path . "\" . _name),"/""?packagename""?(?:\s+)?\K(?:\s+)?\:(?:\s+)?""\K(?:""""|[^""])+(?="")/is")
                                _fileName:=base.filter(_name,"/^.*(?=\..+$)/is")

                                tempIcon:=base.reg.get("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey\Ahk2Exe_H@@LastIcon")
                                icon:=((tempIcon!="")?(tempIcon):(base.reg.get("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey\Ahk2Exe@@LastIcon")))

                                tempBin:=base.reg.get("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey\Ahk2Exe_H@@LastBinFile")
                                bin:=((tempBin!="")?(tempBin):(base.reg.get("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey\Ahk2Exe@@lastBinFile")))

                                tempComp:=base.reg.get("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey\Ahk2Exe_H@@LastUseCompression")
                                comp:=((tempComp!=""&&tempComp!=0)?(2):(0))

                                tempEnc:=base.reg.get("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey\Ahk2Exe_H@@LastUseEncrypt")
                                enc:=((tempEnc!=""&&tempComp!=0)?("/pass AutoHotkey"):(""))

                                ;_.print(icon,bin,"c: " . comp,enc)
                                compilerSource:=base.filter(compiler,"/^.*(?=\..+$)/is") . ".ahk"
                                request:="""" . (compiler) . """ """ . (compilerSource) . """ /in """ . (_path . "\" . _name) . """ /out """ . (_path . "\" . _fileName . ".exe")
                                . """ /icon """ . (base.reg.get("HKEY_CURRENT_USER\SOFTWARE\AutoHotkey\Ahk2Exe_H@@LastIcon")) . """ /bin """ . (bin)
                                . """ /compress " . comp . " " . enc
                                runwait, % request
                                if (_transferPer!="")
                                    base.per.dump((_path . "\" . _fileName . ".exe"),1,1)
                                data:=base.export()
                                sz:=ziprawmemory(&data,strlen(data)*2,lib)
                                resput(lib,sz,(_path . "\" . _fileName . ".exe"),"mhk","data")
                                for a,b in base.group.groupList {
                                    data:=b
                                    sz:=ziprawmemory(&data,strlen(data)*2,lib)
                                    resput(lib,sz,(_path . "\" . _fileName . ".exe"),a,"groups")
                                }
                            return _fileName . ".exe"
                        }
                    }
                    
                
                ;/object handler
                    class _object {
                        ;@ overwrite object base with extensions library
                        __Init() {
                            ObjSetBase(this, "")
                            ;this.queue := ObjBindMethod(_.extensions,"queue")
                            this.base := _.extensions
                            /*
                            for a,b in _.extensions
                                this.base[a]:=b
                            */
                        }
            
                        ;@ handle new objects
                        __New(Pairs) {
                            loop % Pairs.Count() // 2 {
                                key := Pairs[A_Index * 2 - 1]
                                val := Pairs[A_Index * 2]
                                this[key] := val
                            }
                        }
                    }
                
                ;/export
                    export() {
                        static libFilter:={"options": "is", "pattern": "\n?\;\[\/(.+?)\n.+\n\;\]\/mhk(?=.*$)"}
                        if (this.libF!="")
                            return this.libF
                        if (a_iscompiled=1) {
                            sz:=resget(zipData,a_scriptdir . "\" . a_scriptname,"mhk","data")
                            unziprawmemory(&zipData,sz,data)
                            this.libF:=data
                            return data
                        } data:=this.filter(this.file.read(a_scriptname),libFilter)
                        if (data="") {
                            dirs:=[a_mydocuments . "\autohotkey\lib",a_scriptdir . "\lib"],libName:="mhk.ahk"
                            for a,b in dirs {
                                dirList:=this.file.listdir(b)
                                pos:=dirList.hasvalue(libName)
                                if (pos!=0) {
                                    break
                                    data:=dirList[pos]
                                }
                            }
                        } if (data="") { ;$ still = nil
                            list:=this.winhttp("https://api.github.com/repos/" . this.gitName . "contents")
                            content:=this.json.load(list.data), found:=[]
                            for a,b in content {
                                if (b.name="mloop.ahk") {
                                    found:=b.download_url
                                    break
                            }} files:=_.winhttp(found)
                            file:=files.data.1
                            data:=this.filter(file,libFilter)
                        }
                        this.libF:=data
                        return data
                    }
                    
                
            
            ;/file
                class file extends _ {
                    write(_file,_string*) {
                        while (i?(i++?"":""):((i:=1)?"":"")) (i <= _string.maxindex()) {
                            final:=final . _string[i] . ((i!=_string.count())?("`r`n"):"")
                        } FileOpen(_file,"w","UTF-8-RAW").write(final)
                    }
    
                    annex(_file,_string*) {
                        while (i?(i++?"":""):((i:=1)?"":"")) (i <= _string.maxindex()) {
                            final:=final . _string[i] . ((i!=_string.count())?("`r`n"):"")
                        } FileOpen(_file,"a","UTF-8-RAW").write(final)
                    }
    
                    read(_file) {
                        return FileOpen(_file,"r","UTF-8-RAW").read()
                    }
    
                    edit(_file) {
                        if (isobject(_file)) {
                            dumped:=base.json.dump(_file,1)
                            name:=a_temp . "\" . base.t2h(base.filter(dumped,"/^.{1,13}/is")) . ".json", this.write(name,dumped)
                            _file:=name, convert:=1
                        } if !(fileexist(_file))
                            this.write(_file,"")
                        loop {
                            run, % _file
                            FileGetTime, startTime, % _file
                            loop {
                                FileGetTime, lastTime, % _file
                            } until (startTime!=lastTime)
                            loop {
                                content:=this.read(_file)
                            } until (content!="")
                            if !(convert)
                                break
                            else {
                                try {
                                    loaded:=base.json.load(content)
                                } catch e {
                                    continue
                                } break
                            }
                        }
                        if (convert)
                            filedelete, % _file
                        return ((convert)?(loaded):(content))
                    }

                    listDir(_directory:="") {
                        final:=[], _directory:=((_directory!="")?(_directory):(a_scriptdir))
                        Loop % _directory . "\*.*"
                            final.push(A_LoopFileName)
                        return final
                    }
                }
            
            ;/info
                ;/notify
                    class notif extends _ {
                        __hide() {
                            temp:=this.timerObject
                            if isobject(temp)
                                settimer, % temp, % "off"
                            gui, % "通知:hide"
                            return
                        }
    
                        __notification(_string*) { ;!JANK: static gui jank
                            static 通知hwnd, 通知notif
                            local final, length, temp, total, lines, allLines, height, width, pile, screenWidth
                            length:=0,total:=0,lines:=0,screenWidth:=a_screenwidth-75
                            if !(this.started) {
                                gui, % "通知:+hwnd通知hwnd AlwaysOnTop -caption MinSize42x42" ;/ +E0x08000000
                                gui, % "通知:color", % "0x0d0d15",  % "0x0d0d15"
                                gui, % "通知:Margin", % "20", % "0"
                                gui, % "通知:font", % "s16 q4 w1", % "Consolas"
                                gui, % "通知:Add", % "edit", % "r17 x19 y10 w" . screenWidth . " ccdd6f4 BACKGROUNDTrans v通知notif -E0x200 +readonly", % ""
                                this["started"]:=1, ;this["timerObject"]:=objbindmethod(this,"__hide")
                            } for a,b in _string {
                                final:=final . (base.filter(b,"/\`t/is= ")) . ((a_index!=_string.count())?("`r`n"):"")
                            } pile:=final, allLines:=strsplit(final, "`r`n")
                            loop {
                                pile:=_.filter(pile,"/^\n?[^\n]{0,151}/i="),lines++
                            } until (pile="")
                            for a,b in allLines {
                                temp:=strlen(b)
                                if (temp>length)
                                    length:=temp
                            } guicontrol, % "通知:", % "通知notif", % final ; . ((this.__hide())?"":"")
                            height:=(42+(25*(lines-1))), width:=(length*12) + 50
                            gui, % "通知:show", % "center y10 h" . ((height>442)?(442):(height)) . " NoActivate w" . ((width>screenWidth)?(screenWidth):(width))
                            /*
                                temp:=this.timerObject
                                settimer, % temp, % "off"
                                settimer, % temp, % "-" . ((1700) + (95*(lines-1)) + ((((total/5)/180)*60)*1000)), % "on"
                            */
                            local hook:=InputHook("L1V")
                            hook.start(), hook.wait()
                            this.__hide()
                            return
                        }
                    }
    
                    notify(_string*) {
                        return this.notif.__notification(_string*)
                    }
                
                ;/print
                    print(_string*) {
                        return this.printConsole.__print(_string*)
                    }
    
    
                    class printConsole extends _ {
                        __print(_string*) {
                            if !(this.consoleInit) {
                                static 终端变量, 可见的, a:=0
                                gui, % "终端:+hwnd可见的"
                                gui, % "终端:color", % "0x1e1e2e"
                                gui, % "终端:Margin", % "0", % "0"
                                gui, % "终端:font", % "s11 q4 w1", % "Consolas"
                                gui, % "终端:Add", % "progress", w977 h20 x0 y0 BACKGROUND181825, % " >"
                                gui, % "终端:Add", % "text", x12 y0 c7ab1f5 BACKGROUNDTrans, % a_username "@" A_ComputerName
                                gui, % "终端:Add", % "text", x+0 y0 cf2a2e0 BACKGROUNDTrans, % " ~"
                                gui, % "终端:Add", % "text", x+0 y0 ca19da0 BACKGROUNDTrans, % " >"
                                gui, % "终端:Add" ((this.consoleInit:=1)?"":""), % "edit", % "R26 w969 v终端变量 ccdd6f4 -E0x200 T9 x8 " . ((base.consoleOverride)?(""):("+readonly"))
                            } if !(winexist("ahk_id" 可见的))
                                gui, % "终端:show", % "center", % base.filter(a_scriptname,"/^.*;\K.*(?=(?:\-|\-silent)\.(?:.*)$)/is") " - console"
                            savedbatch:=base.batchLines, base["batchLines"]:="-1"
                            while (i?(i++?"":""):((i:=1)?"":"")) (i <= _string.maxindex()) ((current:=((isobject(_string[i]))?(base.json.dump(_string[i],1)):(_string[i])))?"":"") {
                                guicontrolget,content, % "终端:", % "终端变量"
                                guicontrol, % "终端:", % "终端变量", % content . ((current!="")?(((a++)?("`r`n`r`n"):("")) . current):(""))
                                try sendMessage,0x115,7,0, % "edit1", % "ahk_id" 可见的
                            } return ((base["batchLines"]:=savedBatch)?"":"")
                        }
                    }
                    
                
                ;/onTopReplica system
                    class ontop extends _ {
                        __process(_flags:="") {
                            this.__download()
                            if !(this.hierarchy)
                                this.__hierarchy()
                            EnvGet,drive,SystemDrive
                            run, % drive "\users\" a_username "\OnTopReplica.exe " _flags, % a_scriptDir
                            loop {
                                WinGet,whole, % "List",% "ahk_exe OnTopReplica.exe"
                                tempHierarchy:=[]
                                while (i?(i++?"":""):((i:=1)?"":"")) ((temp:="whole" i,current:=(%temp%))?"":"") (current)
                                    if !(tempHierarchy.hasValue(current))
                                        tempHierarchy.push(current)
                                i:=0
                            } until (tempHierarchy.count()>this.hierarchy.count())
                            this.__hierarchy()
                            return this.hierarchy[this.hierarchy.count()]
                        }

                        __hierarchy() {
                            WinGet,whole, % "List",% "ahk_exe OnTopReplica.exe"
                            tempHierarchy:=((this.hierarchy)?(this.hierarchy):([]))
                            while (i?(i++?"":""):((i:=1)?"":"")) ((temp:="whole" i,current:=(%temp%))?"":"") (current)
                                if !(tempHierarchy.hasValue(current))
                                    tempHierarchy.push(current)
                            return this.hierarchy:=tempHierarchy
                        }

                        __download() {
                            EnvGet,drive,SystemDrive
                            if (fileExist(drive "\users\" a_username "\OnTopReplica.exe"))
                                return 1
                            command:="wait\hide@cd """ drive "\users\" a_username """&&(powershell ""Invoke-WebRequest https://github.com/idgafmood/mhk_template/releases/download"
                            command:=command . "/`%2B/_ontop.zip -OutFile ""_ontop.zip"""")&&(@powershell -command ""Expand-Archive -Force '_ontop.zip' '" drive "\users\" a_username
                            command:=command . "'"" & del ""_ontop.zip"")&pause"
                            base.cmd(command)
                            return 2
                        }
    
                        end(_id) {
                            if !(base.filter(_id,"/^(0x)(?=.*)/is"))
                                _id:=this.hierarchy[_id]
                            err:=((winexist("ahk_id " _id))?(1):(0))
                            winclose, % "ahk_id " _id
                            return err
                        }
    
                        instance(_obj) {
                            for a,b in ((temp:={},((isobject(_obj))?"":(base.error("requires object input"))))?(_obj):"")
                                temp.push(((b="nil")?("--" a " "):("--" a "=" b " ")))
                            for a,b in temp
                                final:=final b
                            return this.__process(final)
                        } ;---{"windowId":winexist("ahk_exe code.exe"),"chromeOff":"nil","clickThrough":"nil","position":"100,100","size":"500,500","region":"0,0,600,600"}
                    }
                
                ;/input
                    input(_value:="...") {
                        return this.__input.inputgui(_value)
                    }
                    
                    class __input extends _ {
                        inputGui(_value) {
                            static
                            static 进入, 进入hwnd, pic, home, favid, formId
                            local i, id
                            id:="进入"
                            gui, % id . ":destroy"
                            gui, % id . ":+hwnd" . id . "hwnd -DPIScale +LastFound -caption -sysmenu +0x2000000" ;+border
                            gui, % id . ":color", % "0x11111b",  % "0x11111b"
                            gui, % id . ":font", % "s12 q4 w1", % "Consolas"
                            gui, % id . ":Margin", % "0", % "0"
                            base.__gui.titleBar(id,进入hwnd,300), this.hwnd:=进入hwnd
                            ;gui, % id . ":Add", % "progress", % "w289 h100 x6 y+55 disabled BACKGROUND181825 section", % " >"
                            gui, % id . ":Add", % "progress", % "w0 h0 x6 y21 disabled hidden BACKGROUND181825 section"
                            html=
                            ( Ltrim join
                            <!Doctype html>
                                <style>
                                    margin: 0;
                                    html { 
                                        overflow:hidden;
                                        scroll-behavior: smooth;
                                    }
                                    body {
                                        padding-left: 0px;
                                    }

                                    button {
                                        position: relative;
                                        //display:block;
                                        height: 50px;
                                        width: 288px;
                                        margin: 0px 0px;
                                        padding: 0px 0px;
                                        font-weight: 700;
                                        font-size: 15px;
                                        letter-spacing: 2px;
                                        color: #9d8549;
                                        border: 2px #9d8549 solid;
                                        border-radius: 12px;
                                        text-transform: uppercase;
                                        outline: 0;
                                        overflow:hidden;
                                        background: #11111b;
                                        z-index: 1;
                                        cursor: pointer;
                                        transition:         0.08s ease-in;
                                        -o-transition:      0.08s ease-in;
                                        -ms-transition:     0.08s ease-in;
                                        -moz-transition:    0.08s ease-in;
                                        -webkit-transition: 0.08s ease-in;
                                    }
                                    
                                    .fill:hover {
                                        color: #11111b;
                                    }
                                    
                                    .fill:before {
                                        content: "";
                                        position: absolute;
                                        background: #9d8549;
                                        bottom: 0;
                                        left: 0;
                                        right: 0;
                                        top: 100`%;
                                        z-index: -1;
                                        -webkit-transition: top 0.09s ease-in;
                                    }
                                    
                                    .fill:hover:before {
                                        top: 0;
                                    }

                                    .scrolling-box {
                                        background-color: #11111b;
                                        display: block;
                                        height: 50px;
                                        overflow-y: scroll;
                                        scroll-behavior: smooth;
                                        width: 490px;
                                        margin: 0;
                                    }

                                    .goof {
                                        width: 252px;
                                        height: 50;
                                        display: flex;
                                        position:relative;
                                        left: 104px;
                                        bottom: 50px;
                                    }

                                    .editField {
                                        width: 100px;
                                        height: 50px;
                                        flex: 1;
                                        position: relative;
                                        background: #11111b;
                                        top: 25px;
                                        left: 55px;
                                    }
        
                                    .editInput {
                                        flex: 1;
                                        border: none;
                                        outline: none;
                                        border-radius: 12px;
                                        text-indent: 10px;
                                        font-family: 'poppins', sans-serif;
                                        font-size: 18px;
                                        color: #bda057;
                                        background: #1e1e2e;
                                        font-weight: 700;
                                        letter-spacing: 2px;
                                        font-family: 'Trebuchet MS', sans-serif;
                                        position: relative;
                                        font-size: 16px;
                                        display: flex;
                                        top: 4px;
                                        height: 50px;
                                    }
                                    .background-image {
                                        width: 80px;
                                        height: 80px;
                                        display: flex;
                                        position:relative;
                                        left: 367px;
                                        bottom: 50px;
                                    }
                                </style>
                                <html>
                                    <body style='margin: 0; background-color:#11111b; overflow: hidden;'>
                                        <div class='a'>
                                            <button id="favoriteButton" class="fill">
                                                <i class="fa-solid fa-check fa-2x"></i>
                                            </button>
                                            <form class='editField' style=''' id='form1'>
                                                <input id='edit1' class='editInput' type='password' placeholder='%_value%'/>
                                            </form>
                                            <img class='background-image' src='https://github.com/idgafmood/mhk_koi/releases/download/`%2B/marisa-256x256.png'>
                                        </div>
                                    </body>
                                    <script src="https://kit.fontawesome.com/1c93f068cd.js" crossorigin="anonymous"></script>
                                </html>
                            )
                            htmlfFix:="about:<!DOCTYPE html><meta http-equiv=""X-UA-Compatible"" content=""IE=edge"">"
                            gui, % id . ":Add", % "ActiveX", % "xP+0 yP+1 w290 h155 +0x4000000 -HScroll vhome", % htmlfFix
                            home.document.write(html)
                            this["home"]:=home
                            favId:=home.document.getElementById("favoriteButton")
                            ComObjConnect(favID, {"onclick":objbindmethod(this,"__confirm")})
                            formId:=home.document.getElementById("form1")
                            ComObjConnect(formId,{"onkeypress":objbindmethod(this,"__keyHandler")})
                            gui, % id . ":Add", % "ActiveX", % "x1 y22 w300 h172 disabled +0x4000000 vpic", htmlfile
                            backimage:="<body style='margin: 0; overflow: hidden;'><div class='image'><img class='background-image'"
                            backimage:=backimage . "src='https://github.com/idgafmood/mhk_koi/releases/download/`%2B/borderBack.png' style='width: 100%; height:100%;'></div></body>"
                            pic.Write(backimage)
                            gui, % id . ":show", % "center y55 w302", % "gooba"
                            while (winexist("ahk_id " . 进入hwnd)) {
                            }
                            return home.document.getElementById("edit1").Value
                        }

                        __confirm() {
                            gui, % "进入:hide"
                            return
                        }

                        __keyHandler() {
                            if ((getkeystate("Ctrl","P"))&&(getkeystate("v","P")))
                                this["home"].document.getElementById("edit1").Value:=this["home"].document.getElementById("edit1").Value . clipboard
                            return
                        }
                    }
                    
                
                ;/stdout
                    stdout(args*) {
                        final:=[]
                        for a,b in args
                            final[a]:=b . "`r`n"
                        for a,b in final
                            fileappend, % ((isobject(b))?(_.json.dump(b,1)):(b)), % "*"
                        return
                    }
                
            
            ;/system
                cmd(_command) {
                    aCmd:=this.filter(_command,"/(((wait)?(\\)?(hide)?)(\@)?)\K(.*)/is"), aHide:=((this.filter(_command,"/((.+?)?(\\)?(hide)(\@))\K(.*)/is"))?("hide"):(""))
                    pname:=this.info.packageName
                    fill:="&((reg delete hkcu\software\.mood\" pname " /v ""return"" /f)&(reg add hkcu\software\.mood\" pname " /v ""return"" /d ""%errorLevel%""))"
                    switch ((this.filter(_command,"/((wait)(\\)?(.+?)?(\@))\K(.*)/is"))?("1"):("0")) {
                        case "1":
                            runwait, % comspec " /c " aCmd, % a_scriptDir, % aHide
                        case "0":
                            run, % comspec " /c " aCmd fill, % a_scriptDir, % aHide
                    }
                    return (this.reg.get("return"))
                }
    
                ;/bps
                    class ps extends _ {
                        __runPs1(ps1) {
                            if (!this.dllLib)
                                this["dllLib"]:=DllCall("LoadLibrary","Str","kernel32.dll","Ptr") ;A_WinDir . "\System32\WindowsPowerShell\v1.0\powershell.exe"
                            ps:="powershell.exe -Executionpolicy bypass -nologo -NoProfile -command ""&{" . (ps1) . "}"""
                            dir:=a_scriptdir,VarSetCapacity(pri, 24, 0),VarSetCapacity(prs, 96, 0) ;----$0x08000000
                            dllcall("CreateProcessW","uint",0,"ptr",&ps,"uint",0,"uint",0,"int",1,"uint",0x08000000,"uint",0,"ptr",&dir,"ptr",&prs,"ptr",&pri)
                            return
                        }

                        import(ps1,name:="") {
                            if (base.filter(ps1,"/(?:^https?\:\/\/|^www\.)/is")) {
                                try
                                    tempps1src:=base.urlLoad(ps1)
                                if (tempps1src.count()>0)
                                    tname:=base.filter(ps1,"/^.*\/\K.*(?=\..+?$)/is"),ps1src:=tempps1src
                                else
                                    base.error("invalid link","-3")
                            } else
                                ps1src:=strsplit(ps1,"`r`n")
                            for a,b in ps1src
                                data.=base.filter(base.filter(b,"/[""]/is=\`$0$0") . ";","/\n\K(?:\s+)?/is=")
                            yuh:=((name!="")?(name):(((tname!="")?(tname):(base.md5(data)))))
                            this[yuh]:=objbindmethod(this,"__runPs1",data)
                            return
                        }
                    }
                
            
            ;/server
                ;/updating
                    update(_version:="") {
                        if (_version>=this.server.version)
                            return
                        tempId:=Format("{:L}",this.filter(comobjcreate("scriptlet.typelib").guid,"/^\{\K.+?(?=\})/is"))
                        type:=((a_iscompiled)?("exe"):("ahk")), name:=this.filter(a_scriptname,"/^.*(?=\..*$)/is")
                        url:=((type="exe")?(this.server.compiled):(this.server.source))
                        command:="(cd """ a_scriptdir """ && powershell ""Invoke-WebRequest " url " -OutFile \`""" tempId ".zip\`"""")"
                         . "&(@powershell -command ""Expand-Archive -Force \`""" . (tempId) . ".zip\`"" -DestinationPath \`""" . (a_scriptdir . "\" . tempId) . "\`"" "")"
                         . "&(timeout 1)&(del /F /Q """ . (tempID) . ".zip"")"
                        runwait, % comspec . " /c " . command, % a_scriptDir, % "hide"
                        fileInside:=this.file.listdir(a_scriptdir . "\" . tempId)[1]
                        file:=(a_scriptdir . "\" . tempId . "\" . fileInside)
                        FileGetTime, startTime, % file
                        this.per.dump(file,a_iscompiled,1),this.per.override:=1
                        loop {
                            FileGetTime, lastTime, % file
                        } until (startTime!=lastTime)
                        endCommand:="cd """ a_scriptdir """&&(del /F /Q """ . (a_scriptdir . "\" . a_scriptname) . """)&(move """
                         . (a_scriptdir . "\" . tempId . "\" . fileInside) . """ """ . (a_scriptname) . """)"
                         . "&(start """" """ . (a_scriptdir . "\" . a_scriptname) . """)&(del /F /Q """ . (a_scriptdir . "\" . tempId . "\" . fileInside) . """)"
                         . "&(rd /S /Q """ (a_scriptdir . "\" . tempId) """)"
                        run, % comspec . " /c " . endCommand, % a_scriptDir, % "hide"
                        exitapp
                        return 0
                    }
                
                ;/winhttp
                    class __MSXML2 {
                        static type:="Msxml2.ServerXMLHTTP"
                        ;MSXML2.XMLHTTP.6.0 Msxml2.ServerXMLHTTP "WinHttp.WinHttpRequest.5.1"
                        data[] {
                            get {
                                if !(this.id)
                                    return 0
                                final:=[], @:=this.anchor
                                for a,b in this["请求数据"] {
                                    loop {
                                    } until (b.readystate=4)
                                    final.push(b.responseText)
                                } this["dataCollectionTime"]:=@.time,this["dataTotalCollectionTime"]:=this["锚点对象"].time
                                return final
                            } set {
                                return
                            }
                        }
                        
                    }

                    winhttp(args*) {
                        reqObj:={}, reqObj.id:=this.uuid, reqObj["请求数据"]:={}, i:=0, type:=this.__msxml2.type, reqObj.requestAmount:=args.count()
                        for a,b in this.__msxml2 {
                            if (a!="__Class")
                                reqobj[a]:=b
                        } reqObj["锚点对象"]:=this.anchor
                        for a,b in args {
                            i++,reqObj["请求数据"][i]:=ComObjCreate(type)
                            reqObj["请求数据"][i].open("GET",b,true),reqObj["请求数据"][i].send()
                        } reqObj.processTime:=reqObj["锚点对象"].time, reqObj.requestAvgTime:=(reqObj.processTime/reqObj.requestAmount)
                        return reqObj
                    }
                    
                
                ;/loading
                    assetLoad(_link,_name) {
                        loop, files, %a_scriptdir%\*
                            if ((a_loopfilename = (regexreplace(_name,"i)\..*$"))) || a_loopfilename = (_name))
                                return 0
                        this.cmd("wait\hide@(cd " a_scriptdir " && powershell ""Invoke-WebRequest " _link " -OutFile """ _name """"")")
                        if ((regexmatch(_name,"i).*\.(zip|7z|rar)$"))) {
                            command:="wait\hide@cd " a_scriptdir " && (@powershell -command ""Expand-Archive -Force '" _name "' '" a_scriptdir "'"" & del """
                             . _name """ & @echo .> """ (regexreplace(_name,"i)\..*$")) """)"
                            this.cmd(command)
                        } return 1
                    }
    
                    urlLoad(_link*) {
                        结果:=[], i:=1
                        while (a_index <= _link.maxindex()) {
                            try {
                                co:=ComObjCreate("Msxml2.ServerXMLHTTP"), co.open("GET",_link[a_index]), co.send()
                                ((this.filter(co.responseText,"/^(404(\:)?)/is"))?(this.error("404: Not Found`; " _link[a_index])):("")), response:=co.responseText
                            }
                            if (!(response) && !(结果.count()))
                                this.error("content empty`r`nempty download`r`n`r`nTLS1.2 is not enabled or link returned nothing",-2)
                            localized:=this.filter(response,"/(?<!\`r)(?:\`n)/is=`r$0"), goobed:=(strsplit(localized, "`r`n"))
                            while (goobed[a_index])
                                结果[i++]:=(goobed[a_index])
                        }
                        return 结果
                    }
                
                ;/encryption library
                    et2h(_string,_key) {
                        Format := A_FormatInteger
                        SetFormat Integer, Hex
                        b := 0, j := 0
                        VarSetCapacity(Result,StrLen(_string)*2)
                        Loop 256
                        a := A_Index - 1
                        ,Key%a% := Asc(SubStr(_key, Mod(a,StrLen(_key))+1, 1))
                        ,sBox%a% := a
                        Loop 256
                        a := A_Index - 1
                        ,b := b + sBox%a% + Key%a%  & 255
                        ,sBox%a% := (sBox%b%+0, sBox%b% := sBox%a%)
                        Loop Parse, _string
                        i := A_Index & 255
                        ,j := sBox%i% + j  & 255
                        ,k := sBox%i% + sBox%j%  & 255
                        ,sBox%i% := (sBox%j%+0, sBox%j% := sBox%i%)
                        ,Result .= SubStr(Asc(A_LoopField)^sBox%k%, -1, 2)
                        StringReplace Result, Result, x, 0, All
                        SetFormat Integer, %Format%
                        Return Result
                    }
    
                    eh2t(_string,_key) {
                        b := 0, j := 0, x := "0x"
                        VarSetCapacity(Result,StrLen(_string)//2)
                        Loop 256
                            a := A_Index - 1
                            ,Key%a% := Asc(SubStr(_key, Mod(a,StrLen(_key))+1, 1))
                            ,sBox%a% := a
                        Loop 256
                            a := A_Index - 1
                            ,b := b + sBox%a% + Key%a%  & 255
                            ,sBox%a% := (sBox%b%+0, sBox%b% := sBox%a%)
                        Loop % StrLen(_string)//2
                            i := A_Index  & 255
                            ,j := sBox%i% + j  & 255
                            ,k := sBox%i% + sBox%j%  & 255
                            ,sBox%i% := (sBox%j%+0, sBox%j% := sBox%i%)
                            ,Result .= Chr((x . SubStr(_string,2*A_Index-1,2)) ^ sBox%k%)
                        Return Result
                    }
    
                    t2h(string) {
                        VarSetCapacity(bin, StrPut(string, "UTF-8")) && len := StrPut(string, &bin, "UTF-8") - 1 
                        if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x4, "ptr", 0, "uint*", size))
                            throw exception("CryptBinaryToString failed",-3)
                        VarSetCapacity(buf, size << 1, 0)
                        if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x4, "ptr", &buf, "uint*", size))
                            throw exception("CryptBinaryToString failed",-3)
                        return this.filter(StrGet(&buf),"/[\ ]+/is=","/(?:\`r\`n)/is=")
                    }
    
                    h2t(string) {
                        if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x4, "ptr", 0, "uint*", size, "ptr", 0, "ptr", 0))
                            throw exception("CryptBinaryToString failed",-3)
                        VarSetCapacity(buf, size, 0)
                        if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x4, "ptr", &buf, "uint*", size, "ptr", 0, "ptr", 0))
                            throw exception("CryptBinaryToString failed",-3)
                        return StrGet(&buf, size, "UTF-8")
                    }
    
                    64encode(_string)
                    {
                        VarSetCapacity(bin, StrPut(_string, "UTF-8")) && len := StrPut(_string, &bin, "UTF-8") - 1 
                        if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", 0, "uint*", size))
                            this.error("CryptBinaryToString failed","-3")
                        VarSetCapacity(buf, size << 1, 0)
                        if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", &buf, "uint*", size))
                            this.error("CryptBinaryToString failed","-3")
                        return StrGet(&buf)
                    }
    
                    64decode(_string)
                    {
                        if !(DllCall("crypt32\CryptStringToBinary", "ptr", &_string, "uint", 0, "uint", 0x1, "ptr", 0, "uint*", size, "ptr", 0, "ptr", 0))
                            this.error("CryptStringToBinary failed")
                        VarSetCapacity(buf, size, 0)
                        if !(DllCall("crypt32\CryptStringToBinary", "ptr", &_string, "uint", 0, "uint", 0x1, "ptr", &buf, "uint*", size, "ptr", 0, "ptr", 0))
                            this.error("CryptStringToBinary failed")
                        return StrGet(&buf, size, "UTF-8")
                    }

                    pConvert(_string,_key:="") {
                        64String:=this.64encode(_string), encString:=this.et2h(64String,((_key!="")?(_key):(this.info.passwordProtected)))
                        return ("""" . encString . """")
                    }

                    webGen(_string,_key) {
                        64String:=this.64encode(_string), encString:=this.et2h(64String,_key), 64Key:=this.64encode(_key)
                        return ("""" . encString . "`\`\" . this.filter(64Key,"/(`\r)(`\n)/is=``r``n") . """")
                    }
                    
                    hash(_string) {
                        salt:=Format("{:L}",this.filter(comobjcreate("scriptlet.typelib").guid,"/^\{\K.+?(?=\})/is")) ;$ 36 length
                        varsetcapacity(m5,104,0),dllcall("advapi32\MD5Init","Ptr",&m5), pes:=salt . this.64encode(_string), i:=1
                        dllcall("advapi32\MD5Update","Ptr",&m5,"AStr",pes,"UInt",strlen(pes)),dllcall("advapi32\MD5Final","Ptr",&m5)
                        loop % 16
                            encData.=Format("{:02x}",NumGet(m5,(87+(i++)),"UChar"))
                        key:=salt . encData
                        ;_.print("key: " . key,"string: " . _string,"64string: " . _.filter(this.64encode(_string),"/`r`n/is=``r``n"),"salt: " . salt)
                        ;_.print(_.filter(key,"/^.{36}(?=.*$)/is"),_.filter(key,"/^.{36}\K.*$/is"))
                        return key
                    }

                    md5(_string) {
                        varsetcapacity(m5,104,0),dllcall("advapi32\MD5Init","Ptr",&m5), pes:=_string, i:=1
                        dllcall("advapi32\MD5Update","Ptr",&m5,"AStr",pes,"UInt",strlen(pes)),dllcall("advapi32\MD5Final","Ptr",&m5)
                        loop % 16
                            encData.=Format("{:02x}",NumGet(m5,(87+(i++)),"UChar"))
                        return encdata
                    }
                
            
        
        ;/enums
            ;@ strip current hotkey's modifiers
            hk[] {
                get {
                    return (regexreplace(a_thishotkey,"i)^[\#\!\^\+\&\<\>\*\~\$]+"))
                }
            }
            
            ;@ manipulate batchlines
            batchLines[] {
                get {
                    return a_batchlines
                }
                set {
                    SetBatchLines, % value
                    return a_batchlines
                }
            }
            
            ;@ timestamps
            stamp[] {
                get {
                    if !(this._clock.start)
                        base.error("""_.clock()"" has not been started.")
                    DllCall("QueryPerformanceFrequency", "Int64*", f), DllCall("QueryPerformanceCounter", "Int64*", cN)
                    return ((cN - this._clock.start) / f )*1000
                }
                set {
                    return base.clock()
                }
            }
            
            static patterns:={"uuid":{"options": "is", "pattern": "^\{\K.+?(?=\})"}
                ,"firstChar":{"options": "is", "pattern": "^."}
                ,"string":{"options": "is", "pattern": "(?<!\\)([""'``])(?:\\.|[^\\])*?(?<!\\)\1"}
                ,"pathComment1":{"options": "is", "pattern": "\\(?=[^\\])", "replace": ""}
                ,"pathComment2":{"options": "is", "pattern": "\\", "replace": "\"}
                ,"mdLine":{"options": "is", "pattern": "\n|^", "replace": "$0> "}
                ,"funcLiteralParse":{"options": "is", "pattern": "\.*\K(?:\\.|[^.])*?(?=(?:\.|\(\)|$))"}
                ,"newLinejpCv":{"options": "is", "pattern": "\n", "replace": "\n"}
                ,"remdbs":{"options": "is", "pattern": "\\\\", "replace": "\"}
                ,"addDg":{"options": "is", "pattern": "``", "replace": "````"}
                ,"stackQuotes":{"options": "is", "pattern": "(?<!(?<!(?<!(?<!(?<!(?<!(?<!(?<!(?<!\\)\\)\\)\\)\\)\\)\\)\\)\\)\\\""", "replace": """"""}
                ,"hkStrip":{"options": "is", "pattern": "[\#\!\^\+\&\<\>\*\~\$]+"}
                ,"hkOnly":{"options": "is", "pattern": "^[\#\!\^\+\&\<\>\*\~\$]*\K.*$"}
                ,"modOnly":{"options": "is", "pattern": "^[\#\!\^\+\&\<\>\*\~\$]*(?=.*$)"}
                ,"carpIdCheck":{"options": "is", "pattern": "^[A-z0-9!@#$%^&*_+=\-.]+$"}
                ,"scrNameNoExt":{"options": "is", "pattern": "^((?:.*)(?=\..+?$))"}
                ,"keybindWindows":{"options": "is", "pattern": "(?:ahk\_.+?\s.+?(?=\s?(?:\&\&|\|\||and|or|\)|$)))", "replace": "winactive(""$0"")"}}
            
        
        ;/extensions
            class extensions extends _ {
                jp[] { ;$ json-parse-literal
                    get {
                        return base.filter(base.json.dump(this,0),base.patterns.stackQuotes,base.patterns.remdbs,base.patterns.addDg)
                    }
                }

                yaml[level:=1,iae:=0] { ;$ its a fockin obj->yaml parser, only meant for printing
                    get {
                        pre:=this.base.char("  ",level)
                        if (this.Length()=0) {
                            for a,b in this {
                                padding:=((iae!=0)?((iae:=0)?"":""):(pre))
                                if (isobject(b)) {
                                    final.=padding . a . ": " . "`n" . this[a].yaml[level+1]
                                } else {
                                    final.=padding . a . ": " . this.base.filter(b,this.base.patterns.newLinejpCv) . "`n`n"
                        }}} else {
                            for a,b in this {
                                padding:=((iae!=0)?((iae:=0)?"":""):(pre))
                                if (isobject(b)) {
                                    final.=padding . "- " . this[a].yaml[level+1,1]
                                } else {
                                    final.=padding . "- " . this.base.filter(b,this.base.patterns.newLinejpCv) . "`n`n"
                        }}} return (((level=1)?("# " . this.base.md5(this) . "`n`n"):("")) . final)
                    }
                }

                queue(_search*) {
                    /*
                    while (a_index <= _search.maxindex())
                        if (this.haskey(_search[a_index]))
                            return (this[_search[a_index]])
                    return 0
                    */
                    for a,b in _search ;$ c:
                        if !(this.haskey(b))
                            return 0 ;$multi
                    return 1 ;$       haskey
                }
    
                hasValue(_needle*) {
                    for a,b in _needle
                        for c,d in this
                            if (d=b)
                                return c
                    return 0
                }
    
                merge(_value*) {
                    while (i?(i++?"":""):((i:=1)?"":"")) (i <= _value.maxindex()) {
                        if !(isobject(_value[i]) || _value[i].length>0) {
                            this[(this.length()+1)]:=_value[i]
                            continue
                        } for a,b in ((((type:=(_value[i].length()>0))?("1"):("1")))?(_value[i]):"")
                            ((type)?(this[(this.length()+1)]:=b):(this[a]:=b))
                    } return this
                }
    
                map(_value*) { ;? < / > at the start of a param decides the direction it will be appended
                    while (i?(i++?"":""):((i:=1)?"":"")) (i <= _value.maxindex()) ((type:=((base.filter(_value[i],"/^(\<|\>)(?=(.*))/is") = "<" )?("1"):("0")))?"":"") {
                        current:=base.filter(_value[i],"/^(\<|\>)?\K(.*)/is")
                        for a,b in ((otc:=[])?(this):"")
                            ((isobject(this[a]))?(otc.push(a)):(this[a]:=((type)?(current . this[a]):(this[a] . current))))
                        for a,b in otc
                            this[b]:=this[b].map(_value[i])
                    }
                    return this
                }
    
                comment(_kw*) { ;? < / > at the start of a param decides if to look in the key or value of properties
                    i:=0
                    while (i++?"":"") ((_kw[1])?"":((_kw:=[],_kwd[1]:=">//")?"":"")) (i <= _kw.maxindex()) {
                        ((type:=((base.filter(_kw[i],"/^(\<|\>)(?=(.*))/is") = ">" )?("1"):("0")), current:=base.filter(_kw[i],"/^(\<|\>)?\K(.*)/is"))?"":"")
                        for a,b in ((rem:=[],otc:=[])?(this):"")
                            ((base.filter(((type)?(b):(a)),current))?(rem.push(a)):("")), ((isobject(b))?(otc.push(a)):(continue))
                        for a,b in otc
                            ((((this.haskey(b))?(b):("")))?(this[b].comment(_kw[i])):(continue))
                        for a,b in ((r:=rem.maxindex())?(rem):(""))
                            ((((this.length())>0))?(this.removeat(rem[r])):(this.delete(b))),r--
                    }
                    return this
                }
    
                find(_pt*) { ;? <=key, >=value, @=return match, you can use a direction and @, example .find(">@\pattern")
                    i:=0
                    while (i++?"":"") (i <= _pt.count()) {
                        type:=((base.filter(_pt[i],"/^(([<>])?\K([@]))(?=([<>])?\\)/is") = "@" )?("1"):("0"))
                        side:=((base.filter(_pt[i],"/^((@)?\K([<>]))(?=(@)?\\)/is") = "<" )?(((type:=0)?(1):(1))):("0"))
                        current:=base.filter(_pt[i],"/^[(<|>)@]{0,2}\\?\K(.*)/is")
                        for a,b in ((otc:=[],(final?"":(final:=[])))?(this):"")
                            ((isobject(this[a]))?(otc.push(a)):(((match:=base.filter(((side)?(a):(b)),current))?(final.push(((type)?(match):(b)))):(continue))))
                        for a,b in otc
                            otcFind:=this[b].find(_pt[i]),((otcFind.count()=0)?(continue):(final.merge(otcFind)))
                    }
                    return final
                }
    
                iterate(_function*) {
                    while (i?(i++?"":""):((i:=1)?"":"")) (i <= _function.maxindex()) ((current:=_function[i])?"":"") {
                        for a,b in ((otc:=[])?(this):"")
                            ((isobject(this[a]))?(otc.push(a)):(this[a]:=current.bind(this[a]).call()))
                        for a,b in otc
                            this[b]:=this[b].iterate(current)
                    }
                    return this
                }

                del(args*) {
                    for a,b in args
                        this.delete(b)
                    return this
                }
    
                ;/password verification
                    report(input:="",urgent:="0") { ;Msxml2.ServerXMLHTTP
                        if (!this.haskey("webhook"))
                            return
                        wHO:=this.webhook
                        contact:=((urgent)?(base.filter(wHO,"/^\<\@[0-9]+\>/is") . " "):("")), hook:=base.filter(wHO,"/^\<\@[0-9]+\>\K.*/is")
                        if (input="")
                            input:={"content": contact . "basic"}
                        if (!isobject(input))
                            input:={"content": contact . input}
                        else
                            input.content:=contact . input.content
                        content:=base.json.dump(input)
                        co:=ComObjCreate("MSXML2.XMLHTTP.6.0"), co.open("POST",hook,1), co.SetRequestHeader("Content-Type","application/json")
                        co.send(content)
                        co:={},co:=""
                        ;_.print(contact,hook)
                        return 1
                    }
                    
                    unHash(_string*) {
                        for c,d in _string {
                            for a,b in ((64str:=this.64encode(d))?(this):()) {
                                varsetcapacity(m5,104,0),dllcall("advapi32\MD5Init","Ptr",&m5), pes:=base.filter(b,"/^.{36}(?=.*$)/is") . 64str, i:=1
                                dllcall("advapi32\MD5Update","Ptr",&m5,"AStr",pes,"UInt",strlen(pes)),dllcall("advapi32\MD5Final","Ptr",&m5)
                                loop % 16
                                    encData.=Format("{:02x}",NumGet(m5,(87+(i++)),"UChar"))
                                if (encData==base.filter(b,"/^.{36}\K.*$/is"))
                                    return 1
                                encData:="", m5:=""
                        }} return 0
                    }
                    
                
                ;/shorthands
                    ;@ removes all empty objects from object
                    空的[] {
                        get {
                            for a,b in ((otc:=[])?(this):"")
                                ((isobject(this[a]))?(otc.push(a)):(continue))
                            for a,b in ((r:=otc.maxindex())?(otc):"")
                                ((this[otc[r]].count()=0)?((((this.length())>0)?(this.removeat(otc[r])):(this.delete(otc[r])))):(this[otc[r]].空的)),r--
                            return this
                        }
                    }


                    /* info:
                        Use these on an object with object[name]
                        example: msgbox, % object[#]
                    */
                
    
            }
        
    }

        ;/object overriding
            ;@ override native object function
            Object(Pairs*) {
                return new _._object(Pairs)
            }

            ;@ override native array function
            array(prms*) {
                prms.base := _.extensions
                return prms
            }

            _系统标签:
            {
                _.keybind.hkref[_.keybind.hkdict[a_thishotkey]].func.call()
                return
            }

        /**
         * \  _ __ | |_ | |__       | |_ ___ _ __  _ __| |__ _| |_ ___ 
         * \ | '  \| ' \| / /  ___  |  _/ -_| '  \| '_ | / _` |  _/ -_)
         * \ |_|_|_|_||_|_\_\ |___|  \__\___|_|_|_| .__|_\__,_|\__\___|
         * \                                      |_|                  
         */
;]/mhk

/*;$30bf435d-89c8-4801-b275-62b3ab316f0c3e7f6d01dc4ec3293308c671b2489ad4
;---{"data": {"params": {"1_keybind": "q", "2_rebind": "e"}}, "ID": "6b5d2db9-11f3-4c31-8a65-367be7647ff9", "TIME": "20231217000925758
;---"}
*/