package com.kjt.service.common.dao.ibatis;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;

import com.kjt.service.common.dao.IBBatchDAO;
import com.kjt.service.common.dao.IModel;
import com.kjt.service.common.exception.DataAccessException;

/**
 * 主键缓存(pk)<br>
 * 应用场景:根据主键查询时使用。<br>
 * 查询执行步骤:<br>
 * 1. select * from loupan_basic where loupan_id=?;<br>
 * 2. 是否存在缓存，mc缓存key拼接规则{表名}+{recVersion}+{主键ID},
 * 如果存在直接返回结果，否则查询数据库，设置缓存并返回结果。例如：loupan_basic表主键mc缓存key:loupan_basic##2##1<br>
 * 更新执行步骤:<br>
 * 1. update loupan_basic set loupan_name=? where loupan_id=?;<br>
 * 2. 删除外键缓存。(如何删除外键缓存，下文有说明)<br>
 * 3. 删除对应的主键缓存<br>
 * 4. 更新updated版本号，删除cache_tags表缓存<br>
 * 
 * @author alexzhu
 *
 * @param <T>
 */

public abstract class AbsBigIIDIBatisDAOImpl<T extends IModel> extends AbsFKIBatisDAOImpl<T>
    implements IBigIBatisDAO<T>, IBBatchDAO<T> {

  @Cacheable(value = "defaultCache", key = PkCacheKeyPrefixExpress + "", unless = "#result == null", condition = "#root.target.cacheable()")
  @Override
  public T queryById(BigInteger id, String tabNameSuffix) {
    if (logger.isDebugEnabled()) {
      logger.debug("queryById(Long id={}, String tabNameSuffix={}) - start", id, tabNameSuffix); //$NON-NLS-1$
    }

    T returnT = queryById(id, false, tabNameSuffix);

    if (logger.isDebugEnabled()) {
      logger
          .debug(
              "queryById(Long id={}, String tabNameSuffix={}) - end - return value={}", id, tabNameSuffix, returnT); //$NON-NLS-1$
    }
    return returnT;

  }

  @Cacheable(value = "defaultCache", key = PkCacheKeyPrefixExpress + "", unless = "#result == null", condition = "!#master and #root.target.cacheable()")
  @Override
  public T queryById(BigInteger id, Boolean master, String tabNameSuffix) {
    if (logger.isDebugEnabled()) {
      logger
          .debug(
              "queryById(Long id={}, Boolean master={}, String tabNameSuffix={}) - start", id, master, tabNameSuffix); //$NON-NLS-1$
    }

    validate(id);
    Map<String, Object> params = new HashMap<String, Object>();
    params.put("id", id);

    params.put("tKjtTabName", this.get$TKjtTabName(tabNameSuffix));

    SqlSession session = SqlmapUtils.openSession(master ? this.getMasterDataSource()
        : getSlaveDataSource());
    try {
      IBigIMapper<T> mapper = session.getMapper(getMapperClass());
      List<T> objs = mapper.queryByMap(params);
      if (objs == null || objs.isEmpty()) {
        if (logger.isDebugEnabled()) {
          logger
              .debug(
                  "queryById(Long id={}, Boolean master={}, String tabNameSuffix={}) - end - return value={}", id, master, tabNameSuffix, null); //$NON-NLS-1$
        }
        return null;
      }
      T returnT = objs.get(0);

      if (logger.isDebugEnabled()) {
        logger
            .debug(
                "queryById(Long id={}, Boolean master={}, String tabNameSuffix={}) - end - return value={}", id, master, tabNameSuffix, returnT); //$NON-NLS-1$
      }
      return returnT;
    } catch (Exception t) {
      logger.error("queryById(Long, Boolean, String)", t); //$NON-NLS-1$

      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }

  @CacheEvict(value = "defaultCache", key = PkCacheKeyPrefixExpress + "", condition = "#root.target.cacheable()")
  @Override
  public Integer deleteById(BigInteger id, String tabNameSuffix) {
    if (logger.isDebugEnabled()) {
      logger.debug("deleteById(Long id={}, String tabNameSuffix={}) - start", id, tabNameSuffix); //$NON-NLS-1$
    }

    validate(id);

    Map<String, Object> params = new HashMap<String, Object>();
    params.put("id", id);
    params.put("tKjtTabName", this.get$TKjtTabName(tabNameSuffix));

    SqlSession session = SqlmapUtils.openSession(getMasterDataSource());
    try {
      IMapper<T> mapper = session.getMapper(getMapperClass());
      Integer eft = mapper.deleteByMap(params);
      if (eft > 0) {
        this.incrTabVersion(tabNameSuffix);
      }

      if (logger.isDebugEnabled()) {
        logger
            .debug(
                "deleteById(Long id={}, String tabNameSuffix={}) - end - return value={}", id, tabNameSuffix, eft); //$NON-NLS-1$
      }
      return eft;
    } catch (Exception t) {
      logger.error("deleteById(Long, String)", t); //$NON-NLS-1$

      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }

  @CacheEvict(value = "defaultCache", key = PkCacheKeyPrefixExpress + "", condition = "#root.target.cacheable()")
  @Override
  public Integer updateById(BigInteger id, Map<String, Object> newValue, String tabNameSuffix) {
    if (logger.isDebugEnabled()) {
      logger
          .debug(
              "updateById(Long id={}, Map<String,Object> newValue={}, String tabNameSuffix={}) - start", id, newValue, tabNameSuffix); //$NON-NLS-1$
    }

    validate(id);

    if (newValue == null || newValue.isEmpty()) {
      throw new DataAccessException(IBatisDAOException.MSG_1_0007);
    }
    newValue.put("id", id);
    newValue.put("tKjtTabName", this.get$TKjtTabName(tabNameSuffix));

    SqlSession session = SqlmapUtils.openSession(getMasterDataSource());
    try {
      IMapper<T> mapper = session.getMapper(getMapperClass());
      Integer eft = mapper.updateById(newValue);
      if (eft > 0) {
        this.incrTabVersion(tabNameSuffix);
      }

      if (logger.isDebugEnabled()) {
        logger
            .debug(
                "updateById(Long id={}, Map<String,Object> newValue={}, String tabNameSuffix={}) - end - return value={}", id, newValue, tabNameSuffix, eft); //$NON-NLS-1$
      }
      return eft;
    } catch (Exception t) {
      logger.error("updateById(Long, Map<String,Object>, String)", t); //$NON-NLS-1$

      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }

  protected void validate(BigInteger id) {
    if (logger.isDebugEnabled()) {
      logger.debug("validate(Long id={}) - start", id); //$NON-NLS-1$
    }

    if (id == null) {
      throw new DataAccessException(IBatisDAOException.MSG_1_0005);
    }

    if (logger.isDebugEnabled()) {
      logger.debug("validate(Long id={}) - end", id); //$NON-NLS-1$
    }
  }
  
  @Override
  public BigInteger[] batchInsert(List<Map<String,Object>> datas, String tabNameSuffix) {

    validate(datas);

    Map<String,Object> params = new HashMap<String,Object>();
    
    params.put("list", datas);
    params.put("tKjtTabName", this.get$TKjtTabName(tabNameSuffix));

    SqlSession session = SqlmapUtils.openSession(getMasterDataSource());
    try {
      IBigIMapper<T> mapper = session.getMapper(getMapperClass());
      Integer eft = mapper.batchInsert(params);
      if (eft > 0) {
        this.incrTabVersion(tabNameSuffix);
      }
      BigInteger[] rets = new BigInteger[eft];
      for(int i=0;i<eft;i++){
        rets[i]= (BigInteger)datas.get(i).get("id");
      }
      return rets;
    } catch (Exception t) {
      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }
}
