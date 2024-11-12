module Main

import IO;
import List;
import Set;
import String;
import lang::java::m3::Core;
import lang::java::m3::AST;
import utils::Utils;

void runAnalysisOn(loc project) {
    // TODO: Implement the analysis by calling different methods and printing the results
}

void main() {
    runAnalysisOn(|cwd:///test-projects/smallsql0.21_src|);
    // runAnalysisOn(|cwd:///test-projects/hsqldb-2.3.1/hsqldb/src|);
}

/* 
    To test whether the project works with relative paths
    TODO: remove before submission
*/
void testMethod() {
    println("Test method started. Calculating the total number of declarations.");
    loc projectLocation = |cwd:///test-projects/smallsql0.21_src|; 
    list[Declaration] asts = getASTs(projectLocation); 
    println("Total number of declarations is: <size(asts)>");
}