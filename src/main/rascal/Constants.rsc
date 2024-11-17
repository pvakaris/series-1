module Constants

// Can be used without importing the test-projects into the workspace
public loc SMALLSQL_CWD = |cwd:///test-projects/smallsql0.21_src|;
public loc HSQLDB_CWD = |cwd:///test-projects/hsqldb-2.3.1/hsqldb|;
public loc CURRENCY_CONVERTER_CWD = |cwd:///test-projects/currency_converter|;

// The following are to be used after the projects from /test-projects directory have been imported into the workspace
public loc SMALLSQL_PROJECT = |project://smallsql0.21_src|;
public loc HSQLDB_PROJECT = |project://hsqldb-2.3.1/hsqldb/|;
public loc CURRENCY_CONVERTER_PROJECT = |project://currency_converter|;

// MATH Constants
public real ROUNDING_DIGITS = 0.01;

// DUPLICATES Constants
public int BLOCK_SIZE = 6;

// minimum risk profiles for 5 (4,3,2) star project (used for unit size and unit complexity)
public list[real] ONE_STAR_RISK_PROFILE = [25.0, 0.0, 0.0];
public list[real] TWO_STAR_RISK_PROFILE = [30.0, 5.0, 0.0];
public list[real] THREE_STAR_RISK_PROFILE = [40.0, 10.0, 0.0];
public list[real] FOUR_STAR_RISK_PROFILE = [50.0, 15.0, 5.0];

// threshold between low risk and moderate risk zones for unit size
public int UNIT_SIZE_MOD_RISK_THR = 30;
public int UNIT_SIZE_HIGH_RISK_THR = 44;
public int UNIT_SIZE_VERY_HIGH_RISK_THR = 74;

// threshold between low risk and moderate risk zones for cyclomatic complexity
public int CC_MOD_RISK_THR = 10;
public int CC_HIGH_RISK_THR = 20;
public int CC_VERY_HIGH_RISK_THR = 50;