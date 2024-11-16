module tests::VolumeTests

import metrics::Volume;

import Constants;

import utils::SIGEvaluator;
import utils::Helpers;

// Testing SMALLSQL_PROJECT
test bool testCountLinesSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countLines) == 38423;
}

test bool testCountBlankLinesSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countBlankLines) == 5394;
}

test bool testCountCommentsSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countComments) == 9025;
}

test bool testCountFunctionalLinesSmallSQL() {
    return computeProjectMetric(SMALLSQL_PROJECT, countFunctionalLines) == 24004;
}

test bool testVolumeEvaluationSmallSQL() {
    return evaluateVolume(countLines(SMALLSQL_PROJECT)) == "++";
}

// Testing CURRENCY_CONVERTER_PROJECT
test bool testCountLinesCurrencyConverter() {
    return computeProjectMetric(CURRENCY_CONVERTER_PROJECT, countLines) == 813;
}

test bool testCountBlankLinesCurrencyConverter() {
    return computeProjectMetric(CURRENCY_CONVERTER_PROJECT, countBlankLines) == 114;
}

test bool testCountCommentsCurrencyConverter() {
    return computeProjectMetric(CURRENCY_CONVERTER_PROJECT, countComments) == 248;
}

test bool testCountFunctionalLinesCurrencyConverter() {
    return computeProjectMetric(CURRENCY_CONVERTER_PROJECT, countFunctionalLines) == 451;
}

test bool testVolumeEvaluationCurrencyConverter() {
    return evaluateVolume(countLines(CURRENCY_CONVERTER_PROJECT)) == "++";
}

