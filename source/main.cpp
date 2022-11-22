#include "rnd/random.h"

#include <iostream>

int main(int argc, char const *argv[])
{
    auto m = rnd::randn_std_mat(2);
    std::cout << m << std::endl;
    return 0;
}
