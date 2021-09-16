// ISAAC YEANG : 727008477
// CSCE 312 - 200
#include <iostream>
#include <string.h>
#include <map>
#include <vector>

std::map<std::string, std::string> symbolTable = {{"R0", "0"},
                                                  {"R1", "1"},
                                                  {"R2", "2"},
                                                  {"R3", "3"},
                                                  {"R4", "4"},
                                                  {"R5", "5"},
                                                  {"R6", "6"},
                                                  {"R7", "7"},
                                                  {"R8", "8"},
                                                  {"R9", "9"},
                                                  {"R10", "10"},
                                                  {"R11", "11"},
                                                  {"R12", "12"},
                                                  {"R13", "13"},
                                                  {"R14", "14"},
                                                  {"R15", "15"},
                                                  {"SP", "0"},
                                                  {"LCL", "1"},
                                                  {"ARG", "2"},
                                                  {"THIS", "3"},
                                                  {"THAT", "4"},
                                                  {"SCREEN", "16384"},
                                                  {"KBD", "24576"}};
size_t symbolTableIndex = 16;
size_t instruct_num = 0;

std::string inst_A(std::string& input) {
    std::string ans = "";
    ans.push_back('0');
        std::string str_num = "";
        for (size_t i = 1; i < input.length(); i++) {
            str_num.push_back(input.at(i));
        }
        size_t num = std::stoi(str_num);
        if (num > 32767)
            return "";
        size_t curr = 16384;
        while(num > 0) {
            if (curr <= num) {
                ans.push_back('1');
                num -= curr;
                curr /= 2;
            }

            else {
                ans.push_back('0');
                curr /= 2;
            }
        }

        while (ans.length() < 16){ ans.push_back('0'); }

    return ans;
}

std::string inst_C(std::string& input) {
    std::string ans = "";
    // can be normal C-instruct or jmp
        ans.append("111");
        char write = 'd';
        for (size_t i = 0; i < input.length(); i++) {
            if (input.at(i) == ';' || input.at(i) == '&' || input.at(i) == '|') {
                write = 'c';
                break;
            } else if (input.at(i) == '=')
                break;
        }
        std::string dest = "";
        std::string jmp = "";
        std::string comp = "";
        for (size_t i = 0; i < input.length(); i++) {
            if (input.at(i) == ';') {
                if (write == 'j')
                    return "ERROR: end of line expected but semicolon is found";
                write = 'j';
            } 
            else if (input.at(i) == '=') {write = 'c';} 
            else if (write == 'd') { dest.push_back(input.at(i)); } 
            else if (write == 'j') { jmp.push_back(input.at(i)); } 
            else if (write == 'c') { comp.push_back(input.at(i)); }
        }

        if ((comp.empty() && !jmp.empty()) || (!dest.empty() && comp.empty()))
            return "ERROR: expression expected";

        if (comp.find('M') != std::string::npos)
            ans.push_back('1');
        else
            ans.push_back('0');

        if (comp.length() == 1){
            char c = comp.at(0);
            switch(c) {
                case '0':   ans.append("101010");
                            break;
                case '1':   ans.append("111111");
                            break;
                case 'D':   ans.append("001100");
                            break;
                case 'A':   
                case 'M':
                            ans.append("110000");
                            break;
                            
            }
        }

        else if (comp.length() == 2) {
            std::string c = comp.substr(0, 2);
            if (c == "-1")
               ans.append("111010");
            else if(c == "!D")
                ans.append("001101");
            else if(c == "!A" || c == "!M")
                ans.append("110001");
            else if(c == "-D")
                ans.append("001111");
            else if(c == "-A" || c == "-M")
                ans.append("110011");
        }

        else {
            if (comp == "D+1" || comp == "1+D")
                ans.append("011111");
            else if (comp == "A+1" || comp == "M+1"
                    || comp == "1+A" || comp == "1+M")
                ans.append("110111");
            else if (comp == "D-1" || comp == "-1+D")
                ans.append("001110");
            else if (comp == "A-1" || comp == "M-1"
                    || comp == "-1+D" || comp == "-1+M")
                ans.append("110010");
            else if (comp == "D+A" || comp == "D+M"
                    || comp == "A+D" || comp == "M+D")
                ans.append("000010");
            else if (comp == "D-A" || comp == "D-M"
                    || comp == "-A+D" || comp == "-M+D")
                ans.append("010011");
            else if (comp == "A-D" || comp == "M-D"
                    || comp == "-D+A" || comp == "-D+M")
                ans.append("000111");
            else if (comp == "D&A" || comp == "D&M"
                    || comp == "A&D" || comp == "M&D")
                ans.append("000000");
            else if (comp == "D|A" || comp == "D|M"
                    || comp == "A|D" || comp == "M|D")
                ans.append("010101");
        }

        if (dest.empty())
            ans.append("000");
        else if (dest.length() == 1) {
            char c = dest.at(0);
            if (c == 'M')
                ans.append("001");
            else if (c == 'D')
                ans.append("010");
            else if (c == 'A')
                ans.append("100");
        } else {
            if (dest == "MD")
                ans.append("011");
            else if (dest == "AM")
                ans.append("101");
            else if (dest == "AD")
                ans.append("110");
        }

        if (jmp.empty())
            ans.append("000");
        else if (jmp == "JGT")
            ans.append("001");
        else if (jmp == "JEQ")
            ans.append("010");
        else if (jmp == "JGE")
            ans.append("011");
        else if (jmp == "JLT")
            ans.append("100");
        else if (jmp == "JNE")
            ans.append("101");
        else if (jmp == "JLE")
            ans.append("110");
        else if (jmp == "JMP")
            ans.append("111");
    return ans;
}

