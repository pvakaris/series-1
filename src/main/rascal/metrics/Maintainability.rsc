module metrics::Maintainability

import Set;

import metrics::Volume;
import metrics::Duplicates;
import metrics::UnitSize;
import metrics::UnitComplexity;
import metrics::UnitTesting;

import utils::SIGEvaluator;
import utils::Calculator;
import utils::Helpers;

str analysability(loc project) {
    list[int] scores = [
        toScore(evaluateUnitSize(countUnitSize(project))),
        // toScore(evaluateUnitTesting(countUnitTestingCoverage(project))),
        toScore(evaluateVolume(computeProjectMetric(project, countLines))),
        toScore(evaluateDuplicates(countDuplicatesPercentage(project)))
    ];
    return toRank(averageScore(scores));
}

str changeability(loc project) {
    list[int] scores = [
        toScore(evaluateUnitComplexity(countUnitComplexity(project))),
        toScore(evaluateDuplicates(countDuplicatesPercentage(project)))
    ];
    return toRank(averageScore(scores));
}

str testability(loc project) {
    list[int] scores = [
        toScore(evaluateUnitSize(countUnitSize(project))),
        // toScore(evaluateUnitTesting(countUnitTestingCoverage(project))),
        toScore(evaluateUnitComplexity(countUnitComplexity(project)))
    ];
    return toRank(averageScore(scores));
}

str stability(loc project) {
    return evaluateUnitTesting(countUnitTestingCoverage(project));
}

str maintainability(loc project) {
    list[int] scores = [
        toScore(changeability(project)),
        toScore(testability(project)),
        // toScore(stability(project)),
        toScore(analysability(project))
    ];
    return toRank(averageScore(scores));
}