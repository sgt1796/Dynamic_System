# Dynamic Systems and Chaos Visualization

This repository contains scripts for generating and visualizing various dynamic and chaotic systems. These scripts implement mathematical models that demonstrate complex behaviors, providing insights into the fascinating world of chaos theory and dynamic systems.

## Overview

Dynamic systems and chaos theory explore the behavior of systems that evolve over time according to a set of rules. These systems can exhibit a wide range of behaviors, from predictable and periodic to highly irregular and chaotic. This repository aims to provide a collection of scripts to model and visualize such behaviors.

## Contents

### Current Scripts

1. **Gingerbreadman Map**:
   - **Description**: Visualizes the Gingerbreadman map, a type of chaotic map from R^2 to R^2.
   - **Features**: Generates orbits of the map using randomly generated starting points.
   - **Dependencies**: `latex2exp`

2. **Unknown Function f(a, b, c)**:
   - **Description**: Computes and visualizes the values of an unknown function f(a, b, c) mapping from R^3 to R.
   - **Features**: Analyzes the long-term behavior of the function by fixing different parameters.
   - **Dependencies**: `ggplot2`, `plotly`, `dplyr`, `tibble`, `reshape2`, `tidyr`

### Planned Scripts

The repository will be updated with additional scripts to cover various other dynamic systems and chaotic maps, such as:
- Lorenz attractor
- Mandelbrot set
- Julia set
- Logistic map
- Henon map

## Requirements

- R