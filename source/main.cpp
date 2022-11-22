#include "rnd/random.h"

#include <iostream>

int main(int argc, char const *argv[])
{
    auto vec = rnd::randn_std(10);
    for (int i = 0; i < 10; ++i)
        std::cout << vec(i) << " ";
    std::cout << std::endl;
    return 0;
}
