1.  Command
    command [options] [arguments] < input > output
    1.1 options convention
        a,  short  
            ls -a
            tar -cvf backup.tar /home/xxxx
        b,  long options 
            ls --hide
            python --version
    1.2 input and output redirection

2,  How to connect commands
   2.1  Pipeline   
        A | B | C 
   2.2  Sequential
        A; B; C;
   2.3  A && B  ( do both) 
   2.4  A || B  ( do B if A failed)
   2.5 command subsititution
       echo "num $(ls -l | wc) , data $(date)"
       echo "$(A) xxx $(B)"

3,  moving around in File system
  3.1  brace expansion  {1,2,3} , {A..Z..1}, {A, B, C}-{1..2}
  3.2  wildcard in File system commands
        ? ,  . , *
  3.2  xargs
  
4, Variables
  4.1 Enviroment variables
      $SHELL
      $BASH
      $BASH_VERSION
      $PATH
      $PS1
      $HOME
 
  4.2 Shell variables
  4.3 Local variables

5, config your own Bash
  5.1 bash configuration files
      ~/.bashrc ~/.bash_profile
  5.1  setting your prompt
      change PS1 enviroment
  5.2  adding enviroment variables
     PATH=$PATH:/user/xxx/mybin; export PATH
 
6, Bash function

7, System info
   7.1 uname
   7.2 cpuinfo
   7.3 free
   7.4 df
   7.5 ifconfig
   7.6
