<#include "const.ftl">

${"<#assign sections_list = ["}
<#assign index=1 >
<#list objects as object>
"${getReportName(object)}"<#if (index < objects?size)>,</#if>
    <#assign index+=1 >
</#list>
${"] />"}

${"<#assign universal_report_date_param = ["}
<#list objects as object>
    <#list object.fields as field>
        <#if isDate(field)>
        "${getReportParamName(object, field)}_FROM",
        "${getReportParamName(object, field)}_TILL",
        </#if>
    </#list>
</#list>
${"] />"}

