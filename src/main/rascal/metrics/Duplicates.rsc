module metrics::Duplicates

import IO;
import lang::java::m3::Core;
import lang::java::m3::AST;
import util::Math;
import Map;
import List;
import Set;
import String;

import utils::Helpers;
import utils::Calculator;
import utils::Logger;

import metrics::Volume;

import Constants;


/* Stringify the project, remove empty and import lines, divide into blocks, 
   found repeating lines in blocks and sum them up */
int countDuplicates(loc project) {
    list[list[str]] stringifiedProject = filterStringifiedProject(
        getStringifiedProject(project), [removeEmptyLines, removeImportLines]
    );

    map[str k, int v] codeBlocks = findDuplicates(stringifiedProject);
    return sum([v | k <- codeBlocks, v := codeBlocks[k]]);
}

real countDuplicatesPercentage(loc project) {
    int duplicates = countDuplicates(project);
    int totalLines = computeProjectMetric(project, countLines);
    return toReal(percent(duplicates, totalLines));
}

// Build a map of blocks of code and the number of duplicates found in them
map[str, int] findDuplicates(list[list[str]] project) {
    map[str, int] codeBlocks = ();
    for (file <- project) {
        bool inDuplicate = false;
        for (int i <- [0 .. size(file) - BLOCK_SIZE]) {
            str block = "";
            for (str part <- file[i .. i + BLOCK_SIZE]) {
                block += part;
            }

            int multiplier = (hasKey(codeBlocks, block) ? codeBlocks[block] : 0) == 0 ? 2 : 1;

            if (!hasKey(codeBlocks, block)) {
                codeBlocks[block] = 0;
                inDuplicate = false;
                continue;
            }

            if (!inDuplicate) {
                codeBlocks[block] += BLOCK_SIZE * multiplier;
                inDuplicate = true;
            } else {
                codeBlocks[block] += multiplier;
            }
        }
    }
    return codeBlocks;
}