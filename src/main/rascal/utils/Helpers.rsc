module utils::Helpers

import IO;
import List;
import lang::java::m3::Core;
import lang::java::m3::AST;

list[Declaration] getASTs(loc project) {
    M3 model = createM3FromMavenProject(project);
    list[Declaration] asts = [createAstFromFile(f, true) | f <- files(model.containment), isCompilationUnit(f)];
    return asts;
}

list[Declaration] getASTsDirectory(loc directory) {
    M3 model = createM3FromDirectory(directory);
    list[Declaration] asts = [createAstFromFile(f, true) | f <- files(model.containment), isCompilationUnit(f)];
    return asts;
}

// Fun the function on all files in the project
int computeProjectMetric(loc project, int (loc) function) {
    M3 projectModel = createM3FromMavenProject(project);
    int totalMetric = 0;
    for (file <- files(projectModel.containment)) {
        totalMetric += function(file.top);
    }
    return totalMetric;
}

// Run the function on one file
int computeFileMetric(loc file, int (loc) function) {
    return function(file);
}

