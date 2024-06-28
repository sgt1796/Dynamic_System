library(ggplot2)
library(plotly)
library(dplyr)
#library(shiny)
#a.max = 22
#b = 1:300
#c = 1:300

a.max = 1000
b = 1:20
c = 1:20

matrix.frame = tibble(a = numeric(),
                      b = numeric(),
                      c = numeric(),
                      value = numeric())
for (a_i in 2:a.max){
  matrix.val = outer(b, c, function(b_i, c_i) {(a_i^2 * b_i - b_i) %% c_i})
  matrix.vec = reshape2::melt(matrix.val, varnames = c("b", "c"))
  matrix.vec["a"] = a_i
  matrix.frame = matrix.frame %>%
    add_row(matrix.vec)
}

p = ggplot(data = matrix.frame,
       aes(x = b, y = c, fill = value, frame = a)) +
  geom_tile() +
  scale_fill_gradient(low="purple", high="orange") +
  theme_minimal() +
  coord_fixed()

ggplotly(p)

## f(x) = (a^2 * b - b) mod c
## Long-term of f(x) when fixing a, b
z = matrix.frame %>%
  group_by(c) %>%
  # summarize(orbit = purrr::map(list(value), unique)) %>%
  summarize(orbit = list(value)) %>%
  tidyr::unnest_longer(orbit)
z.small = filter(z, c <= 100)
ggplot(data = z.small, aes(x = c, y = orbit)) +
  geom_point(alpha = 0.1, size = 0.1) +
  scale_y_continuous("f(x)") +
  scale_x_continuous("c") +
  theme_minimal()
## Long-term of f(x) when fixing a, c
z = matrix.frame %>%
  group_by(b) %>%
  # summarize(orbit = purrr::map(list(value), unique)) %>%
  summarize(orbit = list(value)) %>%
  tidyr::unnest_longer(orbit)
z.small = filter(z.small, b <= 100)
ggplot(data = z, aes(x = b, y = orbit)) +
  geom_point(alpha = 0.1, size = 0.1) +
  scale_y_continuous("f(x)") +
  scale_x_continuous("b") +
  theme_minimal()
## Long-term of f(x) when fixing b, c
z = matrix.frame %>%
  group_by(a) %>%
  # summarize(orbit = purrr::map(list(value), unique)) %>%
  summarize(orbit = list(value)) %>%
  tidyr::unnest_longer(orbit)
z.small = filter(z, a <= 100)
ggplot(data = z.small, aes(x = a, y = orbit)) +
  geom_point(alpha = 0.1, size = 0.1) +
  scale_y_continuous("f(x)") +
  scale_x_continuous("a") +
  theme_minimal()
