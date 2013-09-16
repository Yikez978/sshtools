sshtools
========

Just a little fun with SSH and BASH!!!!

I have the need to automate some common ssh tasks such as :


    generating client keys and adding those keys to a server
    ssh to vnc
    vnc to another computer connected to my ssh server

I'll be adding some simple bash scripts to this repository to accomplish the above. The first script I've completed is the ssh to vnc.

_Note : all scripts assume Mac OSX 10.7x environment. The specific programs used can be easily swapped out and you should be able to run in any other POSIX environment (give or take some caveats)._

sshToVnc
========

Automates the connection and port forwarding of the ssh session. Then runs apple screen sharing as vnc viewer. 

Will make note of both ssh and vnc view PIDS as they are created and wait for user to close the vnc viewer. Once vnc viewer is closed the script will then kill the ssh session as a clean up and will print and exit with the result of the kill command.

Caveats :

- requires key authentication for ssh (will not work if you have password auth!)
- assumes screen sharing for vnc viewer (can be easily changed in 2 lines)
- assumes VNC server listening port to be 5900
- uses 5905 for ssh port forwarding and binds it to 5900 on server side

Nice and simple!

todo
====

- gen key script
- add keys to server script
- reverse ssh tunnel to ssh server client1 script
- client2 ssh to client1 ssh tunnel script (to be able to vnc to client1)

license
======

MIT
