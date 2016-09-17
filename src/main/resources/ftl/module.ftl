<#list objects as object>
    <!-- ${object.objectName}SqlImpl for column from universal report  -->
    <bean id="ru.fccland.aki.report.unreport.${object.objectName}SqlImpl"
          class="ru.fccland.aki.report.impl.facade.unreport.column.${object.objectName}SqlImpl"
          parent="ru.fccland.aki.report.unreport.JasperQueryHelperImpl">
    </bean>
</#list>

<!-- properties fo bean id="ru.fccland.aki.report.unreport.UniversalReportManager" -->
<#list objects as object>
    <property name="${object.objectName?lower_case}Sql">
        <ref bean="ru.fccland.aki.report.unreport.${object.objectName}SqlImpl" />
    </property>
</#list>
