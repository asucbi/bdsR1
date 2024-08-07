# Load necessary library
library(fs)

# Define the path to your Quarto file
quarto_file <- "project-F24.qmd"

# Define the output directory where you want the extra copy
output_dir <- "../docs/project"

# Render the Quarto file
quarto::quarto_render(quarto_file)

# Construct the file paths
original_html <- paste0(tools::file_path_sans_ext(quarto_file), ".html")
destination_html <- file.path(output_dir, basename(original_html))

# Create the directory if it doesn't exist
dir_create(output_dir)

# Copy the file
file_copy(original_html, destination_html, overwrite = TRUE)

