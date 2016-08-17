This is a modified version of the [Kinetic PreProcessor][1] used at the Aerosol Physics laboratory of the Tampere University of Technology. It is used to simulate chemical gas-phase processes of volatile organic compounds with [Master Chemical Mechanism][2] and Matlab on Linux. At the moment it works using the 2010b version of Matlab but at least the 2014b version gives some errors.

[The KPP user manual][3] contains more information about KPP as well as the following installation instructions.

## Installing KPP

1. Download these files to your computer, for example to folder $HOME/kpp.

2. Define $KPP_HOME environment variable and add the path to the KPP executable. We assume the files are in $HOME/kpp.

   If using C shell edit file $HOME/.cshrc and add:  
   
   setenv KPP_HOME $HOME/kpp  
   setenv PATH $PATH:$KPP_HOME/bin

   If using the bash shell, edit $HOME/.bashrc and add:
   
   export KPP_HOME=$HOME/kpp  
   export PATH=$PATH:$KPP_HOME/bin

    Restart shell to make sure changes are in effect.

3. Make sure you have sed installed on your computer (type `which sed`). If not install sed using command:

   `sudo apt-get install sed`

4. In the same way, make sure you have yacc installed. If not install it using command:

   `sudo apt-get install bison`

5. Type "flex --version" to make sure you have flex installed on your computer. If not install it using the command:

   `sudo apt-get install flex`

   Find out the exact path name of the flex library. The library is called either libfl.a or libfl.sh. You will need this pathname later.

6. Go to the KPP directory:

   `cd $KPP_HOME`

7. Clean the KPP installation:

   `make clean`

   Delete the KPP executable:

   `make distclean`

8. Edit the Makefile.defs file. You will need to add the path to the flex library here. For me it was /usr/lib/x86_64-linux-gnu (Ubuntu 16.04).

9. Build the KPP executable:

   `make`

   This should create an executable file under $HOME/kpp called kpp.

   You may test that KPP works with the chemistry models in the examples folder. Copy one made for Matlab, such as small_m.kpp, to the same folder where the kpp executable file is. Open terminal, go to the directory with the the executable file and the .kpp file and generate code for the model with command:

   `./kpp small_m.kpp`

   You should get a message saying 'KPP has succesfully created the model "small_m".' There should be several Matlab-files in the folder now and you can run small_m_Main.m to test that the model works. You might have to tweak the generated code a little bit.


[1]: http://people.cs.vt.edu/~asandu/Software/Kpp/
[2]: http://mcm.leeds.ac.uk/MCM/
[3]: https://github.com/kangasno/TUT-MCM-KPP
