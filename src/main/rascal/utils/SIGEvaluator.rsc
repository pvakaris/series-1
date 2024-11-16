module utils::SIGEvaluator

// Only Java code evaluators are defined here

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

str evaluateUnitTesting(real coverage) {
    if (coverage < 20) return "--";
    if (coverage < 60) return "-";
    if (coverage < 80) return "o";
    if (coverage < 95) return "+";
    return "++";
}

int toScore(str rank) {
    switch (rank) {
        case "++": return 0;
        case "+": return 1;
        case "o": return 2;
        case "-": return 3;
        case "--": return 4;
        default: return 4;
    }
}

str toRank(int score) {
    switch (score) {
        case 0: return "++";
        case 1: return "+";
        case 2: return "o";
        case 3: return "-";
        case 4: return "--";
        default: return "--";
    }
}