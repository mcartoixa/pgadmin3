@echo off

setlocal

REM Configure which modules should be built
set WXBASE=wxtiff wxexpat wxjpeg wxpng wxregex wxzlib base core adv aui html net xml xrc
set WXCONTRIB=stc

REM Location of wxWidgets source
set WX=%WXWIN%
set HERE=%CD%

if not exist %WX%\build\msw\wx.dsw goto no_wx

pushd %WX%
patch.exe -p1 -i "%HERE%\patches\wxmsw-2_8_12-window.diff"
popd

REM Copy include files
copy /Y setup0-msw-2.8.h "%WX%\include\wx\setup0.h"
copy /Y setup0-msw-2.8.h "%WX%\include\wx\setup.h"
copy /Y setup0-msw-2.8.h "%WX%\include\wx\msw\setup.h"

REM Convert projects if necessary
cd /D %WX%\build\msw
del *.vcproj.user 2> NUL
for %%f in (%WXBASE%) do (
   echo Checking %%f
   if not exist wx_%%f.vcxproj (
      vcupgrade.exe -nologo -PersistFrameWork wx_%%f.dsp
      ren wx_%%f.vcxproj wx_%%f.orig.vcxproj
      powershell.exe -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "& { $xslt = New-Object System.Xml.Xsl.XslCompiledTransform; $xslt.load('%HERE%\fix-vcxproj.xslt'); $xslt.Transform('wx_%%f.orig.vcxproj', 'wx_%%f.vcxproj'); }"
   )
)
cd ..\..\contrib\build
for %%f in (%WXCONTRIB%) do (
   echo Checking contrib/%%f
   cd %%f
   del *.vcproj.user 2> NUL
   if not exist %%f.vcxproj (
      vcupgrade.exe -nologo -PersistFrameWork %%f.dsp
      ren %%f.vcxproj %%f.orig.vcxproj
      powershell.exe -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "& { $xslt = New-Object System.Xml.Xsl.XslCompiledTransform; $xslt.load('%HERE%\fix-vcxproj.xslt'); $xslt.Transform('%%f.orig.vcxproj', '%%f.vcxproj'); }"
   )
   cd ..
)

cd ..\..\utils\hhp2cached
echo Checking utils\hhp2cached
del *.vcproj.user 2> NUL
if not exist hhp2cached.vcxproj (
   vcupgrade.exe -nologo -PersistFrameWork hhp2cached.dsp
)

cd ..\wxrc
echo Checking utils\wxrc
del *.vcproj.user 2> NUL
if not exist wxrc.vcxproj (
   vcupgrade.exe -nologo -PersistFrameWork wxrc.dsp
)

REM Now build them
cd /D %WX%\build\msw
for %%b in (Debug Release) do (
   for %%f in (%WXBASE%) do (
      title Building project %%f, config %%b
      msbuild.exe /nologo wx_%%f.vcxproj /p:Configuration="Unicode %%b"
      msbuild.exe /nologo wx_%%f.vcxproj /p:Configuration="DLL Unicode %%b"
   )
)
cd ..\..\contrib\build
for %%b in (Debug Release) do (
   for %%f in (%WXCONTRIB%) do (
      cd %%f
      title Building project contrib/%%f, config %%b
      msbuild.exe /nologo %%f.vcxproj /p:Configuration="Unicode %%b"
      msbuild.exe /nologo %%f.vcxproj /p:Configuration="DLL Unicode %%b"
      cd ..
   )
)

cd ..\..\utils\hhp2cached
title Building project utils/hhp2cached, config Release
msbuild.exe /nologo hhp2cached.vcxproj /p:Configuration="Unicode Release"

cd ..\wxrc
title Building project utils/wxrc, config Release
msbuild.exe /nologo wxrc.vcxproj /p:Configuration="Unicode Release"

cd /D %HERE%
title "build-wx done."
echo "build-wx done."

goto :eof

:no_wx
echo wxWidgets not found in %WX%!
exit /b 1
