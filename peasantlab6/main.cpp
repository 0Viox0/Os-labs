#include <chrono>
#include <cmath>
#include <iomanip>
#include <iostream>

using namespace std;

// perfect values: 10000 13000
// to            : 10000 13100

double riemann_zeta(int num_terms, int precision) {
    double zeta = 1.0;
    double term, p;

    for (int n = 2; n <= num_terms; n++) {
        term = 0.0;
        p = 1.0;

        for (int k = 1; k <= precision; k++) {
            p *= pow(n, -1.0 / k);
            term += p / k;
        }

        zeta *= (1.0 + term);
    }

    return zeta;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        cout << "Usage: " << argv[0] << " <num_terms> <precision>" << endl;
        return 1;
    }

    int num_terms = stoi(argv[1]);
    int precision = stoi(argv[2]);

    auto start = chrono::high_resolution_clock::now();
    double zeta = riemann_zeta(num_terms, precision);
    auto end = chrono::high_resolution_clock::now();

    cout << setprecision(15) << zeta << endl;
    cout << "Execution time: "
         << chrono::duration_cast<chrono::milliseconds>(end - start).count()
         << " ms" << endl;

    return 0;
}
