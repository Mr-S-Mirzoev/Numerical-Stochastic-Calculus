#include "linalg/algorithms.h"
#include "linalg/matrix.h"

#include <Eigen/Core>
#include <Eigen/Cholesky>

namespace linalg
{
Matrix algorithms::cholesky(Matrix const& A)
{
    Eigen::LLT<Eigen::MatrixXd> lltOfA(A.get_data());
    Eigen::MatrixXd L = lltOfA.matrixL();
    return L;
}
} // namespace linalg
