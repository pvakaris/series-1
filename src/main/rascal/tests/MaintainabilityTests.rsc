module tests::MaintainabilityTests

import metrics::Maintainability;

import utils::Helpers;
import utils::SIGEvaluator;
import utils::Calculator;

import Constants;


test bool testAnalysabilitySmallSQL() {
    return analysability(SMALLSQL_PROJECT) == "o";
}

test bool testChangeabilitySmallSQL() {
    return changeability(SMALLSQL_PROJECT) == "o";
}

test bool testTestabilitySmallSQL() {
    return testability(SMALLSQL_PROJECT) == "+";
}
test bool testMaintainabilitySmallSQL() {
    return maintainability(SMALLSQL_PROJECT) == "+";
}

test bool testAnalysabilityCurrencyConverter() {
    return analysability(CURRENCY_CONVERTER_PROJECT) == "++";
}

test bool testChangeabilityCurrencyConverter() {
    return changeability(CURRENCY_CONVERTER_PROJECT) == "++";
}

test bool testTestabilityCurrencyConverter() {
    return testability(CURRENCY_CONVERTER_PROJECT) == "++";
}

test bool testMaintainabilityCurrencyConverter() {
    return maintainability(CURRENCY_CONVERTER_PROJECT) == "++";
}