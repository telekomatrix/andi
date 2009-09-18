# Some notes on stuff


## Tools

http://trollop.rubyforge.org/

http://user-choices.rubyforge.org/rdoc/

http://stackoverflow.com/questions/897630/really-cheap-command-line-option-parsing-in-ruby

Assumptions 

* The path to the android SDK bin dir is part of PATH
* Calls are made from root of project dir
* dir has suitable ant and config files


## Building

To build

    ant debug

or

    ant release


## Running

To run on an emulator:

First, get an emulator (or AVD: Android virtual device) running.

See a list of existing available AVDs:

    android list avd

To run one:

    emulator -avd <your_avd_name>


To create one:

Pick a target paltform.  To see available targets:


    android list targets

You get something like this:


    Available Android targets:
    id: 1
         Name: Android 1.1
         Type: Platform
         API level: 2
         Skins: HVGA-P, QVGA-L, QVGA-P, HVGA (default), HVGA-L
    id: 2
         Name: Android 1.5
         Type: Platform
         API level: 3
         Skins: HVGA-P, QVGA-L, QVGA-P, HVGA (default), HVGA-L
    id: 3
         Name: Google APIs
         Type: Add-On
         Vendor: Google Inc.
         Description: Android + Google APIs
         Based on Android 1.5 (API level 3)
         Libraries:
          * com.google.android.maps (maps.jar)
              API for Google Maps
         Skins: QVGA-P, HVGA-L, HVGA (default), QVGA-L, HVGA-P




Create a new AVD using your selected deployment target:

    android create avd --name <your_avd_name> --target <target_ID>

For example

    android create avd --name basic15 --target 2

## Geting an app on an AVD

Install your apk file using

    adb install  /path/to/your/CoolApp.apk

The apk file is typically under the bin dir.  For example:
 
    adb install ./bin/SuperCool-debug.apk


If there is more than one emulator running, you must specify the emulator upon which to install the application by its serial number, 
with the -s option. For example:

    adb -s emulator-5554 install ./bin/MainActivity-debug.apk

You get a ist of running avd's and their serials with

    adb devices



As you develop your app, you'll need to reploy to the emulator.  If you get an error saying the app is
already installed ...

    Failure [INSTALL_FAILED_ALREADY_EXISTS]

... you can try using the -r option (reinstall, keeping data)

    adb install -r ./bin/MySuperBadApp.apk

to replace it.

Or uninstall it (use the -k option to keep data and cache directories, if you want that)

    adb uninstall -k com.your.app.package.Name 

More help at http://developer.android.com/guide/developing/tools/adb.html
