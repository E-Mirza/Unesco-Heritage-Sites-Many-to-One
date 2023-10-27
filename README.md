# Unesco-Heritage-Sites-Many-to-One
Normalize the data in the unesco_raw table by adding the entries to each of the lookup tables (category, etc.) and then adding the foreign key columns to the unesco_raw table. Then make a new table called unesco that removes all of the un-normalized redundant text columns like category.
If you run the program multiple times in testing or with different files, make sure to empty out the data before each run.

The autograder will look at the unesco table.
