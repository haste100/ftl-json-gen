<#include "dml_json.ftl" >
//properties
<#list objects as object>
    SqlManager ${object.objectName?lower_case}Sql;
</#list>

//for init method
<#list objects as object>
    notNull(${object.objectName?lower_case}Sql, "required property ${object.objectName?lower_case}Sql");
</#list>

//for getMainSql method
<#list objects as object>
if (paramName.equals(ColumnName.${getReportName(object)}.getName())) {
    ${object.objectName?lower_case}Sql.setParams(paramValue);
    if (${object.objectName?lower_case}Sql.getSqlParams() != null) {
        prepareSQLService.add(${object.objectName?lower_case}Sql);
        log.info("UniversalReportMangImpl getMainSql added ${object.objectName?lower_case}Sql");
    }
}
</#list>

//setters
<#list objects as object>
    public void set${object.objectName}Sql(SqlManager ${object.objectName?lower_case}Sql) {
        this.${object.objectName?lower_case}Sql=${object.objectName?lower_case}Sql;
    }
</#list>
