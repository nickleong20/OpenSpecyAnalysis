# Week 4: OpenSpecyAnalysis R Package
The package, in general, provides a comprehensive set of tools for spectral data analysis in R. It allows researchers and scientists to efficiently work with various types of spectral data files, such as CSV, ASP, JDX, SPC, SPA, and 0 formats, by using the `read_data` function, which automatically detects the file format and loads the data accordingly. The `spectrum` function aids in classifying the type of spectrum (Raman or FTIR) present in the data, facilitating further analysis and processing. Additionally, the `automatch` function automates the process of spectrum matching, making it easier for researchers to compare their data with existing libraries and obtain valuable insights from their spectral datasets. The package also includes the `plot_spectrum` function, which enables users to visualize and customize spectral plots with intensity adjustment and background subtraction. 

By combining these functionalities, the package simplifies and streamlines the entire spectral data analysis workflow, empowering researchers to make more informed decisions and discoveries in their scientific endeavors.

## How it Works
The package works by providing a collection of functions designed to streamline and simplify the analysis of spectral data in R. The core functionalities include data reading, spectrum type classification, and automated spectrum matching.

1. Data Reading: The `read_data` function serves as a versatile data reader that handles various spectral data file formats, such as CSV, ASP, JDX, SPC, SPA, and 0. When provided with the pathname of a file, the function automatically determines the file's extension and uses the appropriate reading method to load the spectral data into R. This eliminates the need for users to worry about the specific file format and ensures seamless data import for various datasets.

2. Spectrum Type Classification: The `spectrum` function acts as a spectral type classifier. It takes the pathname of a file containing spectral data and analyzes the data using the "OpenSpecy" package. By performing statistical comparisons, the function determines whether the spectrum is of the Raman or FTIR type. This classification is essential as it guides subsequent analyses and allows researchers to choose appropriate methods tailored to the specific spectrum type.

3. Automated Spectrum Matching: The `automatch` function automates the process of spectrum matching. Given the pathname of a file containing spectral data, the function first identifies the spectrum type using the `spectrum` function. It then reads and preprocesses the data, applying techniques such as smoothing and background correction. Next, the function matches the processed spectra with the corresponding library using the "OpenSpecy" package. Matching scores are calculated based on an R-value, and the results are organized in a data frame. By automating this process, researchers can quickly identify the best matches and gain valuable insights from their spectral datasets.

4. Spectrum Plotting: The `plot_spectrum` function allows users to visualize spectral data by generating customizable plots in R. Users can provide the file path of the spectral data file and adjust the intensity and background factors for better data visualization. The function internally processes the data using the provided factors and plots the spectral data with an inverted x-axis, presenting the highest value on the left and the lowest value on the right, enabling researchers to gain deeper insights from their spectral datasets.

Overall, the package provides an efficient and user-friendly solution for spectral data analysis, allowing researchers to import, classify, and match spectra effortlessly, thus enhancing their ability to extract meaningful information from spectral data with ease.

## Getting Started
### Installation
First, make sure you have the necessary packages installed by executing install.packages("OpenSpecy") and install.packages("dplyr") in your R environment if you haven't done so already. Next, install the package directly from GitHub using the remotes package. To do this, run install.packages("remotes") if you don't have the remotes package installed yet. After that, load the remotes package with library(remotes). Finally, install the package from the GitHub repository using the following command:
```R
remotes::install_github("nickleong20/OpenSpecyAnalysis")
```

The provided R code consists of several functions: `read_data`, `spectrum`, `automatch`, and `plot_spectrum`. These functions work together to read, classify, and analyze spectral data files, making it easier to gain valuable insights from the data.

#### Example Workflow:

1. **Import the Required Packages:** First, make sure you have the necessary packages installed. You can install them using `install.packages("OpenSpecy")` and `install.packages("dplyr")`. After installation, load the packages in your R session using `library(OpenSpecy)` and `library(dplyr)`.

2. **Read and Classify Spectral Data:** Use the `read_data` function to read the spectral data from your file. Provide the `pathname` argument with the path to your data file (e.g., "spectra_data.csv"). This function will automatically detect the file format and import the data into a data frame. For example:
```R
data <- read_data("spectra_data.csv")
```

3. **Determine Spectrum Type:** Use the `spectrum` function to determine the spectrum type (Raman or FTIR) of your data. Provide the `pathname` argument with the path to your data file. The function will compare the R-squared values for Raman and FTIR spectra to determine the spectrum type with the higher R-squared value. For example:
```R
spectrum_type <- spectrum("spectra_data.csv")
```

4. **a) Automated Spectrum Matching (Optional):** If your data is classified as either "Raman" or "FTIR," you can proceed with automated spectrum matching using the `automatch` function. This function automates the process of matching your spectrum with existing libraries and provides valuable insights and matches. Example usage:
```R
automatch_results <- automatch("spectra_data.csv")
```

4. **b) Select a Specific Dataset (Optional):** If the `automatch` function identifies multiple potential matches for your spectrum, you can use the `find_spec` function to select a specific dataset from the results. All that is needed is the sample name and spectrum type. For example, if you wanted to select sample 5381, that is the Raman spectrum:
```R
selected_dataset <- find_spec(sample_name == 5381, library = spec_lib, which = "raman")
```

5. **Plot Spectrum (Optional):** You can visualize your spectral data using the `plot_spectrum` function. This function reads spectral data from the provided file, applies intensity adjustment, and background subtraction (if provided), and plots the processed spectrum with the wavenumber (cm-1) on the x-axis and intensity on the y-axis. Example usage:
```R
# Plot spectrum with default intensity and background factors
plot_spectrum("spectra_data.csv")

# Plot spectrum with specified intensity and background factors
plot_spectrum("spectra_data.csv", smoothing_factor = 5, background_factor = 12)
```

By following this workflow, you can efficiently read and classify your spectral data, determine the spectrum type, perform automated spectrum matching, and further analyze and visualize the data for meaningful insights. The `find_spec` function allows you to select a specific dataset from the automated matching results, offering flexibility and control over your spectral data analysis in R.

## Get in Touch

Thank you for your interest in my project! If you have any questions, suggestions, or feedback, feel free to contact me. I'd be happy to hear from you.

- **Email:** [nick@mooreplasticresearch.org](mailto:nick@mooreplasticresearch.org)
- **Website:** [www.mooreplasticresearch.org](https://mooreplasticresearch.org/)
- [**Discussion Board**](https://github.com/nickleong20/OpenSpecyAnalysis/discussions/1)
  
[![Twitter Follow](https://img.shields.io/twitter/follow/MoorePlasticRes?style=social)](https://twitter.com/MoorePlasticRes)
![Discord](https://img.shields.io/badge/Discord-Placeholder-7289DA?logo=discord&logoColor=white)
![Facebook](https://img.shields.io/badge/Facebook-Placeholder-3b5998?logo=facebook&logoColor=white)


Please maintain a professional and respectful environment. When you contact me, please follow the project's code of conduct and provide clear and concise information about your question or feedback. 

Thank you once again for your interest in the project. I look forward to hearing from you and collaborating with the community.

## Contributions
We encourage contributions of all kinds!

Please refer to our [contributing guidelines](https://github.com/nickleong20/Week2_OpenSpecy/blob/main/CONTRIBUTING.md) when contributing to this project. We also ask that you follow our [code of conduct](). 

