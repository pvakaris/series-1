module Main

import List;
import Set;
import String;
import DateTime;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;
import utils::SIGEvaluator;
import utils::Logger;

import metrics::Volume;
import metrics::Duplicates;

import Constants;


void runAnalysisOn(loc project, str projectName) {
    datetime startTime = now();
    log("Running analysis on: <projectName>");
    logDashedLine();

    analyseVolume(project);
    logEmptyLine();
    analyseDuplicates(project);

    // TODO: Extend by adding more analysis here

    logDashedLine();
    interval runtime = createInterval(startTime, now());
    logDuration("Analysis of the project took:", createDuration(runtime));
    logDashedLine();
    logEmptyLine();
}

void main() {
    runAnalysisOn(SMALLSQL_PROJECT, "SmallSQL Project");
    // runAnalysisOn(HSQLDB_PROJECT, "HSQLDB Project");
}

// PRIVATE METHODS

private void analyseVolume(project) {
    log("Volume:");
    logDashedLine();

    int total = computeProjectMetric(project, countLines);
    log("Lines of Code (Total): <total>");

    int blank = computeProjectMetric(project, countBlankLines);
    log("Blank lines: <blank>");

    int comments = computeProjectMetric(project, countComments);
    log("Comment lines: <comments>");

    log("Lines of Code (Functional): <countFunctionalLines(total, blank, comments)>");

    str volumeEvaluation = evaluateVolume(total);
    log("Volume ranking: <volumeEvaluation>");
}

private void analyseDuplicates(project) {
    // TODO:
}