sshtools
========

Just a little fun with SSH and BASH!!!!

I have the need to automate some common ssh tasks such as :


    * generating client keys and adding those keys to a server
    * ssh to vnc
    * vnc to another computer connected to my ssh server
    * bind local machine ports to remote machine ports
    * setup SSH Tunnel to remote and proxy all traffic to avoid coffeeshop snoops
    

I'll be adding some simple bash scripts to this repository to accomplish the above. The first script I've completed is the ssh to vnc.

_Note : all scripts assume Mac OSX 10.7x environment. The specific programs used can be easily swapped out and you should be able to run in any other POSIX environment (give or take some caveats)._

generate keys
==============

simple one liner (hey, I'm lazy and forgetful!!!!) that uses the `ssh-keygen` command to automagically generate a 4096 byte RSA key. It will take you through the normal prompts for location and password. Afterwards you'll have some keys that will need copying...onto the next step!!!!

copy keys
==========

This will make a temp file with your public key and set correct permissions then copy it to the remote machine.

_Make sure that `password auth` is `ON` in the remote machine's SSH configuration for this to work_

Once executed you'll be asked for the `IP` and `SSH PORT` of the remote system. If successfull it will prompt you for password on remote system, after authenticating it will copy your key into your `~/.ssh/` directory as you normally would.

Now you can turn off password off on the remote computer's `ssh_config` and start enjoying passwordless entry:)

coffee shop proxy
=================

This is for those times when your out on the public open wifi and need a secure tunnel to your private box so John Q Wireshark
sitting a few tables away from you isn't able to snatch your bits in plain text, nah mean?!?!

This one uses AUTOSSH, which is great because it will automagically reconnect you if your connection goes down. Install if from
source from [HERE](http://www.harding.motd.ca/autossh/). Just follow the instuction to build it from source...because its more
fun that way!

####Config :
- IP Address (what address to connect to)
- Port (what port to connect to)
- Username (what username to use)
- Monitor Port (autossh)
- Proxy Port (your proxy port)


The script will ask you for a monitor port that AUTOSSH will use to make sure your SSH tunnel stays up and running, and if its not
then it will restart itself for you. Default is 20000.

It will also ask you for a Proxy port. This is the port that your proxy will be listening on. Ussually you'll bind to your loopback
on said port and this will be where the tunnel is setup to your private box. Make sure to set this up either before or after running
this script to ensure your traffic can be tunnelled.

####Note :

Will default to `vvv` Verbosity for SSH. This is the max setting for most verbose output.

Why? Becuause its fun to see those pipes keep filling and draining...

bindAddress
===========

Use this script if you need to bind local ports to remote ports _i.e._ `local_port:HOST:remote_port`

This is the same method used below when tunneling vnc through ssh. The local port `5905` is bound to remote port `5900` on the loopback so you can simply VNC like `127.0.0.1:5905`. Since your local port `5905` is bound to remote port `5900` any traffic you send or receive on local `5905` will be forwarded to/from the remote `5900` port. So in the case of VNC you will receive the `remote frame buffer` by pointing your VNC viewer to `127.0.0.1:5905`

###usage

I use this as a quick way to connect to my `couchdb` instance running on my remote machine. So I can just bind local port `3000` to remote `5984` (couchdb default port) and then just point my browser to `localhost:3000` to connect and administrate my `couchdb`.


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

- reverse ssh tunnel to ssh server client1 script
- client2 ssh to client1 ssh tunnel script (to be able to vnc to client1)

license
======

MIT
