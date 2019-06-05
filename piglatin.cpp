#include <iostream>
#include <string>

using std::string;
using std::cout;
using std::cin;
using std::endl;

string piglatin(string text, string suffix){
    string output = text + "-" + suffix;
    return output;
}


int main(int argc, char *argv[]) {
    string suffix = "ay";
    string word;
    cout << "Enter a word to translate to pig-latin > ";
    cin >> word;
    if(argc >= 2){
        suffix=argv[1];
    }
    cout << piglatin(word, suffix) << endl;
    return 0;

 }
