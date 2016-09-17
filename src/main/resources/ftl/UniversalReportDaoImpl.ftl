<#include "dml_json.ftl">
//query
<#list objects as object>
    static String ${object.objectName?upper_case}_QUERY = "SELECT * " +
        "FROM rki_engineer_${object.objectName?lower_case} " +
        "WHERE engineer_id IN (:ids) ";

</#list>

//rowMapper
<#list objects as object>
    RowMapper ${object.objectName?lower_case}RowMapper = new RowMapper() {
        public Engineer${object.objectName}VO mapRow(ResultSet rs, int rowNum) throws SQLException {
            Engineer${object.objectName}VO ${object.objectName?lower_case} = new Engineer${object.objectName}VO();
            ${object.objectName?lower_case}.setId(rs.getLong("id"));
            ${object.objectName?lower_case}.setEngineerId(rs.getLong("engineer_id"));
            ${object.objectName?lower_case}.setRegNumber(rs.getString("reg_number"));
    <#list object.fields as field>
        <#if isString(field)>
        ${object.objectName?lower_case}.set${getName(field)?cap_first}(rs.getString("${getDbName(field)}"));
        <#elseif isDate(field)>
        ${object.objectName?lower_case}.set${getName(field)?cap_first}(rs.getDate("${getDbName(field)}"));
        <#elseif isCombobox(field) >
        ${object.objectName?lower_case}.set${getName(field)?cap_first}(rs.getInt("${getDbName(field)}"));
        <#elseif isRadio(field) >
        ${object.objectName?lower_case}.set${getName(field)?cap_first}(rs.getInt("${getDbName(field)}") == 1);
        </#if>
    </#list>
            ${object.objectName?lower_case}.setCreatedDate(rs.getDate("created_date"));
            ${object.objectName?lower_case}.setModificationDate(rs.getDate("modification_date"));
            return ${object.objectName?lower_case};
        }
    };

</#list>

//getList
<#list objects as object>
    public List<Engineer${object.objectName}VO> get${object.objectName}List(List<Long> engineerIds){

        try{
            MapSqlParameterSource parameters = new MapSqlParameterSource();
            Set<Long> ids = new HashSet<Long>(engineerIds);

            parameters.addValue("ids", ids);

            @SuppressWarnings({ "unchecked" })
            List<Engineer${object.objectName}VO> resultList = namedParameterJdbcTemplate.query(${object.objectName?upper_case}_QUERY, parameters,
                ${object.objectName?lower_case}RowMapper);
            log.debug("${object.objectName}s count is "+resultList.size());
            return resultList;
        } catch (Exception e){
            log.error("UniversalReportDaoImpl.get${object.objectName}List error " + e);
        }
        return null;
    }

</#list>
