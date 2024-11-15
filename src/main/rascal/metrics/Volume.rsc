module metrics::Volume

import IO;
import List;
import Set;
import String;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;

// Lines that are not comments and not blank
int countFunctionalLines(loc project) {
    return computeProjectMetric(project, countLines) 
    - computeProjectMetric(project, countBlankLines) 
    - computeProjectMetric(project, countComments);
}

// To speed-up the calculation when the values are already computed
int countFunctionalLines(int total, int blank, int comments) {
    return total - blank - comments;
}

int countLines(loc file) {
    return size(readFileLines(file));
}

int countBlankLines(loc file) {
    int blankLines = 0;
    for (line <- readFileLines(file)) {
        if (trim(line) == "") {
            blankLines += 1;
        }
    }
    return blankLines;
}

int countComments(loc file) {
    int lineComments = 0;
    int blockComments = 0;
    bool isInsideBlockComment = false;
    
    for (line <- readFileLines(file)) {
        str trimmedLine = trim(line);
        if (startsWith(trimmedLine, "/*") || isInsideBlockComment) {
            isInsideBlockComment = true;
            blockComments += 1;
            if (endsWith(trimmedLine, "*/")) {
                isInsideBlockComment = false;
            }
        } else if (startsWith(trimmedLine, "//")) {
            lineComments += 1;
        }
    }
    return lineComments + blockComments;
}