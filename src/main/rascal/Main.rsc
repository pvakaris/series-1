module Main

import IO;
import List;
import Set;
import String;
import lang::java::m3::Core;
import lang::java::m3::AST;
import utils::Utils;
import Constants;

void runAnalysisOn(loc project) {
    // TODO: Implement the analysis by calling different methods and printing the results
}

void main() {
    runAnalysisOn(SMALLSQL_PROJECT);
    // runAnalysisOn(HSQLDB_PROJECT);
}

/* 
    To test whether the project works with relative paths
    TODO: remove before submission
*/
void testMethod() {
    println("Test method started. Calculating the total number of declarations.");
    list[Declaration] asts = getASTs(SMALLSQL_PROJECT); 
    println("Total number of declarations is: <size(asts)>");
}