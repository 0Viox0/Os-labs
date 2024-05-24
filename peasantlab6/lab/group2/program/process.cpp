#include <fstream>
#include <iostream>
#include <string>

void processFile(const std::string &filename) {
  std::fstream file(filename, std::ios::in | std::ios::out | std::ios::binary);
  if (!file) {
    std::cerr << "Error opening file: " << filename << std::endl;
    return;
  }

  // Determine the size of the file
  file.seekg(0, std::ios::end);
  std::streampos endPos = file.tellg();
  int numIntegers = endPos / sizeof(int);

  // Read each integer, double it, and append to the file
  for (int i = 0; i < numIntegers; ++i) {
    file.seekg(i * sizeof(int));
    int value;
    file.read(reinterpret_cast<char *>(&value), sizeof(int));

    int doubledValue = value * 2;
    file.seekp(0, std::ios::end); // Move to end for appending
    file.write(reinterpret_cast<char *>(&doubledValue), sizeof(int));
  }

  file.close();
}

int main(int argc, char *argv[]) {

  if (argc != 2) {
    std::cerr << "Usage: " << argv[0] << " <number_of_files>" << std::endl;
    return 1;
  }

  int fileNum = std::atoi(argv[1]);
  if (fileNum < 0) {
    std::cerr << "The number of files should be a positive integer."
              << std::endl;
    return 1;
  }

  // Generate 20 files, each 10 MB
  const int numFiles = 20;
  const int fileSizeMB = 10;

  std::string filename = "../files/file" + std::to_string(fileNum) + ".dat";
  processFile(filename);

  return 0;
}
