module Main

import List;
import Set;
import String;
import DateTime;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;
import utils::Calculator;
import utils::SIGEvaluator;
import utils::Logger;

import metrics::Volume;
import metrics::Duplicates;
import metrics::UnitSize;
import metrics::UnitComplexity;
import metrics::Maintainability;
import metrics::UnitTesting;

import Constants;


void runAnalysisOn(loc project, str projectName) {
    datetime startTime = now();
    log("Running analysis on: <projectName>");
    logDashedLine();

    analyseVolume(project);
    logDashedLine();
    analyseDuplicates(project);
    logDashedLine();
    analyseUnitSize(project);
    logDashedLine();
    analyseCyclomaticComplexity(project);
    // logDashedLine();
    // analyseUnitTesting(project);

    // TODO: Extend by adding more analysis here
    logDashedLine();
    analyseMaintainability(project);
    logDashedLine();
    interval runtime = createInterval(startTime, now());
    logDuration("Analysis of the project took:", createDuration(runtime));
    logDashedLine();
}

void main() {
    logDashedLine();
    runAnalysisOn(SMALLSQL_CWD, "SmallSQL Project");
    runAnalysisOn(HSQLDB_CWD, "HSQLDB Project");
}

// PRIVATE METHODS

private void analyseUnitSize(project) {
    log("Unit Size:");
    logDashedLine();

    list[int] aNL = US_nLineByRiskCat(project);

    list[real] rp = riskProfile(aNL);
    log("Risk profile (percentage in moderate risk zone, percentage in high risk zone, percentage in very high risk zone): <rp>");

    str rank = toRank(levelByRiskProfile(rp));
    log("Unit size ranking: <rank>");
}

private void analyseCyclomaticComplexity(project) {
    log("Cyclomatic Complexity:");
    logDashedLine();

    list[int] aNL = CC_nLineByRiskCat(project);

    list[real] rp = riskProfile(aNL);
    log("Risk profile (percentage in moderate risk zone, percentage in high risk zone, percentage in very high risk zone): <rp>");

    str rank = toRank(levelByRiskProfile(rp));
    log("Cyclomatic Complexity ranking: <rank>");
}

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
    log("Duplicates:");
    logDashedLine();
    
    int total = computeProjectMetric(project, countLines);
    log("Total lines: <total>");

    int duplicates = countDuplicates(project);
    log("Duplicates: <duplicates>");

    real percentage = percent(duplicates, total);
    log("Duplication percentage: <percentage>%");

    str duplicatesEvaluation = evaluateDuplicates(percentage);
    log("Duplication ranking: <duplicatesEvaluation>");
}

private void analyseUnitTesting(project) {
    log("Unit testing:");
    logDashedLine();
    
    real coverage = countUnitTestingCoverage(project);
    log("Coverage: <coverage>");
    log("Unit testing ranking: <evaluateUnitTesting(coverage)>");
}

private void analyseMaintainability(project) {
    log("MAINTAINABILITY:");
    logDashedLine();
    
    log("Analysability: <analysability(project)>");
    log("Changeability: <changeability(project)>");
    // log("Stability: <stability(project)>");
    log("Testability: <testability(project)>");
    log("Overall maintainability: <maintainability(project)>");
}