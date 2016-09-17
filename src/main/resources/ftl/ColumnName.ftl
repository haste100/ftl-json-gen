<#include "dml_json.ftl" >
<#list objects as object>
    ${getReportName(object)} {
        public String getName() {
            return "${getReportName(object)}";
        }
    },
</#list>
