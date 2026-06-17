#include <iostream>
#include <vector>
#include <iomanip> // Для std::setprecision
#include <limits>  // Для std::numeric_limits
#include <clocale>

using namespace std;
void inputMatrix(vector<vector<double>>& matrix, int n) {
    cout << "Введите коэффициенты матрицы (размер " << n << "x" << n << "):\n";
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            while (true) {
                cout << "Элемент [" << i + 1 << "][" << j + 1 << "]: ";
                cin >> matrix[i][j];
                if (cin.fail()) {
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');
                    cout << "Ошибка ввода! Пожалуйста, введите число.";
                }
                else {
                    break;
                }
            }
        }
    }
    cout << "Введите свободные члены (размер " << n << "):\n";
    for (int i = 0; i < n; i++) {
        while (true) {
            cout << "Свободный член [" << i + 1 << "]: ";
            cin >> matrix[i][n];
            if (cin.fail()) {
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');
                cout << "Ошибка ввода! Пожалуйста, введите число.";
            }
            else {
                break;
            }
        }
    }
}
void gaussJordan(vector<vector<double>>& matrix, int n) {
    for (int i = 0; i < n; i++) {
        double pivot = matrix[i][i];
        for (int j = 0; j <= n; j++) {
            matrix[i][j] /= pivot;
        }
        for (int k = 0; k < n; k++) {
            if (k != i) {
                double factor = matrix[k][i];
                for (int j = 0; j <= n; j++) {
                    matrix[k][j] -= factor * matrix[i][j];
                }
            }
        }
    }
}
void printSolution(const vector<vector<double>>& matrix, int n) {
    cout << "Решение системы:\n";
    for (int i = 0; i < n; i++) {
        cout << "x" << i + 1 << " = " << setprecision(6) << fixed << matrix[i][n];
    }
}

int main() {
    setlocale(LC_ALL, "rus");
    int n;
    cout << "Введите количество уравнений (размерность системы): ";
    while (true) {
        cin >> n;
        if (cin.fail() || n <= 0) {
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            cout << "Ошибка ввода! введите положительное целое число.";
        }
        else {
            break;
        }
    }
    vector<vector<double>> matrix(n, vector<double>(n + 1));
    inputMatrix(matrix, n);
    gaussJordan(matrix, n);
    printSolution(matrix, n);
    return 0;
}
