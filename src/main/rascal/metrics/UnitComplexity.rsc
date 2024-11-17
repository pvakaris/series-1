module metrics::UnitComplexity

import IO;
import List;
import Set;
import String;
import Map;
import lang::java::m3::Core;
import lang::java::m3::AST;
import utils::Helpers;
import Constants;

// CC means "cyclomatic complexity"

// This function is taken from article "Empirical analysis of the relationship between CC and SLOC in a large corpus of Java methods and C functions"
int calcCC(Statement impl){
    int result = 1;
    visit (impl){
        case \if(_, _) : result += 1;
        case \if(_, _, _) : result += 1;
        case \case(_) : result += 1;
        case \do(_, _) : result += 1;
        case \while(_, _) : result += 1;
        case \for(_, _, _) : result += 1;
        case \for(_, _, _, _) : result += 1;
        case foreach(_, _, _) : result += 1;
        case \catch(_, _) : result += 1;
        case \conditional(_, _, _) : result += 1;
        case \infix(_, "&&", _) : result += 1;
        case \infix(_, "||", _) : result += 1;
    }
    return result;
}

// This function transforms declarations from Java project into unit info.
// Input: all declarations from Java project
// Ouput: list of all units. For each unit the following information: number of lines of code, CC, method location, method name
list[tuple[int, int, loc, str]] CC_units(list[Declaration] asts){
    list[tuple[int, int, loc, str]] aUnit = [];
    visit(asts)
    {
        case \method(_, name, _, _, impl) :
        {
            tuple[int, int, loc, str] tmp = <impl.src.end.line-impl.src.begin.line+1, calcCC(impl), impl.src, name>;
            aUnit = aUnit + tmp;
        }
        case \constructor(_, _, _, _, impl) :
        {
            tuple[int, int, loc, str] tmp = <impl.src.end.line-impl.src.begin.line+1, calcCC(impl), impl.src, "">;
            aUnit = aUnit + tmp;
        }
    }
    return aUnit;
}

// Groups all units into for risk regions: without risk, moderate risk, high risk, very high risk
// Input: list of units
// Output: four lists of units (groupped by risk region)
list[list[tuple[int, int, loc, str]]] CC_unitsByRiskRegions(list[tuple[int, int, loc, str]] aUnit){
    list[list[tuple[int, int, loc, str]]] ans = [[], [], [], []];
    for(unit <- aUnit)
    {
        if(<_, CC, _, _> := unit)
        {
            if(CC > CC_VERY_HIGH_RISK_THR)
                ans[3] = ans[3] + unit;
            else if(CC > CC_HIGH_RISK_THR)
                ans[2] = ans[2] + unit;
            else if(CC > CC_MOD_RISK_THR)
                 ans[1] = ans[1] + unit;
            else
                 ans[0] = ans[0] + unit;
        }
    }
    assert size(aUnit) == (size(ans[0]) + size(ans[1]) + size(ans[2]) + size(ans[3]));
    return ans;
}

// Calculates number of lines in give list of units
int CC_nLine(list[tuple[int, int, loc, str]] aUnit){
    int n = 0;
    for(unit <- aUnit)
    {
        if(<nLine, _, _, _> := unit)
        {
            n += nLine;
        }
    }
    return n;
}

list[int] CC_nLineByRiskCat(loc project){
    list[Declaration] asts = getASTsDirectory(project);
    list[tuple[int, int, loc, str]] aUnit = CC_units(asts);
    list[list[tuple[int, int, loc, str]]] aUnitGroupped = CC_unitsByRiskRegions(aUnit);
    list[int] ans = [];
    for(list[tuple[int, int, loc, str]] group <- aUnitGroupped)
    {
        ans =  ans + CC_nLine(group);
    }
    return ans;
}