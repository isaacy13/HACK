// ISAAC YEANG : 727008477
// CSCE 312 - 200
#include <iostream>
#include <string.h>

std::string inst_A(const std::string& input) {
    size_t ans = 0;
    size_t factor = 16384;
    for(size_t i = 1; i < input.length(); i++) {
        if (input.at(i) == '1') {ans += factor;}
        factor /= 2;
    }

    return ('@' + std::to_string(ans));
}

std::string inst_C(const std::string& input) {
    bool isA = true;
    if (input.at(3) == '1')
        isA = false;
    
    std::string c = input.substr(4, 6);
    if(c == "101010")
        c = "0";
    else if (c == "111111")
        c = "1";
    else if (c == "111010")
        c = "-1";
    else if (c == "001100")
        c = "D";
    else if (c == "110000") {
        if (isA)
            c = "A";
        else
            c = "M";
    }
    else if (c == "001101")
        c = "!D";
    else if (c == "110001") {
        if (isA)
            c = "!A";
        else
            c = "!M";
    }
    else if (c == "001111")
        c = "-D";
    else if (c == "110011") {
        if (isA)
            c = "-A";
        else
            c = "-M";
    }
    else if (c == "011111")
        c = "D+1";
    else if (c == "110111") {
        if (isA)
            c = "A+1";
        else
            c = "M+1";
    }
    else if (c == "001110")
        c = "D-1";
    else if (c == "110010") {
        if (isA)
            c = "A-1";
        else
            c = "M-1";
    }
    else if(c == "000010") {
        if (isA)
            c = "D+A";
        else
            c = "D+M";
    }
    else if (c == "010011") {
        if (isA)
            c = "D-A";
        else
            c = "D-M";
    }
    else if (c == "000111") {
        if (isA)
            c = "A-D";
        else
            c = "M-D";
    }
    else if(c == "000000") {
        if (isA)
            c = "D&A";
        else
            c = "D&M";
    }
    else if(c == "010101") {
        if (isA)
            c = "D|A";
        else
            c = "D|M";
    } else { return "ERROR: illegal HACK instruction"; }

    std::string d = input.substr(10, 3);
    if (d == "000")
        d = "nullptr";
    else if (d == "001")
        d = "M";
    else if (d == "010")
        d = "D";
    else if (d == "011")
        d = "MD";
    else if (d == "100")
        d = "A";
    else if (d == "101")
        d = "AM";
    else if (d == "110")
        d = "AD";
    else { return "ERROR: illegal HACK instruction"; }

    std::string j = input.substr(13, 3);
    if (j == "000")
        j = "nullptr";
    else if (j == "001")
        j = "JGT";
    else if (j == "010")
        j = "JEQ";
    else if (j == "011")
        j = "JGE";
    else if (j == "100")
        j = "JLT";
    else if (j == "101")
        j = "JNE";
    else if (j == "110")
        j = "JLE";
    else if (j == "111")
        j = "JMP";
    else return "ERROR: illegal HACK instruction";

    std::string ans = "";
    if(d == "nullptr") {
        return (c+';'+j);
    }
    else if(j == "nullptr") {
        return (d+'='+c);
    }
    else {
        return (d+'='+c+';'+j);
    }
    
}

std::string Disassembler(std::string input) {
    if (input.empty())
        return "ERROR: illegal HACK instruction";

    if (input.length() != 16)
        return "ERROR: instruction bit size not 16";

    for(size_t i = 0; i < input.size(); i++)
        if(input.at(i) != '0' && input.at(i) != '1')
            return "ERROR: illegal HACK instruction";

    std::string ans = "";
    // A-instruct
    if (input.at(0) == '0') {ans = inst_A(input);} 
    
    // C-instruct
    else if(input.substr(0, 3) == "111") {ans = inst_C(input);}

    else {ans = "ERROR: illegal HACK instruction"; }

    return ans;
}

int main() {
    std::string in = "";
    while(true) {
        std::getline(std::cin, in);
        if (in == "EOF")
            break;
        std::string s = Disassembler(in);
        std::cout << s << std::endl;
        if (s == "ERROR: illegal HACK instruction" || s == "ERROR: instruction bit size not 16")
            break;
    }
}