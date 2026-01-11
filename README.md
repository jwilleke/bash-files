# Bash Files

## Shell Initialization Files

Bash, and most other shells, can be started as a login shell or as a non-login shell. One of the most significant differences between the two modes is the Shell Initialization Files executed when Bash starts up.

First, we need to get the terminology right, or at least we need to agree on the termonaology we are using here. These are our explainations as we understand them:

## login shell

A login shell is one whose first character of argument zero is a -, or one started with the --login option. You can determine if the shell is a login shell by:

```bash
echo $0
-bash
```

As "-bash" has the first character is "-", this is a login shell.

When a login shell exits, bash reads and executes commands from the file ~/.bash_logout, if it exists.

## non-login shell

A login shell is one whose first character of argument zero is NOT an -.

## interactive shell

An interactive shell is one started without non-option arguments and without the -c option whose standard input and error are both connected to terminals (as determined by isatty(3)), or one started with the -i option.

The interactive shell is used when you open a terminal session.

You can determine if the shell is interactive if the variable "-" includes an "i".

```bash
echo $-
himBH
```

As "himBH" includes the character "i", this is an interactive shell.

Typically the environment variable PS1 (the primary prompt string) is set when using an interactive shell.

A interactive login shell is exited by 'logout'. Typing 'exit' in a login shell will run 'logout'.

To prevent bash from running the interactive login shell scripts when it is invoked as a interactive login shell you can use the :

```bash
bash --noprofile
```

## non-interactive shell

When bash is started non-interactively, to run a shell script, for example, it looks for the variable BASH_ENV in the environment, expands its value if it appears there, and uses the expanded value as the name of a file to read and execute.

When you run a shell script, a new non-interactive shell is launched to execute the script. The new shell is a non-interactive shell.

You can determine if the shell is interactive if the variable "-" does NOT includes an "i".

A non-interactive shell is exited by 'exit'

To prevent bash from running the non-interactive shell scripts when it is invoked as a interactive login shell you can use the:

```bash
bash --norc
```

## Order of Execution

Login shells, regardless of if they are interactive or non-interactive, read ~/.profile and interactive shells read ~/.bashrc.

Often you will see that /etc/profile sources ~/.bashrc - thus all settings imade in [~/.bashrc] will also take effect in a login shell.

The order of execution of the initialization scipts for a shell is dependent on if the shell is interactive or non-interactive and not related to if it is a login script or not.

When bash is invoked as an interactive login shell, or as a non-interactive login shell with the --login option, it reads and executes commands from the [/etc/profile]. Then Bash will then try in order to execute ONLY the first file exists and is readable of the following:

- [~/.bash_profile]
- [~/.bash_login]
- [~/.profile]

If one of these files is found but can not be read, it will error. There is no error if none are found.

## Where to put what

The key to remember is that all of the shells will execute the /etc/bashrc and ~/.bashrc files. Generally no settings in the /etc/bashrc and ~/.bashrc files should interact with the console. This implies none of the following:

- prompt settings
- color changes or highlighting

You can test if your shell is "clean" to test if your remote-shell connection is clean is to try something like this (use ssh or rsh, as appropriate):

```bash
ssh remotesystem /bin/true > test.dat
```

This should create a file called test.dat with nothing in it. If test.dat is not of zero length then your shell is not clean.
Look at the contents of test.dat to see what was sent. Look at all the shell initialization files on remotesystem to try and find the problem.

---

The --noprofile option may be used when the shell is started to inhibit this behavior.

A login shell is one whose first character of argument zero is a -, or one started with the --login option.

An interactive shell is one started without non-option arguments and without the -c option whose standard input and error are both connected to terminals (as determined by isatty(3)), or one started with the -i option. PS1 is set and \$- includes i if bash is interactive, allowing a shell script or a startup file to test this state.

Ever wondered what's the difference between ~/.bashrc, ~/.bash_profile, ~/.profile, /etc/profile, /etc/bash.bashrc (and maybe others) and what their purposes are? I do. [1]

Some interesting excerpts from the bash manpage:

When bash is invoked as an interactive login shell, or as a non-interactive shell with the --login option, it first reads and executes commands from the files in order: (if theu exist of course)

- /etc/profile, if that file exists. After reading that file, it looks for
- ~/.bash_profile
- ~/.bash_login
- ~/.profile

The --noprofile option may be used when the shell is started to inhibit this behavior.

When an interactive shell that is not a login shell is started, bash reads and executes commands from

- /etc/bash.bashrc and
- ~/.bashrc

This may be inhibited by using the --norc option.

The --rcfile file option will force bash to read and execute commands from the specified file instead of /etc/bash.bashrc and ~/.bashrc.

As far as I understand, a login shell means a session where you log in to the system and directly end up in Bash, like a remote ssh session or logging in through a non-graphical text terminal.

A non-login shell is then the type of shells you open after logging in: typically in a graphical session when you open a new terminal window.

