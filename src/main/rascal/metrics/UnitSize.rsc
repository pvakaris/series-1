module metrics::UnitSize

import IO;
import List;
import Set;
import String;
import Map;
import lang::java::m3::Core;
import lang::java::m3::AST;
import utils::Helpers;
import Constants;

// US means "unit size"

// This function transforms declarations from Java project into unit info.
// Input: all declarations from Java project
// Ouput: list of all units. For each unit the following information: number of lines of code, method location, method name
list[tuple[int, loc, str]] US_units(list[Declaration] asts)
{
    list[tuple[int, loc, str]] aUnit = [];
    visit(asts)
    {
        case \method(_, name, _, _, impl) :
        {
            tuple[int, loc, str] tmp = <impl.src.end.line-impl.src.begin.line+1, impl.src, name>;
            aUnit = aUnit + tmp;
        }
        case \constructor(_, _, _, _, impl) :
        {
            tuple[int, loc, str] tmp = <impl.src.end.line-impl.src.begin.line+1, impl.src, "">;
            aUnit = aUnit + tmp;
        }
    }
    return aUnit;
}

// Groups all units into for risk regions: without risk, moderate risk, high risk, very high risk
// Input: list of units
// Output: four lists of units (groupped by risk region)
list[list[tuple[int, loc, str]]] US_unitsByRiskRegions(list[tuple[int, loc, str]] aUnit)
{
    list[list[tuple[int, loc, str]]] ans = [[], [], [], []];
    for(unit <- aUnit)
    {
        if(<nLine, _, _> := unit)
        {
            if(nLine > UNIT_SIZE_VERY_HIGH_RISK_THR)
                ans[3] = ans[3] + unit;
            else if(nLine > UNIT_SIZE_HIGH_RISK_THR)
                ans[2] = ans[2] + unit;
            else if(nLine > UNIT_SIZE_MOD_RISK_THR)
                 ans[1] = ans[1] + unit;
            else
                 ans[0] = ans[0] + unit;
        }
    }
    assert size(aUnit) == (size(ans[0]) + size(ans[1]) + size(ans[2]) + size(ans[3]));
    return ans;
}

// Calculates number of lines in give list of units
int US_nLine(list[tuple[int, loc, str]] aUnit)
{
    int n = 0;
    for(unit <- aUnit)
    {
        if(<nLine, _, _> := unit)
        {
            n += nLine;
        }
    }
    return n;
}

list[int] US_nLineByRiskCat(loc project)
{
    list[Declaration] asts = getASTsDirectory(project);
    list[tuple[int, loc, str]] aUnit = US_units(asts);
    list[list[tuple[int, loc, str]]] aUnitGroupped = US_unitsByRiskRegions(aUnit);
    list[int] ans = [];
    for(list[tuple[int, loc, str]] group <- aUnitGroupped)
    {
        ans =  ans + US_nLine(group);
    }
    return ans;
}