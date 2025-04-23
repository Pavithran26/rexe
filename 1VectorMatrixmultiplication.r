# Vector and Matrix Multiplication in R

# Create a vector
v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)

# Create matrices
m1 <- matrix(1:6, nrow = 2, ncol = 3)  # 2x3 matrix
m2 <- matrix(7:12, nrow = 3, ncol = 2)  # 3x2 matrix
m3 <- matrix(1:9, nrow = 3, ncol = 3)   # 3x3 matrix

# 1. Element-wise vector multiplication (Hadamard product)
elementwise_product <- v1 * v2
cat("Element-wise vector multiplication:\n")
print(elementwise_product)

# 2. Dot product (inner product) of vectors
dot_product <- sum(v1 * v2)  # Method 1
dot_product2 <- v1 %*% v2    # Method 2 (returns a 1x1 matrix)
cat("\nDot product of vectors:\n")
print(dot_product)
print(dot_product2)

# 3. Outer product of vectors
outer_product <- v1 %o% v2   # Method 1
outer_product2 <- outer(v1, v2)  # Method 2
cat("\nOuter product of vectors:\n")
print(outer_product)
print(outer_product2)

# 4. Matrix multiplication
matrix_product <- m1 %*% m2
cat("\nMatrix multiplication (2x3 * 3x2 = 2x2):\n")
print(matrix_product)

# 5. Matrix-vector multiplication
# Vector must be on the right side with appropriate dimensions
matrix_vector_product <- m3 %*% v1  # 3x3 * 3x1 = 3x1
cat("\nMatrix-vector multiplication (3x3 * 3x1):\n")
print(matrix_vector_product)

# 6. Cross product of vectors
cross_product <- crossprod(v1, v2)  # Same as dot product for 1D vectors
cross_product_3d <- crossprod(c(1,2,0), c(3,4,0))  # For 3D vectors
cat("\nCross product (for 3D vectors):\n")
print(cross_product_3d)

# 7. Kronecker product
kronecker_product <- kronecker(m1, m2)
cat("\nKronecker product:\n")
print(kronecker_product)

# 8. Element-wise matrix multiplication (Hadamard product)
# Matrices must have same dimensions
m4 <- matrix(1:4, nrow = 2)
m5 <- matrix(5:8, nrow = 2)
hadamard_product <- m4 * m5
cat("\nElement-wise matrix multiplication:\n")
print(hadamard_product)

# 9. Matrix transpose
transpose <- t(m1)
cat("\nMatrix transpose:\n")
print(transpose)

# 10. Diagonal matrix from vector
diag_matrix <- diag(v1)
cat("\nDiagonal matrix from vector:\n")
print(diag_matrix)