<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
    PUBLIC "-//ibatis.apache.org//DTD Mapper 3.0//EN"
    "http://ibatis.apache.org/dtd/ibatis-3-mapper.dtd">

<mapper namespace="${package}.dao.ibatis.mapper.${name}Mapper">
	<resultMap id="${name}RslMap" type="${package}.dao.model.${name}">		
		
		<#list cols as col>
			<#if col.isPK="yes" && tab.pkFieldNum==1>
			<#if col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double">
			<id property="id" column="${col.name}" />
			<#else>
			<id property="ids" column="${col.name}" />
			</#if>
			<#else>
			<result property="${col.fieldName}" column="${col.name}" />
			</#if>
		</#list>
	</resultMap>

	<select id="queryById" parameterType="java.util.Map" resultMap="${name}RslMap">
		SELECT
		<#list colMaps as col>
			${col.name}<#if col_has_next>,</#if>
		</#list>
		FROM
			${r"${$TKjtTabName}"}
		<where>
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if col.isPK="yes" &&   (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			and ${col.name}=${r"#{id}"}
			<#elseif col.isPK="yes" &&  col.type.javaType="String">
			and ${col.name}=${r"#{ids}"}
			</#if>
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>
			</#list>
			</#if>
		</where>
			limit 1
	</select>

	<select id="queryByMap" parameterType="java.util.Map" resultMap="${name}RslMap">				
		SELECT
		<#list colMaps as col>
			${col.name}<#if col_has_next>,</#if>
		</#list>
		FROM
			${r"${$TKjtTabName}"}
		<where>
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if tab.pkFieldNum==1 && col.isPK="yes" &&   (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<if test="id !=  null">
				and ${col.name}=${r"#{id}"}
			</if>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<if test="ids !=  null">
				and ${col.name}=${r"#{ids}"}	
			</if>
			<#else>
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>
			</#list>
			</#if>
		</where>
		
	</select>
	
	<select id="queryIdsByMap" parameterType="java.util.Map" resultType="java.lang.Long">				
		SELECT
		<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			${col.name}
			<#elseif col.isPK="yes" &&  col.type.javaType="String">
			${col.name}
			</#if>
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
				${col.name}
			</#if>
			</#list>
			</#if>
		FROM
			${r"${$TKjtTabName}"}
		<where>
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if tab.pkFieldNum==1 && col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<if test="id !=  null">
				and ${col.name}=${r"#{id}"}
			</if>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<if test="ids !=  null">
				and ${col.name}=${r"#{ids}"}	
			</if>
			<#else>
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>
			</#list>
			</#if>
		</where>
		
	</select>
	
	<select id="countByMap" parameterType="java.util.Map" resultType="java.lang.Integer">				
		SELECT
			count(*)
		FROM
			${r"${$TKjtTabName}"}
		<where>			
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<if test="id !=  null">
				and ${col.name}=${r"#{id}"}
			</if>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<if test="ids !=  null">
				and ${col.name}=${r"#{ids}"}		
			</if>
			<#else>
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>
			</#list>
			</#if>
		</where>
				
	</select>
	
	<select id="pageQuery" parameterType="com.kjt.service.common.dao.Page" resultMap="${name}RslMap" fetchSize="15">
		SELECT
			<#list colMaps as col>
			${col.name}<#if col_has_next>,</#if>
			</#list>
		FROM
			${r"${$TKjtTabName}"}
		<where>
			<if test="params !=  null">
				<#if tab.pkFieldNum==1>
				<#list colMaps as col>
				<#if tab.pkFieldNum==1 && col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
				<if test="params.id !=  null">
					and ${col.name}=${r"#{params.id"}${r"}"}
				</if>
				<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
				<if test="params.ids !=  null">
					and ${col.name}=${r"#{params.ids"}${r"}"}
				</if>
				<#else>
				<if test="${r"params."}${col.fieldName} !=  null">
					and ${col.name}=${r"#{params."}${col.fieldName}${r"}"}
				</if>
				</#if>			
				</#list>
				<#else>			
				<#list colMaps as col>
				<#if col.isPK="yes">
				<if test="${r"params."}${col.fieldName} !=  null">
					and ${col.name}=${r"#{params."}${col.fieldName}${r"}"}
				</if>
				</#if>
				</#list>
				</#if>
			</if>
		</where>
			<if test="${r"#{orders}"} !=  null"> order by ${r"#{orders}"} </if> limit ${r"#{start}"},${r"#{end}"}
	</select>

	<insert id="insert" parameterType="${package}.dao.model.${name}" useGeneratedKeys="true" keyProperty="id">
		INSERT INTO	${r"${$TKjtTabName}"}
			(<#list colMaps as col>${col.name}<#if col_has_next>,</#if></#list>)
			VALUES(<#list colMaps as col><#if col.isPK="no">${r"#{model."}${col.fieldName}${r"}"}<#elseif col.isPK="yes" && tab.pkFieldNum==1  &&  col.type.javaType="Integer">${r"#{model.id}"}<#elseif col.isPK="yes" && tab.pkFieldNum==1  &&  col.type.javaType="String">${r"#{model.ids}"}<#else>${r"#{model."}${col.fieldName}${r"}"}</#if><#if col_has_next>,</#if></#list>)
	</insert>
	
	<update id="updateByMap" parameterType="java.util.Map">
		update 
			${r"${$TKjtTabName}"}
		<set> 
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if tab.pkFieldNum==1 && col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<#else>
			<if test="${col.fieldName} !=  null">			        
				${col.name}=${r"#{"}${col.fieldName}${r"}"},
			</if>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${col.fieldName} !=  null">			        
				${col.name}=${r"#{"}${col.fieldName}${r"}"},
			</if>
			</#if>
			</#list>
			</#if>
		</set>
		<where>
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if tab.pkFieldNum==1 && col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<if test="id !=  null">
				and ${col.name}=${r"#{id}"}
			</if>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<if test="ids !=  null">
				and ${col.name}=${r"#{ids}"}	
			</if>
			<#else>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>
			</#list>
			</#if>
		</where>
		
	</update>
	
	<update id="cmplxUpdate" parameterType="java.util.Map">
		update 
			${r"${$TKjtTabName}"}
		<set>
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if tab.pkFieldNum==1 && col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<if test="updNewMap.id !=  null">
				${col.name}=${r"#{updNewMap.id"}${r"}"},
			</if>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<if test="updNewMap.ids !=  null">
				${col.name}=${r"#{updNewMap.ids"}${r"}"},
			</if>
			<#else>
			<if test="${r"updNewMap."}${col.fieldName} !=  null">
				${col.name}=${r"#{updNewMap."}${col.fieldName}${r"}"},
			</if>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${r"updNewMap."}${col.fieldName} !=  null">
				${col.name}=${r"#{updNewMap."}${col.fieldName}${r"}"},
			</if>
			</#if>
			</#list>
			</#if>			
		</set>
		<where>
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if tab.pkFieldNum==1 && col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<if test="updCondMap.id !=  null">
				and ${col.name}=${r"#{updCondMap.id"}${r"}"}
			</if>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<if test="updCondMap.ids !=  null">
				and ${col.name}=${r"#{updCondMap.ids"}${r"}"}
			</if>
			<#else>
			<if test="${r"updCondMap."}${col.fieldName} !=  null">
				and ${col.name}=${r"#{updCondMap."}${col.fieldName}${r"}"}
			</if>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${r"updCondMap."}${col.fieldName} !=  null">
				and ${col.name}=${r"#{updCondMap."}${col.fieldName}${r"}"}
			</if>
			</#if>
			</#list>
			</#if>		
		</where>
		
	</update>
	
	<delete id="deleteByMap" parameterType="java.util.Map">		
		DELETE
		FROM
			${r"${$TKjtTabName}"} 
		<where>
			<#if tab.pkFieldNum==1>
			<#list colMaps as col>
			<#if tab.pkFieldNum==1 && col.isPK="yes" &&  (col.type.javaType="Integer" || col.type.javaType="Long" || col.type.javaType="Float" || col.type.javaType="Double")>
			<if test="id !=  null">
				and ${col.name}=${r"#{id}"}
			</if>
			<#elseif tab.pkFieldNum==1 && col.isPK="yes"  &&  col.type.javaType="String">
			<if test="ids !=  null">
				and ${col.name}=${r"#{ids"}${r"}"}
			</if>
			<#else>
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>			
			</#list>
			<#else>			
			<#list colMaps as col>
			<#if col.isPK="yes">
			<if test="${col.fieldName} !=  null">			        
				and ${col.name}=${r"#{"}${col.fieldName}${r"}"}
			</if>
			</#if>
			</#list>
			</#if>		
		</where>
		
	</delete>
</mapper>
