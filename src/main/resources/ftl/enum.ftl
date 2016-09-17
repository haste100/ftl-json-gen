<#include "dml_json.ftl">
<#list objects as object>
//file ${object.objectName}.java
package ru.fccland.aki.report.enums;

/**
* Created by haste on 14.09.16.
*/
public enum ${object.objectName} {
    <#assign fields = object.fields >
    <#list fields as field>
        <#if !isNote(field) >
        <#if isDate(field)>
            <#assign paramNames = [
            "${getReportParamName(object, field)}_FROM",
            "${getReportParamName(object, field)}_TILL"
            ] />
        <#else>
            <#assign paramNames = [
            "${getReportParamName(object, field)}"
            ] />
        </#if>
        <#list paramNames as paramName>
    ${paramName?upper_case}{
        public String getName() {
            return "${paramName}";
        }
        public String getSqlName() {
            return "rki_engineer_${object.objectName?lower_case}.${getDbName(field)}";
        }
    },
        </#list>
        </#if>
    </#list>
    ;
    /**
    * Return field's  name
    *
    * @return name
    */
    public  String getName(){
        return null;
    }
    /**
    * Return sql field's  name
    *
    * @return name
    */
    public  String getSqlName(){
        return null;
    }

    /**
    * Return field's column name
    *
    * @return column name
    */
    public static String getColumName(){
        return ru.fccland.aki.report.facade.unreport.ReportColumn.ColumnName.${getReportName(object)}.getName();
    }

}   // end of enum ${object.objectName}

</#list>
