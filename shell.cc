#include "shell.hh"

using namespace std;

void new_file()
{
    mode_t mode = S_IRWXU | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;
    string fname;
    cout << "File name: ";
    getline(cin, fname);

    const char *fileName = fname.c_str();
    syscall(SYS_creat, fileName, mode);

    string getText;
    cout << "Content of " << fname << ": ";
    getline(cin, getText);

    const char *fBody = getText.c_str();

    int fd = syscall(SYS_open, fileName, O_RDWR, 0755);
    syscall(SYS_write, fd, fBody, getText.length());

    close(fd);

}

void list()
{
    int pid = syscall(SYS_fork);

    if(pid == 0){
        char* args[] =  { (char*) "ls", (char*)"-la", 0};
	    execv("/bin/ls", args);

    } else if (pid > 0)
    {
        int wstatus;
        wait(&wstatus);
    }

}

void find()
{
    string query;
    pid_t pid;
    int pipefd[2];
    int status;
    int retu;

    cout << "Search query: ";
    getline(cin, query);



	retu = pipe(pipefd);

	if (retu == -1)
	{
		perror("pipe");
		exit(1);
	}

	pid = fork();

	if (pid == 0)
	{
        char* args[] = {(char*)"find", (char*)"./", 0};
		close(pipefd[0]);
		dup2(pipefd[1], STDOUT_FILENO);

		execv("/usr/bin/find", args);

	} else if (pid > 0)
    {
        int wstatus;
        wait(&wstatus);

    }

	pid = fork();

	if (pid == 0)
	{
        const char *findFile = query.c_str();
        char* args[] = {(char*)"grep", (char*)findFile, 0};
		close(pipefd[1]);
		dup2(pipefd[0], STDIN_FILENO);

		execv("/bin/grep", args);

	} else if (pid > 0)
    {
        int wstatus;
        wait(&wstatus);

    }

	close(pipefd[0]);
	close(pipefd[1]);

}

void python()
{
    pid_t pid;
    pid = fork();
    if(pid == 0){
        char* args[] = {(char*)"python", 0};
        execv("/usr/bin/python", args);
    }else{
        int wstatus;
        wait(&wstatus);
    }
}


int main()
{
    cout << "Vvamp's interactive shell -- EOS 2019" << endl;

    string input;

	vector<char> buff{ };
	buff.resize(512);

	int fd = syscall(SYS_open, "prompt.txt", O_RDONLY, 0755);
	ssize_t rfile = read(fd, buff.data(), 512);
	string prompt(buff.begin(), buff.end());
    while (true)
    {
        cout << prompt;
        getline(cin, input);

        if (input == "new_file")
        {
            new_file();
        }else if (input == "ls")
        {
            list();
        }else if (input == "find")
        {
            find();
        }else if (input == "python")
        {
            python();
        }else if (input == "quit" || input == "exit")
        {
            return 0;
        }else if (input == "error")
        {
            return 1;
        }else{
            cout << "Unknown command." << endl;
        }
    }
}
