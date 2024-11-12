module Main

import IO;
import List;
import Set;
import String;
import Map;
import lang::java::m3::Core;
import lang::java::m3::AST;

// To test whether the project works with relative paths
void testMethod() {
    println("Test method started. Calculating the total number of declarations.");
    loc projectLocation = |cwd:///test-projects/smallsql0.21_src|; 
    list[Declaration] asts = getASTs(projectLocation); 
    println("Total number of declarations is: <size(asts)>");
}

list[Declaration] getASTs(loc projectLocation) {
    M3 model = createM3FromMavenProject(projectLocation);
    list[Declaration] asts = [createAstFromFile(f, true) | f <- files(model.containment), isCompilationUnit(f)];
    return asts;
}

list[Declaration] smallSQLASTs() {
    return getASTs(|cwd:///test-projects/smallsql0.21_src|);
}

int getNumberOfInterfaces(list[Declaration] asts) {
    int interfaces = 0;
    visit(asts) {
        case \interface(_, _, _, _): interfaces += 1;
    }
    return interfaces;
}

int getNumberOfForLoops(list[Declaration] asts) {
    int count = 0;
    visit (asts) {
        case \for(_, _, _): count += 1;
        case \for(a, b, c, d): {
            if (\infix(l, op, r) := b) {
                if (\simpleName(n) := l) {
                    print("Left part is: ");
                    println(n);
                }
                print("Middle part is: ");
                println(op);
                if (\methodCall(_, _, name, arg):=r) {
                    print("Last part is: ");
                    print(name);
                    print(" with arguments:");
                    list[Expression] ty = arg;
                    for (a <- ty) {
                        print(a);
                        print(" ");
                    }
                    print("\n");
                }
                println("\n");
            }
            count += 1;
        }
        case foreach(_, _, _): count += 1;
    }
    return count;
}

list[str] varNames(list[Declaration] asts) {
    list[str] names = [];
    visit (asts) {
        case \variable(name, _) : names = names + [name];
        case \variable(name, _, _) : names = names + [name];
    }
    return names;
}

tuple[int, list[str]] mostOccurringVariables(list[Declaration] asts) {
    map[str, int] mp = ();
    for (sr <- varNames(asts)) {
        mp[sr] = 0;
    }

    for (sr <- varNames(asts)) {
        mp[sr] = mp[sr] + 1;
    }

    int maxx = 0;
    for (sr <- domain(mp)) {
        i = mp[sr]; {
            if(i > maxx) {
                maxx = i;
            }
        }
    }

    list[str] ans = [];
    for (sr <- domain(mp)) {
        i = mp[sr]; {
            if (i == maxx) {
                ans = ans + sr;
            }
        }
    }

    return <maxx, ans>;
}

tuple[int, list[str]] mostOccurringNumber(list[Declaration] asts)
{
    map[str, int] mp;
    mp = (" ": -1);
    delete(mp, " ");
    visit (asts) {
        case \number(numberValue): {
            if (!(mp[numberValue]?)) {
                mp[numberValue] = 1;
            }
            else {
                mp[numberValue] = mp[numberValue] + 1;
            }
        }
    }

    int maxx = 0;
    for(sr <- domain(mp)) {
        if (mp[sr] > maxx) maxx = mp[sr];
    }

    list[str] ans = [];
    for (sr <- domain(mp)) {
        if (mp[sr] == maxx) ans = ans + sr;
    }

    return <maxx, ans>;
}

list[loc] findNullReturned(list[Declaration] asts) {
    list[loc] ans = [];
    visit (asts) {
        case \return(expr): {
            if (\null() := expr) {
                ans = ans + expr.src;
            }
        }
    }
    return ans;
}

void printASS(list[Declaration] asts) {
    visit (asts) {
        case ass:\assignment(_, _, r) : {
            if (\null():=r) {
                println(ass.src);
                println("\n");
            }
        }
    }
}

void printF(list[Declaration] asts) {
    visit (asts) {
        case f:\variables(_, _) : {
            if (f.src != |unknown:///|) {
                println(f.src);
                println("\n");
            }
        }
    }
}

test bool mon() {
    return mostOccurringNumber(smallSQLASTs()) == <1382, ["0"]>;
}

// Assignment 1
// Input data for unit size analysis is list[Declaration] - result of Java project analyzation.

// This function transforms declarations from Java project into unit info.
// Input: all declarations form Java project
// Ouput: list of all units. For each unit the following information: number of lines of code, method location, method name
list[tuple[int, loc, str]] units(list[Declaration] asts) {
    list[tuple[int, loc, str]] aUnit = [];
    visit (asts) {
        case met:\method(_, name, _, _, impl) : {
            int l1 = impl.src.begin.line;
            int l2 = impl.src.end.line;
            tuple[int, loc, str] tmp = <l2-l1+1, impl.src, name>;
            aUnit = aUnit + tmp;
        }
    }
    return aUnit;
}

// Groups all units into for risk regions: without risk, moderate risk, high risk, very high risk
// Input: list og units
// Output: four lists of units (groupped by risk region)
list[list[tuple[int, loc, str]]] unitsByRiskRegions(list[tuple[int, loc, str]] aUnit) {
    int thr1 = 10;
    int thr2 = 20;
    int thr3 = 50;
    
    list[list[tuple[int, loc, str]]] ans = [[], [], [], []];
    for (unit <- aUnit) {
        if (<nLine, _, _> := unit) {
            if (nLine > thr3)
                ans[3] = ans[3] + unit;
            else if (nLine > thr2)
                ans[2] = ans[2] + unit;
            else if (nLine > thr1)
                 ans[1] = ans[1] + unit;
            else
                 ans[0] = ans[0] + unit;
        }
    }
    assert size(aUnit) == (size(ans[0]) + size(ans[1]) + size(ans[2]) + size(ans[3]));
    return ans;
}

// Calculates number of lines in give list of units
int nLine(list[tuple[int, loc, str]] aUnit) {
    int n = 0;
    for (unit <- aUnit) {
        if (<nLine, _, _> := unit) {
            n += nLine;
        }
    }
    return n;
}

// Calculates risk profile of given set of units: 3 numbers:
// percentage of code in moderate risk zone
// percentage of code in high risk zone
// percentage of code in very high risk zone
list[real] riskProfile(list[tuple[int, loc, str]] aUnit) {
    list[list[tuple[int, loc, str]]] unitsGroupped = unitsByRiskRegions(aUnit);
    list[real] nL = [];
    for (list[tuple[int, loc, str]] a <- unitsGroupped) {
        real tmp = nLine(a)*1.0;
        nL = nL + tmp;
    }
    assert size(nL) == 4;
    real totalLines = nL[0] + nL[1] + nL[2] + nL[3];
    return [nL[1]/totalLines*100.0, nL[2]/totalLines*100.0, nL[3]/totalLines*100.0];
}

// util function
bool lower(list[real] profile, list[real] comp) {
    return profile[0]<=comp[0] && profile[1]<=comp[1] && profile[2]<=comp[2];
}

// Calculates level of the system (1-5, where 5 is the highest, 1 is the lowest) basing on its risk profile
// 5 ++
// 4 +
// 3 o
// 2 -
// 1 --
int level(list[real] profile) {
    if (lower(profile, [25.0, 0.0, 0.0]))
        return 5;
    if (lower(profile, [30.0, 5.0, 0.0]))
        return 4;
    if (lower(profile, [40.0, 10.0, 0.0]))
        return 3;
    if (lower(profile, [50.0, 15.0, 5.0]))
        return 2;
        return 1;
}

// diagnostic tool. Prints locations of given units
void printLoc(list[tuple[int, loc, str]] aUnit) {
    for (unit <- aUnit) {
        if (<_, l, _> := unit) {
            println(l);
        }
    }
}

// Assesses system risk profile
list[real] systemRiskProfile(list[Declaration] asts) {
    list[tuple[int, loc, str]] aUn = units(asts);
    return riskProfile(aUn);
}

// Assesses system level from unit size point of view
int systemLevel(list[Declaration] asts) {
    list[real] prof = systemRiskProfile(asts);
    return level(prof);
}

// Diagnostic tool. Prints locations of units with very high risk
void printVH(list[Declaration] asts) {
    list[tuple[int, loc, str]] aUn = units(asts);
    list[list[tuple[int, loc, str]]] aGr = unitsByRiskRegions(aUn);
    printLoc(aGr[3]);
}

// Diagnostic tool. Prints locations of units with high risk
void printH(list[Declaration] asts) {
    list[tuple[int, loc, str]] aUn = units(asts);
    list[list[tuple[int, loc, str]]] aGr = unitsByRiskRegions(aUn);
    printLoc(aGr[2]);
}

// Diagnostic tool. Prints locations of units with very moderate risk
void printM(list[Declaration] asts) {
    list[tuple[int, loc, str]] aUn = units(asts);
    list[list[tuple[int, loc, str]]] aGr = unitsByRiskRegions(aUn);
    printLoc(aGr[1]);
}