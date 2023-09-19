# About this research

Coral populations globally are rapidly declining due to anthropogenic effects. Coral restoration helps mitigate the loss of corals and may increase resilience by introducing genetically diverse coral recruits (young corals produced through sexual propagation) to degraded reefs.

Challenge: Larger coral recruits have a higher chance of survival after outplanting, but the time required to grow them in the nursery prior to outplanting can be laborious, time-consuming, and costly. To scale up restoration efforts, reducing the grow-out period becomes essential. This can be accomplished by optimizing the laboratory environment where corals are raised, including the provision of optimal lighting. However, the ideal light spectrum for raising young corals in land-based nurseries remains unexplored.

The purpose of this thesis research is to explore the optimal light spectrum for coral recruits in land-based nurseries that promotes both survival and growth.

The study investigates the influence of different light spectra (LED Blue-shifted spectrum, LED Reef-depth spectrum, or Nautural Sunlight) on the survival and growth of two tropical scleractinian coral species, Pseudodiploria strigosa and P. clivosa, aged between 5 to 14 weeks post-settlement.

The data analysis involves using a Cox proportional hazard model for survival analysis and a Generalized Linear Mixed Effect Model (GLMM) to compare coral growth under different light spectra over time, with the aim of identifying the most beneficial light conditions for successful coral restoration efforts.

## Data Analysis: Survival
The data analysis involves using a Cox proportional hazard model to analyze the survival of coral recruits under different light spectra. For detailed survival curves, please refer to the [Coral Survival Curves RPubs](https://rpubs.com/Dayponce/CoralSurvivalCurves).

## Data Analysis: Growth
The data analysis involves using a Generalized Linear Mixed Effect Model (GLMM) to analyze the growth of coral recruits under different light spectra over time. The aim is to identify the most beneficial light conditions for successful coral restoration efforts. You can explore the [Coral Growth RPubs](https://rpubs.com/Dayponce/CoralGrowth) anaylsis and predictive growth model here.

# Results
## Survival
The results of the survival analysis revealed a significant influence of coral species on survival (p-value= 6×10-3), with Pseudodiploria strigosa displaying higher survival rates compared to Pseudodiploria clivosa. Although light spectrum did not show a statistically significant effect on survival, the p-value was close to the rejection level (p-value= 0.086), a notable trend was observed. Corals exposed to sunlight had the highest survival rates for both species.

## Growth
The GLMM analysis demonstrated significant variations in coral size between light spectra, species, time, and their interactions (all p-value <0.05). P. strigosa exhibited larger size and faster growth rates compared to P. clivosa. Corals under LED lights, irrespective of the spectrum, experienced positive growth, with the blue-shifted light spectrum promoting significantly faster growth than natural sunlight. P. clivosa under sunlight experienced a decrease in size over time, raising concerns about this species' survival under natural sunlight conditions.

## Summary and Recommendations for Application
Manipulating light spectrum allows for the optimization of juvenile coral grow-out, with three main takeaways. First, corals under sunlight at the surface depth exhibited higher survival but grew slower, suggesting a potential trade-off between survival and growth. Second, corals exposed to LED blue-shifted and reef-depth spectrum exhibited faster growth during grow-out, with the blue-shifted spectrum promoting the fastest growth compared to sunlight at the surface depth. Lastly, recruits of P. clivosa had a smaller initial size and experienced significantly higher mortality rates during grow-out compared to P. strigosa, indicating a potential size advantage for survival.

Based on the results, I recommend that LED lights, especially the blue-shifted spectrum, be considered for coral growth in restoration efforts. However, it's important to be mindful of increased algae growth rates, particularly under LED lights. To address the issue of algae overgrowth, the introduction of herbivores to assist with algal control is needed. While prioritizing growth rate is essential, addressing the potential negative impacts on coral health, such as algal overgrowth, is crucial to ensure sustainable outcomes. By identifying the optimal light spectrum, this research offers valuable information that can guide the design of coral culturing systems for reef restoration purposes.



