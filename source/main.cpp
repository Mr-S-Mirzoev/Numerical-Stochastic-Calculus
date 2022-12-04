#include "linalg/matrix.h"

#include "plotter/plotter.h"

#include "rnd/bm.h"

#include <iostream>

int main(int argc, char const *argv[])
{
    // Script to plot (approximate) paths of Brownian motions
    // Initializing simulation parameters and empty matrices
    double T = 1;
    linalg::Vector t = linalg::range(0, T, 1 << 10);
    std::vector<std::size_t> N {1 << 7, 1 << 8, 1 << 9};

    std::vector<linalg::Vector> WInt(N.size());
    std::vector<linalg::Vector> W(N.size());

    // For loop over different value of N
    for (int i{0}; i < N.size(); ++i)
    {
        // Incremental simulation with linear interpolation
        WInt[i] = brownian_motion::incremental_interpolation(t, T, N[i]);

        // Exact simulation over Brownian bridge
        W[i] = brownian_motion::bridge_interpolation(t, T, N[i]);
    }

    plotter::plot_details config;
    config.LineWIdth = 1.5;
    config.XLabel = "t";
    config.YLabel = "W_inc";
    config.Legend = std::vector<std::string>(N.size());
    for (int i{0}; i < N.size(); ++i)
        config.Legend.value()[i] = "N = " + std::to_string(N[i]);
    config.Title = "Approximate paths of a Brownian motion";
    plotter::show_plot(config, t, WInt[0], t, WInt[1], t, WInt[2]);

    config.YLabel = "W";
    config.Title = "Exact paths of a Brownian motion";
    plotter::show_plot(config, t, W[0], t, W[1], t, W[2]);

    return 0;
}
