#include "rnd/random.h"
#include "plotter/plotter.h"

#include <iostream>

int main(int argc, char const *argv[])
{
    auto v = rnd::poisson(1e4, 10.0);
    std::cout << v << std::endl;
    std::cout << v.mean() << std::endl;

    plotter::show_histogram(v);
    return 0;
}
