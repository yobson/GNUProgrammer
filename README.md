# GNUProgrammer
A tool to create simple (at the moment) but function based algorithm and convert them into other languages. At the moment it can output to VBS, c++ (not very tested)
and Python 2.7. It is good for people learning how to construct algorithms and then see how they look in different codes. It is written in GNUstep Objective C 2.0 with
Clang and is only tested on my windows machine and a raspberry pi.


##Installation:
#####Windows:
  1. You need to go and download GNUstep Core, GNUstep System, GNUstep Developer, GNUstep Msys and python 2.7.
     You can find the GNUstep file from here : http://ftpmain.gnustep.org/pub/gnustep/binaries/windows/

  2. Find you GNUstep installation (C:/GNUstep by default) then navigate to msys\1.0\etc and open 'profile' in a text editor.
     at the bottom of the file, add this line : `PATH=$PATH:/c/Python27`
     Change c/Python27 to wherever python is installed on your system.
	 
  3. Now we need to install clang. Open 'shell' from the GNUstep folder in start menu. in windows 8 or up just search for it.
     Once open type:
	 ```bash
	 svn co -r 181679 http://llvm.org/svn/llvm-project/llvm/trunk llvm
     cd llvm/tools
     svn co -r 181679 http://llvm.org/svn/llvm-project/cfe/trunk clang
	 ```
	 We now need to quickly fix the files downloaded because they will not work with GNUstep by default
	 Navigate to C:\GNUstep\msys\1.0\home\%YourName%\svn\llvm\tools\clang\lib\Frontend replacing %yourName% with the name of your user account
	 open in your favourite text editor the file InitHeaderSearch.cpp in that folder
	 Look for the line that starts with “FIXME: temporary hack: hard-coded paths.” at about line 215 and add these lines:

          ```c++
          // FIXME: temporary hack: hard-coded paths.
          AddPath("C:\\GNUstep\\include", System, false);
          AddPath("C:\\GNUstep\\msys\\1.0\include", System, false);
          AddPath("C:\\GNUstep\\msys\\1.0\include-fixed", System, false);
          AddPath("C:\\GNUstep\\lib\\gcc\\mingw32\\4.6.1\\include", System, false);
          AddPath("C:\\GNUstep\\lib\\gcc\\mingw32\\4.6.1\\include\\c++", System, false);
          AddPath("C:\\GNUstep\\lib\\gcc\\mingw32\\4.6.1\\include\\c++\\mingw32", System, false);
          AddPath("C:\\GNUstep\\lib\\gcc\\mingw32\\4.6.1\\include\\c++\\backward", System, false);
          AddPath("C:\\GNUstep\\GNUstep\\System\\Library\\Headers", System,false);
          //AddPath("/usr/local/include", System, true, false, false);
          break;
          ```
     DO NOT FORGET to comment out (add // infront of) the line AddPath("/usr/local/include", System, true, false, false);
	 
	 Now we will build it with these commands:
	 ```
	 cd ~/llvm && mkdir build && cd build
     ../configure --enable-optimized --enable-targets=host --enable-docs=no
	 make && make install
	 ```
	 This will take quite a long time and your room may get a bit hot!
	 
	 To test clang is installed type `clang --version`
	 
  4. Now you can compile and objective C 2.0 code! We will now navigate in the GNUStep shell to where ever you have downloaded my source and type: `make CC=clang` and hope it works.

#####Linux:
only tested on raspberry pi (raspbian) all you need is GNUstep and clang. If on debian, raspian or ubuntu:
  1. open terminal and type sudo su for conveniance
  2. type `apt-get install build-essential gnustep gnustep-devel clang`
  3. navage to where you have cloned this git
  4. type:
  ```
  export GNUSTEP_MAKEFILES=/usr/share/GNUstep/Makefiles
  make CC=clang
  ```
  DONE!

##How to run:
Go into the GNUProgrammer.app folder and On windows: open GNUProgrammer.exe. On UNIX: run in terminal: `./programmer`