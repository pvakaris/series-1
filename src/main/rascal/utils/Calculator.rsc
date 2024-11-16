module utils::Calculator

import List;

import util::Math;
import Constants;
import utils::Logger;

real percent(int number, int total) {
    real percentage = (toReal(number) / toReal(total)) * 100;
    return roundN2(percentage);
}

real roundN2(real n) {
    return round(toReal(n), ROUNDING_DIGITS); // Round to two places after the decimal point
}

int averageScore(list[int] scores) {
    log(scores);
    int avg = size(scores) == 0 ? 0 : sum(scores) / size(scores);
    log(avg);
    return avg;
}
