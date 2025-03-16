#include <iostream>
#include <fstream>
#include <vector>

int main() {
    std::vector<std::ofstream> files;
    int numFiles = 5; 

    for (int i = 0; i < numFiles; ++i) {
        std::string fileName = "file_" + std::to_string(i) + ".txt";
        files.emplace_back(fileName);
        
        if (!files.back().is_open()) {
            std::cerr << "Error opening file: " << fileName << std::endl;
            return 1;
        }

        files.back() << "This is file number " << i << std::endl;
    }    
    return 0;
}
