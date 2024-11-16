module Constants

// Can be used withlut importhing the test-projects
public loc SMALLSQL_CWD = |cwd:///test-projects/smallsql0.21_src|;
public loc HSQLDB_CWD = |cwd:///test-projects/hsqldb-2.3.1/hsqldb/src|;
public loc CURRENCY_CONVERTER_CWD = |cwd:///test-projects/currency_converter|;

// The following are to be used after the projects from /test-projects directory have been imported into the workspace
public loc SMALLSQL_PROJECT = |project://smallsql0.21_src|;
public loc HSQLDB_PROJECT = |project://hsqldb-2.3.1/hsqldb/src|;
public loc CURRENCY_CONVERTER_PROJECT = |project://currency_converter|;

// MATH Constants
public real ROUNDING_DIGITS = 0.01;

// DUPLICATES Constants
public int BLOCK_SIZE = 6;