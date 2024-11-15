module tests::VolumeTests

import metrics::Volume;

import Constants;

import utils::SIGEvaluator;
import utils::Helpers;

// Testing SMALLSQL_PROJECT
test bool testCountFunctionalLinesSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countLines) == 38423;
}

test bool testCountBlankLinesSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countBlankLines) == 5394;
}

test bool testCountCommentsSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countComments) == 9025;
}

test bool testCountLinesSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countFunctionalLines) == 24004;
}

test bool testVolumeEvaluationSmallsql() {
    return evaluateVolume(countLines(SMALLSQL_PROJECT)) == "++";
}
