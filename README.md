# VMGuide

A handy utility to manage your virtual machines, provides an easy access to hardware configuration and BIOS settings that are commonly hidden in the UI.

Useful when installing pre-release or vintage software.

## Supported Virtualizer
- VMware Workstation/Player
- Microsoft Virtual PC 2004/2007
- Windows Virtual PC (for Windows 7)
- Virtualbox

## Features
- Adjust the BIOS date of your virtual machine and disable time sync.
- Turn off ACPI support, handy when installing OSes that have issuses with ACPI.
- Specify the hardware your VM virtualizes, like Sound Card and Network Adapter (VMware only).
- Search all your virtual machines and manage in one UI.
- Command line and scriptting support (VMGuide.CUI).
- WPF-based GUI, and System-Aware DPI Scaling support.

## Command Line
Type "help" in the prompt to get a detailed help.

You can also use commands as a parameter. Use semicomons to sperate commands, and add quotation marks if needed.

Example:

    C:\>VMGuide.CUI.exe "select file=\"D:\Virtual Machines\Windows XP.vmx\";set biosdate=20010625"
   
Which equals to:

    C:\>VMGuide.CUI.exe
    VMGuide>select file="D:\Virtual Machines\Windows XP.vmx"
    VMGuide>set biosdate=20010625

## Scripting
You can create a UTF-8 text file with commands as a script, then specify the script file in the shell command line.

Example:

    C:\>VMGuide.CUI.exe whistler.txt

whistler.txt:

    select file="D:\Virtual Machines\Windows XP.vmx"
    set biosdate=20010625
    set sound=es1371

## URL Protocol
The URL protocol vm-settings is supported, which provides an user-friendly way to integrate VMGuide GUI to your project.

You may need to manually register this protocol, a batch file (Tools\register.bat) is provided to do so.

Example:

    vm-settings://biosdate/20050721
    vm-settings://datelock/false (The value "true" is meaningless, set the bios date and it will disable time sync.)
    vm-settings://acpi/false

## UWP Bridge for Desktop (Project Centennial) Ready
This program is tested to work as a Centennial UWP, use the assets and manifest provided to create your own .appx package.

The vm-settings URL Protocol is also supported when running as a Centennial UWP.

## 打包为可执行文件
在安装了 Visual Studio/MSBuild 的 Windows 环境中，执行 `Tools\package-release.bat` 可一次性编译解决方案，将 GUI 与命令行版的 EXE 输出到 `dist` 目录并自动压缩为便于下载的 ZIP 包。

步骤示例：

1. 打开“开发者命令提示”或已配置好 MSBuild 的终端。
2. 在仓库根目录运行：
   ```bat
   Tools\package-release.bat
   ```
3. 完成后在 `dist\GUI` 与 `dist\CUI` 子目录中即可获得打包好的 `VMGuide.GUI.exe` 与 `VMGuide.CUI.exe` 及其依赖文件；同时会生成 `dist\VMGuide.GUI.zip` 和 `dist\VMGuide.CUI.zip`，便于直接分享或下载。
