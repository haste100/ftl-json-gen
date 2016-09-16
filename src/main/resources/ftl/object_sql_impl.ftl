<#include "const.ftl" >
<#list objects as object>
//file ${object.objectName}SqlImpl.java
package ru.fccland.aki.report.impl.facade.unreport.column;

import ru.fccland.aki.report.enums.${object.objectName};
import ru.fccland.aki.report.facade.unreport.SqlManager;
import ru.fccland.aki.report.exception.ParamTypeException;

import java.util.Date;
import java.util.Map;
import java.util.Map.Entry;

/**
* Created by haste on 14.09.16.
*/
public class ${object.objectName}SqlImpl extends JasperQueryHelperImpl implements SqlManager {

    static final String ${object.objectName?upper_case} = " LEFT JOIN rki_engineer_${object.objectName?lower_case} " +
    " ON rki_engineer_${object.objectName?lower_case}.engineer_id=eng.id ";
    
    Map<String, Object> params;
    
    public String getSqlbody() {
        return ${object.objectName?upper_case};
    }
    
    public String getSqlParams() {
        StringBuffer sb = new StringBuffer("");
        if (params != null && !params.isEmpty()){
            for (Entry<String, Object> entry : params.entrySet() ) {
                Object paramValue = entry.getValue();
                String paramName = entry.getKey();
                //if (paramValue != null)	log.info("entry.getValue(): " + entry.getValue().toString());
                if (entry.getValue() != null){
                    try{
    <#list object.fields as field>
        <#if !isNote(field) >
        <#if isString(field) >
                        if (entry.getKey().equals(${getEnumName(object, field)}.getName())){
                            appendLikeCondition(sb, " AND ", ${getEnumName(object, field)}.getSqlName(), paramName, paramValue.toString());
                        }
        <#elseif isCombobox(field) >
                        if (entry.getKey().equals(${getEnumName(object, field)}.getName())){
                            sb.append(" AND " + ${getEnumName(object, field)}.getSqlName() + " = " +   paramValue.toString() + " ");
                        }
        <#elseif isDate(field) >
                        if (entry.getKey().equals(${getEnumName(object, field)}_FROM.getName())){
                            appendDateCondition(sb, " AND ", ${getEnumName(object, field)}_FROM.getSqlName(),  ">=", paramName, (Date) paramValue);
                        }
                        if (entry.getKey().equals(${getEnumName(object, field)}_TILL.getName())){
                            appendDateCondition(sb, " AND ", ${getEnumName(object, field)}_TILL.getSqlName(),  "<=", paramName, (Date) paramValue);
                        }
        <#else>
        /* ERROR - undefined field type - ${getType(field)}        */
        </#if>
        </#if>
    </#list>
                    } catch (Exception e) {
                        throw new ParamTypeException("${object.objectName?lower_case}Sql prepared params error", e);
                    }
                }
            }
            //log.info("${object.objectName?lower_case}Sql sb.toString()" + sb.toString());
            
        }
        return sb.toString();
    }
    
    public Map<String, Object> getParams() {
        return params;
    }
    
    public void setParams(Map<String, Object> params) {
        this.params = params;
    }
    
    public String getColumnName() {
        return ${object.objectName}.getColumName();
    }

}// end of ${object.objectName}SqlImpl

</#list>