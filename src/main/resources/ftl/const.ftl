<#assign FIELD_DESC = 0>
<#assign FIELD_NAME = 1>
<#assign FIELD_TYPE = 2>
<#assign FIELD_DB_NAME = 3>
<#assign FIELD_WIDTH = 4>

<#-- field functions -->
<#function isCombobox field>
    <#return "CBX" = getType(field) >
</#function>

<#function isString field >
    <#return "STR" = getType(field) >
</#function>

<#function isDate field >
    <#return "DATE" = getType(field) >
</#function>

<#function getType field >
    <#return field[FIELD_TYPE] >
</#function>

<#function getDbName field >
    <#return field[FIELD_DB_NAME] >
</#function>

<#function getDesc field >
    <#return field[FIELD_DESC] >
</#function>

<#function getName field >
    <#return field[FIELD_NAME] >
</#function>

<#function getWidth field>
    <#return field[FIELD_WIDTH]?number >
</#function>

<#function isNote field >
    <#return "note" = getName(field) >
</#function>

<#function getEnumName object field>
    <#return object.objectName+"."+getReportParamName(object, field)>
</#function>

<#function getReportParamName object field>
    <#return getReportName(object) +"__"+ getName(field)?upper_case>
</#function>

<#-- object functions -->
<#function getReportName object>
    <#return object.objectName?upper_case+"S_REPORT">
</#function>

<#function getObjectWidth object>
    <#assign result = 0 />
    <#list object.fields as field>
        <#assign result += getWidth(field) />
    </#list>
    <#return result>
</#function>

