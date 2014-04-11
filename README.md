#How to Create MiniPlayer (for Mac) Plug-Ins
---------------------------
1. Get MiniPlayer for Mac http://mpow.it/miniplayerMac 
1. Create a new project (Bundle)
2. In Build Settings menu change the Wrapper extension from "bundle" to "miniplayerplugin"
3. Create a new class and set in the info plist the key NSPrincipalClass to the name of the class created
4. Create your plugin making sure that your class conform to the protocol <MPMiniPlayerPlugin> (see MPMiniPlayerPlugin.h)
5. Build and double click the bundle created to add to MiniPlayer (it's possible that you have to restart it in same case, user will not have to do the first time that they install it)
6. Your PlugIn can be listed in my website or included in MiniPlayer if you wish, just contact me at manzopower@icloud.com

##More Help
------------------
1. Read the comments in MPMiniPlayerPlugin.h
2. Setting the distribuitedNotificationName MiniPlayer will be notified of song/playStatus changes, if the App you want to support doesn't provide notifications implement your own way 
3. To build my plugins I used Apple's ScriptingBridge Framework  ( https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ScriptingBridgeConcepts/UsingScriptingBridge/UsingScriptingBridge.html ). It is a bridge between Apple Script and Objective C, you can create the header for your Application with the command 
```sdef /Applications/iTunes.app | sdp -fh --basename iTunes``` and using the Objects to get what you need from the app
4. You can use your own approach to get the info to provide to MiniPlayer...



##Example
----------------
See the iTunes plugin included as example