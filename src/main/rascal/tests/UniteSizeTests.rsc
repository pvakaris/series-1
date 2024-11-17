module tests::UnitSizeTests

import metrics::UnitSize;

import utils::Helpers;
import utils::SIGEvaluator;
import utils::Calculator;

import Constants;

// Testing SMALLSQL_PROJECT
test bool testUnitSizeValuesSmallSQL() {
    list[real] rp = countUnitSize(SMALLSQL_PROJECT);
    return rp[0] == 3.84 && rp[1] == 6.48 && rp[2] == 0.0;
}

test bool testUnitSizeRankingSmallSQL() {
    list[real] rp = countUnitSize(SMALLSQL_PROJECT);
    return toRank(levelByRiskProfile(rp)) == "o";
}

// Testing CURRENCY_CONVERTER_PROJECT
test bool testUnitSizeValuesCurrencyConverter() {
    list[real] rp = countUnitSize(CURRENCY_CONVERTER_PROJECT);
    return rp[0] == 0.0 && rp[1] == 0.0 && rp[2] == 0.0;
}

test bool testUnitSizeRankingCurrencyConverter() {
    list[real] rp = countUnitSize(CURRENCY_CONVERTER_PROJECT);
    return toRank(levelByRiskProfile(rp)) == "++";
}