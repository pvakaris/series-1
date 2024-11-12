module utils::Utils

import IO;
import List;
import lang::java::m3::Core;
import lang::java::m3::AST;

list[Declaration] getASTs(loc projectLocation) {
    M3 model = createM3FromMavenProject(projectLocation);
    list[Declaration] asts = [createAstFromFile(f, true) | f <- files(model.containment), isCompilationUnit(f)];
    return asts;
}