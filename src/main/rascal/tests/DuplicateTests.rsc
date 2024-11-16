module tests::DuplicateTests

import metrics::Duplicates;
import metrics::Volume;

import utils::Helpers;
import utils::SIGEvaluator;
import utils::Calculator;

import Constants;

// Testing SMALLSQL_PROJECT
test bool testCountDuplicatesSmallSQL() {
    return countDuplicates(SMALLSQL_PROJECT) == 8150;
}

test bool testDuplicationRankingSmallSQL() {
    loc project = SMALLSQL_PROJECT;

    int total = computeProjectMetric(project, countLines);
    int duplicates = countDuplicates(project);
    return evaluateDuplicates(percent(duplicates, total)) == "--";
}

// Testing CURRENCY_CONVERTER_PROJECT
test bool testCountDuplicatesCurrencyConverter() {
    return countDuplicates(CURRENCY_CONVERTER_PROJECT) == 0;
}

test bool testDuplicationRankingCurrencyConverter() {
    loc project = CURRENCY_CONVERTER_PROJECT;

    int total = computeProjectMetric(project, countLines);
    int duplicates = countDuplicates(project);
    return evaluateDuplicates(percent(duplicates, total)) == "++";
}