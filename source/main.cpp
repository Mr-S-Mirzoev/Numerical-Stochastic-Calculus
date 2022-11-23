#include "rnd/random.h"

#include <iostream>

int main(int argc, char const *argv[])
{
    auto m = rnd::poisson(10, 4.1);
    std::cout << m << std::endl;
    std::cout << m.mean() << std::endl;
    return 0;
}
