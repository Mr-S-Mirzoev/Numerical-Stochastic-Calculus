#include "linalg/vector.h"

namespace linalg
{
Vector::Vector(int n): data_(n)
{
}

double& Vector::operator()(size_t idx)
{
    return data_[idx];
}

double const& Vector::operator()(size_t idx) const
{
    return data_[idx];
}

int Vector::size() const
{
    return data_.size();
}
} // namespace linalg
