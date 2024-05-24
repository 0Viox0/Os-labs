#include <fstream>
#include <iostream>
#include <string>

void generateFile(const std::string &filename, int sizeMB) {
  std::ofstream outFile("../files/" + filename, std::ios::binary);
  if (!outFile) {
    std::cerr << "Error creating file: " << filename << std::endl;
    return;
  }

  int numIntegers = sizeMB * 1024 * 1024 / sizeof(int);
  for (int i = 0; i < numIntegers; ++i) {
    int value = i + 1; // Just an example, use any sequence you like
    outFile.write(reinterpret_cast<char *>(&value), sizeof(int));
  }

  outFile.close();
}

int main() {
  const int numFiles = 20;
  const int fileSizeMB = 2;

  for (int i = 0; i < numFiles; ++i) {
    std::string filename = "file" + std::to_string(i) + ".dat";
    generateFile(filename, fileSizeMB);
  }

  return 0;
}
