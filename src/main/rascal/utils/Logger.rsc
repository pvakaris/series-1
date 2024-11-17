module utils::Logger

import IO;
import String;
import DateTime;

void log(str message) {
    println(message);
}

void log(value val) {
    println("<val>");
}

void logDashedLine() {
    println("------------------------------------------------");
}

void logEmptyLine() {
    println("");
}

void logDuration(str title, Duration dur) {
     str result = "";
    
    if (dur.years != 0) {
        result += "<dur.years> years ";
    }
    if (dur.months != 0) {
        result += "<dur.months> months ";
    }
    if (dur.days != 0) {
        result += "<dur.days> days ";
    }
    if (dur.hours != 0) {
        result += "<dur.hours> h ";
    }
    if (dur.minutes != 0) {
        result += "<dur.minutes> min ";
    }
    if (dur.seconds != 0) {
        result += "<dur.seconds> s ";
    }
    if (dur.milliseconds != 0) {
        result += "<dur.milliseconds> ms";
    }
    
    log("<title> <trim(result)>");
}