package com.kjt.service.common.auth;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

/**
 * 资源服务层
 * @author willenfoo
 * @author alexzhu modify
 *
 */
public interface ResourcesService  {
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> insert(Map<String, Object> params);
	
	/**
	 * 根据id更新数据
	 * @param dto
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> updateById(Map<String, Object> params);
	
	/**
	 * 根据id删除数据
	 * @param dto
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> deleteById(BigInteger id);
	
	/**
	 * 根据条件查询数据
	 * @param params
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> selectList(Map<String, Object> params);
	
	/**
	 * 根据条件查询数据，支持分页
	 * @param params
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> selectList(Map<String, Object> params, int offset, int pageSize);
	
	/**
	 * 根据角色id集合，查询所有角色下可以访问的资源
	 * @param roleIds
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> selectByRoleIds(List<BigInteger> roleIds);
	 
	/**
	 * 根据id查询数据
	 * @param id
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> selectById(BigInteger id);

	/**
	 * 保存    角色与资源 关系
	 * @param bigInteger
	 * @param resourcesIds
	 * @return
	 */
	public AuthResponse<AuthResourcesDto> saveRoleResources(BigInteger roleId,
			BigInteger[] resourcesIds);
	
	/**
	 * 是否允许删除
	 * @param id
	 * @return
	 */
	public boolean isAllowDelele(BigInteger id);
}