module utils::Calculator

import util::Math;

real percent(int number, int total) {
    real percentage = (toReal(number) / toReal(total)) * 100;
    return roundN2(percentage);
}

real roundN2(real n) {
    return round(toReal(n), 0.01); // Round to two places after the decimal point
}