How I think things are supposed to work (for a typical setup):

! /etc/profile
The /etc/profile file is not related to Bash and is setting that should be applied to:

- all users
- all interactive login shells
- all non-interactive shell
- Typically, the /etc/profile should not be modified and maybe replaced when the OS is upgraded.
- Often the /etc/profile determines which shell is running and sources the appropriate files to run next.
- On SLES, the /etc/profile sources the [/etc/bashrc] if using Bash
- on OS X, 10.6.6, the /etc/profile sources the [/etc/bashrc] if using Bash

### /etc/bashrc

The [/etc/bashrc] file is related to Bash and is setting that should be applied to:

- all users using bash
- all interactive login shells
- all non-interactive shells
- Typically, the [/etc/bashrc] should not be modified and maybe replaced when the OS is upgraded.
- Often the [/etc/bashrc] determines which shell is running and sources the appropriate files to run next.
- On SLES, the [/etc/bashrc] determines if the shell is an interactive shell and sets some defaults like PS1.

## Individule Inirtialization Files

### ~/.profile

The .profile file is for things that are not specifically related to Bash, like environment variables PATH and friends, and items that should be available for all sessions . For example, .profile should also be loaded when starting a graphical desktop session.

### .bashrc

The .bashrc file is for the configuring the interactive Bash usage, like Bash aliases, setting your favorite editor, setting the Bash prompt, etc.

### ~/.bash_profile

.bash_profile is for making sure that both the things in : and .bashrc are loaded for login shells. For example, .bash_profile could be something simple like

- . ~/.profile
- . ~/.bashrc
  As stated in the man page excerpt above, if you would omit .bash_profile, only .profile would be loaded.

Be careful. The .profile is not run if .bash_profile exists.

the run order is:

- etc/profile
- The next file is one of the following, if one is found none of the others are run:
- ~/.bash_profile
- ~/.bash_login
- ~/.profile
- shell.

Login shells read ~/.profile and
interactive shells read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all settings made here will also take effect in a login shell.

It is recommended to make language settings in ~/.profile rather than here, since multilingual X sessions would not work properly if LANG is over-ridden in every subshell.

---

Some sources of this information:
<http://stefaanlippens.net/bashrc_and_others>

## My OS X files

### /etc/profile

```bash
# System-wide .profile for sh(1)

if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
fi

if [ "${BASH-no}" != "no" ]; then
        [ -r /etc/bashrc ] && . /etc/bashrc
fi
```

### ~/.bash_profile

```bash
. ~/.bashrc
ENV=$HOME/.bashrc
export ENV
```

<http://osxfaq.com/tips/unix-tricks/week105/monday.ws>

Bash can be started as a login shell or as a non-login shell. One of the most significant differences between the two modes is the initialisation scripts sourced when Bash starts up.

A login shell sources the login scripts:

/etc/profile
~/.bash_profile
(If ~/.bash_profile cannot be read, ~/.bash_login is sourced, and if this can't be read, ~/.profile is sourced.)

On exit a login shell sources ~/.bash_logout.

A non-login shell sources the following scripts:

/etc/bashrc
~/.bashrc
NOTE: according to the bash manual, /etc/bashrc is not sourced, but it is.

When Apple's Terminal.app starts a new terminal session it starts a Bash login shell. When X11's xterm starts a new terminal session it starts a Bash non-login shell.

When you type 'bash' at the command line a non-login shell is started.

Non-interactive shells. When you run a shell script, a new shell is launched to execute the script. The new shell is a non-interactive (non-login) shell. It does not source any scripts on startup.

A non-login shell is exited by 'exit', and a login shell by 'logout'. Typing 'exit' in a login shell will run 'logout'.

<http://osxfaq.com/tips/unix-tricks/week105/wednesday.ws>
The four different initialisation scripts (see Monday's tip) must be set up correctly to ensure shells have the correct environment.

First off, /etc/profile and /etc/bashrc are system-wide. Use these scripts to set up the environment that is common to all users. ~/.bash_profile and ~/.bashrc are specific to each user and are used to add personal settings to the environment.

Second, /etc/profile and ~/.bash_profile are sourced by login shells and therefore applied once for each terminal session. Typing 'bash' at the command line runs a non-login shell which sources /etc/bashrc and ~/.bashrc.

A good strategy is to do the following:

Use /etc/profile and ~/.bash_profile to set environment variables. Environment variables are inherited by non-login shells and don't need to be setup again.

Use /etc/bashrc and ~/.bashrc to set shell variables and other shell settings. Shell variables are not inherited by non-login shells and therefore need to be set each time.

Finally, /etc/profile should source /etc/bashrc:

source /etc/bashrc
and ~/.bash_profile should source ~/.bashrc:

source ~/.bashrc
to avoid having to set shell variables in both the login and non-login scripts. Note that these must be 'sourced' and not simply called like:

/etc/bashrc
