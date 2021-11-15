---
title: 初学Android Studio关于启动AVD虚拟机的问题小结（Ubuntu系统64位）
date: 2016-12-22 23:43:23
tags:
- Android
- Ubuntu
---


## [提示找不到AVD][1]

    Could not find INI file in $ANDROID_AVD_HOME nor in $HOME/.android/avd
解决方案：`~/.android/.avd` 下有可能是空的，实际上AVD的具体配置文件是在`/root/.android/.avd`中，文件名诸如`Nexus_7_API_23.ini`。因此需要将`~/.android`下的`.avd`文件夹删除，再设置软链连接到`/root/.android/.avd`。

Terminal 操作：
```linux
$ rm ~/.android/.avd
$ sudo ln -s /root/.android/.avd ~/.android/.avd
```
[1]: http://stackoverflow.com/questions/27537578/could-not-find-ini-file-in-android-avd-home-nor-in-home-android-avd

## [X_GLXIsDirect错误][2]
报错输出内容:
```
Minor opcode of failed request:  6 (X_GLXIsDirect)
Serial number of failed request:  48
Current serial number in output stream:  47
libGL error: unable to load driver: swrast_dri.so
libGL error: failed to load driver: swrast
X Error of failed request:  GLXBadContext
Major opcode of failed request:  155 (GLX)
Minor opcode of failed request:  6 (X_GLXIsDirect)
Serial number of failed request:  48
Current serial number in output stream:  47
libGL error: unable to load driver: swrast_dri.so
libGL error: failed to load driver: swrast
X Error of failed request:  BadValue (integer parameter out of range for operation)
Major opcode of failed request:  155 (GLX)
Minor opcode of failed request:  24 (X_GLXCreateNewContext)
Value in failed request:  0x0
Serial number of failed request:  32
Current serial number in output stream:  33
```

解决方案：
备份AndroidSDK自带lib64stc++6包，使用ubuntu软件库的lib64stc++6代替并安装mesa-utils。
Terminal 操作：
```
$ sudo apt-get install lib64stdc++6
$ cd ~/Android/Sdk/tools/lib64/libstdc++
$ mv libstdc++.so.6 libstdc++.so.6.original
$ ln -s /usr/lib64/libstdc++.so.6 ~/Android/Sdk/tools/lib64/libstdc++
$ sudo apt-get install mesa-utils
```
[2]: http://android.stackexchange.com/questions/145437/reinstall-avd-on-ubuntu-16-04

## [Could not create GLES 2.x Pbuffer!][3]
错误提示:
```
failed to create drawable
getGLES2ExtensionString: Could not create GLES 2.x Pbuffer!
Failed to obtain GLES 2.x extensions string!
Could not initialize emulated framebuffer
emulator: Listening for console connections on port: 5554
emulator: Serial number of this emulator (for ADB): emulator-5554
emulator: ERROR: Could not initialize OpenglES emulation, use '-gpu off' to disable it.
```

解决方案：
在Android Studio中进入AVD Manager，编辑相应的AVD设备，在Emulated Performance中选择`Software GLES2.0`。保存并重启即可。
[3]: http://stackoverflow.com/questions/30686324/error-while-running-android-application-could-not-initialize-opengles-emulatio
