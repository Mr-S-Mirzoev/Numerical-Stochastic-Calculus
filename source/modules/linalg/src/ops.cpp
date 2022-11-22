#include "linalg/ops.h"
#include "linalg/matrix.h"
#include "linalg/vector.h"

namespace linalg
{
Matrix mul(Matrix const& lhs, Matrix const& rhs)
{
    return lhs.get_data() * rhs.get_data();
}

Matrix mul(Matrix const& lhs, Vector const& rhs);
Matrix sum(Matrix const& lhs, Matrix const& rhs);
Matrix sub(Matrix const& lhs, Matrix const& rhs);

void mul(Matrix& lhs, Matrix const& rhs);
void mul(Matrix& lhs, Vector const& rhs);
void sum(Matrix& lhs, Matrix const& rhs);
void sub(Matrix& lhs, Matrix const& rhs);
} // namespace linalg
