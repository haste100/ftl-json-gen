<#include "const.ftl" >
<#list objects as object>
<parameter name="${getReportName(object)}" class="java.lang.Boolean" isForPrompting="false">
    <parameterDescription><![CDATA[Раздел ${object.name}]]></parameterDescription>
    <defaultValueExpression><![CDATA[false]]></defaultValueExpression>
</parameter>
    <#assign fields = object.fields >
    <#list fields as field>
        <#if !isNote(field) >
        <#if isString(field) >
<parameter name="${getReportParamName(object, field)}" class="java.lang.String" isForPrompting="false">
    <parameterDescription><![CDATA[${getDesc(field)}]]></parameterDescription>
    <defaultValueExpression><![CDATA[]]></defaultValueExpression>
</parameter>
        <#elseif isCombobox(field) >
<parameter name="${getReportParamName(object, field)}" class="java.lang.String" isForPrompting="false">
    <parameterDescription><![CDATA[${getDesc(field)}]]></parameterDescription>
    <defaultValueExpression><![CDATA[]]></defaultValueExpression>
</parameter>
        <#elseif isDate(field)>
<parameter name="${getReportParamName(object, field)}_FROM" class="java.util.Date" isForPrompting="false">
    <parameterDescription><![CDATA[${getDesc(field)} с]]></parameterDescription>
    <defaultValueExpression><![CDATA[new Date()]]></defaultValueExpression>
</parameter>
<parameter name="${getReportParamName(object, field)}_TILL" class="java.util.Date" isForPrompting="false">
    <parameterDescription><![CDATA[${getDesc(field)} по]]></parameterDescription>
    <defaultValueExpression><![CDATA[new Date()]]></defaultValueExpression>
</parameter>
        </#if></#if>
    </#list>
</#list>