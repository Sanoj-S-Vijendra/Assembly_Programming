#include <iostream>
#include <algorithm>
#include <fstream>
#include <cstdlib>
#include <queue>
#include <bits/stdc++.h>

using namespace std;

int main(int argc, char* argv[])
{
    if(argc != 4){
        cerr << "Usage: " << argv[0] << "<number of inputs> <probability of insertion> <seed>" << endl;
        exit(-1);
    }
    
    float p = stof(argv[2]);
    int seed = atoi(argv[3]);

    if(p > 1 || p < 0){
        cerr << "Probability must be between 0 and 1" << endl;
        exit(-1);
    }

    srand(seed);
    priority_queue<int> q;
    ofstream f;
    f.open("correct_output.txt");
    ofstream inp;
    inp.open("input.txt");

    f << "Enter input as <mode> <num>\n<mode> can be i (insert), d (delete), m (get max)\n<num> is required only for mode i, and represents the number to be inserted" << endl;

    for(int i = 0; i < atoi(argv[1]); ++i)
    {
        float r = (rand() % 100)/100.0;
        if(r < p)
        {   
            // insert
            int y = rand() % int(1e9);
            inp << "i " << y << endl;
            q.push(y);
            
        }
        else if(r > p && (r < (1+p)/2))
        {   
            // delete
            int y = rand() % int(1e9);
            inp << "d" << endl;
            if(q.empty()){
                f << "Heap is empty" << endl;
                continue;
            }
            int m = q.top();
            q.pop();
            f << "Popped element: " << m << endl;

        }
        else
        {   
            // max val
            int y = rand() % int(1e9);
            inp << "m" << endl;

            if(q.empty()){
                f << "Heap is empty" << endl;
                continue;
            }

            int max = q.top();
            f << "Max element: " << max << endl;
            
        }
    }
    while (!q.empty()){
        inp << "m" << endl;
        int max = q.top();
        f << "Max element: " << max << endl;
        inp << "d" << endl;
        int m = q.top();
        q.pop();
        f << "Popped element: " << m << endl;
    }
    f.close();
    inp.close();
}