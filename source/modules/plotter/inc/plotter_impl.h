#include <matplot/matplot.h>

template <typename... Types>
void plotter::show_plot(plotter::plot_details const& config, Types const&... args)
{
    using namespace matplot;

    const std::size_t nargs = sizeof...(args) / 2;

    auto p = plot((args.as_std_vector(), ...));

    // if (config.Legend.has_value())
    // {
    //     auto &v = config.Legend.value();
    //     for (int i = 0; i < nargs; ++i)
    //         p[i].legend_string(v[i]);
    // }

    // if (config.LineWIdth.has_value())
    // {
    //     line_width(config.LineWIdth.value());
    // }

    if (config.Title.has_value())
    {
        title(config.Title.value());
    }

    if (config.XLabel.has_value())
    {
        xlabel(config.XLabel.value());
    }

    if (config.YLabel.has_value())
    {
        ylabel(config.YLabel.value());
    }

    show();
}