#include "plotter/plotter.h"

#include <matplot/matplot.h>

#include <iostream>

void plotter::show_histogram(linalg::Vector const& v)
{
    using namespace matplot;

    std::vector<double> x{v.as_std_vector()};

    auto h = hist(x);
    std::cout << "Histogram with " << h->num_bins() << " bins" << std::endl;

    show();
}
