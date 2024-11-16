module utils::SIGEvaluator

str evaluateDuplicates(real duplicatesPercent) {
    if (duplicatesPercent < 3) return "++";
    if (duplicatesPercent < 5) return "+";
    if (duplicatesPercent < 10) return "o";
    if (duplicatesPercent < 20) return "-";
    return "--";
}

str evaluateVolume(int linesOfCode) {
    if (linesOfCode < 66000) return "++";
    if (linesOfCode < 246000) return "+";
    if (linesOfCode < 665000) return "o";
    if (linesOfCode < 1310000) return "-";
    return "--";
}