# Naming Conventions of Biodata Resources
### A preprint of this study as been posted to bioRxiv "Analyzing the Naming Conventions of Life Science Data Resources to Inform Human and Computational Findability" https://doi.org/10.1101/2025.10.02.680112
### Purpose: Analysis of full and common names predicted in the Global Biodata Coalition Inventory (2022)
  * Started with inventory:
     * Imker, H., Schackart, K., Istrate, A.-M., & Cook, C. E. (2023). Biodata Resource Inventory Dataset [Data set]. Zenodo. https://doi.org/10.5281/zenodo.10105948
  * Filtered to resources with both a common and a full name predicted
  * Each name pair checked and corrected as needed (validated)
  * Validated common names were coded for optics (opaque, translucent, or transparent) 
  * Input file: names_input.csv
     * **Variables**
       * ID: PMCID for resource's most recent article as of 2021
       * pubYear: year the associated article was published
       * best_common: validated common name 
       * best_full: validated full name
       * stat: clarity classification for best_common as determined by a statistician
       * bio: clarity classification for best_common as determined by a biologist
  * STEP 1 Script
    * Analyzed character count and prefixes for validated common names
    * Output: names_output_common.csv and Figure 1
  * STEP 2 Script
    * Analyzed word count and first/last word for validated full names
    * Output: names_output_common_full.csv and Figure 3
  * STEP 3 Script
    * Compared clearity classifications in an agreement matrix
    * Output: names_output_common_full_optics.csv and Figure 2