std::string BasicAssembler(std::string input) {
    std::string ans = "";
    // A-instruct
    if (input.at(0) == '@') {
        if (!(input.size() == 2 && input.at(1) == ';')) {
            if (input.size() > 0 && input.find(';') != std::string::npos)
                return "ERROR: end of line expected but semicolon is found";
        }
        if (input.at(1) != '0' && input.at(1) != '1'
            && input.at(1) != '2' && input.at(1) != '3'
            && input.at(1) != '4' && input.at(1) != '5'
            && input.at(1) != '6' && input.at(1) != '7'
            && input.at(1) != '8' && input.at(1) != '9') { // symbol
            std::string name = input.substr(1, input.length()-1);
            std::map<std::string, std::string>::iterator result = symbolTable.find(name);
            std::string instruct = "@";
            if(result == symbolTable.end()) {
                std::string index = std::to_string(symbolTableIndex);
                symbolTable.insert(std::pair<std::string, std::string>(name, index));
                symbolTableIndex++;
                instruct.append(index);
            }
            else {
                instruct.append(result->second);
            }

            ans = inst_A(instruct);
        }

        else
            ans = inst_A(input);
    } 

    // C-instruct
    else {
        size_t count = 0;
        for (size_t i = 0; i < input.size(); i++)
            if (input.at(i) == ';')
                count++;
        if (count > 1)
            return "ERROR: end of line expected but semicolon is found";
        ans = inst_C(input);
        instruct_num++;
    }

    return ans;
}

void cleanInput(std::string& input) {
    // caps
    for (size_t i = 0; i < input.length(); i++)
        input.at(i) = std::toupper(input.at(i));

    // trim
    while(true) {
        size_t iter = 0;
        size_t i = input.find('\t');
        if (i == std::string::npos)
            i = input.find('\r');

        if (i == std::string::npos)
            i = input.find('\n');

        if (i == std::string::npos)
            i = input.find(' ');
        
        if (i == std::string::npos)
            break;

        while(i+iter < input.length() && (input.at(i+iter) == ' ' || input.at(i+iter) == '\t' || input.at(i+iter) == '\r' || input.at(i+iter) == '\n')) { iter++; }
        input.erase(i, iter);
    }

    // remove all comments from code
    while(true) {
        size_t index = input.find("//");
        if (index == std::string::npos)
            break;
        size_t iter = input.length() - index;
        input.erase(index, iter);
    }
}

int main() {
    std::string in = "";
    std::vector<std::string> lines;
    bool foundBadLabel = false;
    while(true) {
        std::getline(std::cin, in);
        cleanInput(in);
        if (in.empty())
            continue;
        if (size_t index = in.find(';') != std::string::npos) {
            if ((index == 0 || index == in.size()-1) 
            || ((in.at(index-1) != '0' && in.at(index-1) != '1' && in.at(index-1) != 'D' && in.at(index-1) != 'A' && in.at(index-1) != 'M')
            && (in.at(index+1) != 'J'))) {
                std::string s = BasicAssembler(in);
                if (s == "ERROR: expression expected" || s == "ERROR: end of line expected but semicolon is found") {
                    std::cout << "ERROR: end of line expected but semicolon is found" << std::endl;
                    exit(0);
                }
            }
        }
        if (in.at(0) == '(') {
            if (in.find(';') != std::string::npos) {
                lines.push_back("@dummy");
                lines.push_back("EOF");
                foundBadLabel = true;
                break;
            }
            // label
            std::string name = in.substr(1, in.length()-2);
            symbolTable.insert(std::pair<std::string, std::string>(name, std::to_string(instruct_num)));
        } else { // A-instruct, C-instruct, variable
            lines.push_back(in);
            instruct_num++;
        }
        if (in == "EOF")
            break;
    }

    for (size_t i = 0; i < lines.size()-1; i++) {
        std::string s = BasicAssembler(lines.at(i));
        if (foundBadLabel)
            s = "ERROR: end of line expected but semicolon is found";
        std::cout << s << std::endl;
        if (s == "ERROR: expression expected")
            break;
        else if (s == "ERROR: end of line expected but semicolon is found")
            break;
    }
}