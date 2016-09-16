<#include "const.ftl" >
<#list objects as object>
    ${getReportName(object)} {
        public String getName() {
            return "${getReportName(object)}";
        }
    },
</#list>
