module utils::SIGEvaluator

import List;
import Constants;

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

// util function for the following function.
// This function takes risk profile of a system and threshold for risk profile.
// This function returns true if risk profile is lower then given threshold and and false otherwise.
bool lower(list[real] profile, list[real] thr){
    return profile[0]<=thr[0] && profile[1]<=thr[1] && profile[2]<=thr[2];
}

// Calculates level of the system (0-4, where 0 is the highest, 4 is the lowest) basing on its risk profile
// 0 ++
// 1 +
// 2 o
// 3 -
// 4 --
int levelByRiskProfile(list[real] profile){
    if(lower(profile, FIVE_STAR_RISK_PROFILE))
        return 0;
    if(lower(profile, FOUR_STAR_RISK_PROFILE))
        return 1;
    if(lower(profile, THREE_STAR_RISK_PROFILE))
        return 2;
    if(lower(profile, TWO_STAR_RISK_PROFILE))
        return 3;
        return 4;
}

// Input: 4 numbers: LOC in low risk zone; LOC in moderate risk zone; LOC in high risk zone; LOC in very high risk zone
// Output: risk profile
list[real] riskProfile(list[int] aNL){
    assert size(aNL) == 4;
    real totalLines = (aNL[0] + aNL[1] + aNL[2] + aNL[3])*1.0;
    return [aNL[1]*1.0/totalLines*100.0, aNL[2]*1.0/totalLines*100.0, aNL[3]*1.0/totalLines*100.0];
}