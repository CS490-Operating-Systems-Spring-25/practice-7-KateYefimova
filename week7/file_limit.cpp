#include <iostream>
#include <fstream>
#include <vector>
#include <thread>
#include <chrono>

int main() {
    const int totalFiles = 100000;  
    const int batchSize = 1000;     
    std::vector<std::ofstream> files; 

    for (int batch = 0; batch < totalFiles / batchSize; ++batch) {

        for (int i = 0; i < batchSize; ++i) {
            std::string fileName = "file_" + std::to_string(batch * batchSize + i) + ".txt";
            files.emplace_back(fileName);

            if (!files.back().is_open()) {
                std::cerr << "Error: Failed to open file " << fileName << std::endl;
                return 1; 
            }

            files.back() << "This is file number " << (batch * batchSize + i) << std::endl;
        }

        std::this_thread::sleep_for(std::chrono::seconds(1)); 

        files.clear();
    }

    std::cout << "Finished creating " << totalFiles << " files." << std::endl;
    return 0;
}
