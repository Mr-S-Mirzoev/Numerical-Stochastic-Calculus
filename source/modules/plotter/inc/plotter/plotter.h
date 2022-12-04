#pragma once

#include "linalg/vector.h"

#include <optional>
#include <string>
#include <vector>

class plotter
{
public:
    struct plot_details
    {
        std::optional <double> LineWIdth;

        std::optional <std::string> Title;
        std::optional <std::string> XLabel;
        std::optional <std::string> YLabel;
        std::optional <std::vector<std::string>> Legend;
    }; // struct plot_details

    static void show_histogram(linalg::Vector const& v);

    template <typename... Types>
    static void show_plot(plot_details const& config, Types const&... args);
}; // class rnd

#include "../plotter_impl.h"
