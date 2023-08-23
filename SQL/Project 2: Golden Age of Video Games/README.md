# When Was the Golden Age of Video Games?
Video games are big business: the global gaming market is projected to be worth more than $300 billion by 2027 according to Mordor Intelligence. With so much money at stake, the major game publishers are hugely incentivized to create the next big hit. But are games getting better, or has the golden age of video games already passed?

In this project, we'll explore the top 400 best-selling video games created between 1977 and 2020. We'll compare a dataset on game sales with critic and user reviews to determine whether or not video games have improved as the gaming market has grown
The database contains two tables. We've limited each table to 400 rows for this project, but you can find the complete dataset with over 13,000 games on Kaggle.

## Skills used:
SQL querying, database manipulation, data joining, aggregating using functions like AVG and SUM, and result filtering were utilized to analyze video game sales and reviews data, extracting insights about top-selling games, critic and user preferences, and their corresponding release years.

## Report:
1. The top ten best-selling video games range from "Wii Sports" for the Wii released in 2006 with 82.90 million copies sold down to "New Super Mario Bros. Wii" for the Wii released in 2009 with 30.30 million copies sold.
2. About 31 games in the dataset lack reviews data, which could limit our analysis.
3. Based on critic scores, highly rated years for video games include 1990 (avg_critic_score: 9.80), 1992 (avg_critic_score: 9.67), and 1998 (avg_critic_score: 9.32).
4. After considering games with more than four reviews, years like 1998 (avg_critic_score: 9.32), 2004 (avg_critic_score: 9.03), and 2002 (avg_critic_score: 8.99) maintain their high critic scores.
5. Years that dropped off the top critic years list due to having fewer than four reviewed games include 2020, 1993, 1995, and 1982.
6. According to user scores, highly rated years for video games are 1997 (avg_user_score: 9.50), 1998 (avg_user_score: 9.40), and 2010 (avg_user_score: 9.24).
7. The years 1998, 2008, and 2002 are highly regarded by both critics and users as top years for video games.
8. Among the years with agreement from both critics and users, 2008 saw the highest total games sold (175.07 million), followed by 1998 (101.52 million), and 2002 (58.67 million).
