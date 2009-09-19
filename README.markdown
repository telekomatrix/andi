# andi
  
by James Britt /  Neurogami

[www.neurogami.com](http://www.neurogami.com)

## DESCRIPTION:

Helper app to create Android project stuff

## FEATURES/PROBLEMS:

Still evolving, but core behavior is to aid in creating project files

One part is in wrapping calls to the Android SDK command-line tools.

For example, you can create a new project using the `android` command.  However, you need to know and use a cumbersome number of parameters.  (Run `android` with no args to see the length help output).

Most of the time you are going to be using many of the same values.  The same package name, the same target, the same name for your main activity.  Might as well stash that in a config file.


The other likely role for Andi is to emit useful templates for assorted code and resources.  For example, you may want an About screen in your app.  They all tend to look the same, so might as well automate that.


##  SYNOPSIS:

Whenever this becomes a gem:

    sudo gem i Neurogami-andi

Create `andi.yaml` in your $HOME dir.  This is the config file for your prefered default values:

    target: 4
    base_package: com.neurogami
    main_activity: MainAction

Run the help option:

      $ andi -h
      Usage: ruby /usr/local/bin/andi [options] 

      Options:
          -t, --target INT                 Android target. Default is 4
          -b, --base_package BASE_PACKAGE  Base package name (e.g. com.neurogami). Default is com.neurogami
          -p, --project_name PROJECTNAME   Project name (e.g. MyCoolApp). Required.
          -?, -h, --help                   Show this message.

If you've sufficient defaults then you need only pass the name of the project; you can override the defaults on the command likne if you like.

     $ andi -p myCoolApp

     $ andi -p myCoolApp -t 1

     $ andi -p myCoolApp -t 2 -b com.example



##  REQUIREMENTS:

* The User-Choices gem

##  INSTALL:

Whenever this becomes a gem:

    sudo gem i Neurogami-andi

or grab from git.

##  LICENSE:

(The MIT License)

Copyright (c) 2009 James Britt /Neurogami

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
