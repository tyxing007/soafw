package com.kjt.common.cache.dao.ibatis;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.kjt.common.cache.dao.ICacheVersionDAO;
import com.kjt.common.cache.dao.ibatis.mapper.CacheVersionMapper;
import com.kjt.common.cache.dao.model.CacheVersion;
import com.kjt.service.common.dao.ibatis.AbsStrIDIBatisDAOImpl;
import com.kjt.service.common.dao.ibatis.IBatisDAOException;
import com.kjt.service.common.dao.ibatis.ISMapper;
import com.kjt.service.common.dao.ibatis.SqlmapUtils;
import com.kjt.service.common.exception.DataAccessException;

@Repository("CacheVersion")
public class CacheVersionIbatisDAOImpl extends AbsStrIDIBatisDAOImpl<CacheVersion> implements
    ICacheVersionDAO<CacheVersion> {

  @Resource(name = "cache_db")
  private DataSource masterDataSource;

  @Resource(name = "cache_db_slave")
  private DataSource slaveDataSource;

  @Resource(name = "cache_db_map_query")
  private DataSource mapQueryDataSource;

  public CacheVersionIbatisDAOImpl() {
  }

  @Override
  public Class<CacheVersionMapper> getMapperClass() {

    return CacheVersionMapper.class;
  }

  @Override
  public Class<CacheVersion> getModelClass() {

    return CacheVersion.class;
  }

  @Override
  public boolean isFk(String property) {

    return CacheVersion.isFk(property);
  }

  public String getTableName() {
    return "soa_cache_version";
  }

  @Override
  public DataSource getMasterDataSource() {
    return masterDataSource;
  }

  @Override
  public DataSource getSlaveDataSource() {
    if (slaveDataSource == null) {
      return masterDataSource;
    }
    return slaveDataSource;
  }

  @Override
  public DataSource getMapQueryDataSource() {
    if (mapQueryDataSource == null) {
      return getSlaveDataSource();
    }
    return mapQueryDataSource;
  }

  public String insert(CacheVersion model, String tabNameSuffix) {
    if (logger.isDebugEnabled()) {
      logger.debug("insert(T model={}, String tabNameSuffix={}) - start", model, tabNameSuffix); //$NON-NLS-1$
    }

    validate(model);

    model.setTKjtTabName(this.get$TKjtTabName(tabNameSuffix));

    SqlSession session = SqlmapUtils.openSession(getMasterDataSource());
    try {
      ISMapper<CacheVersion> mapper = session.getMapper(getMapperClass());

      Long id = mapper.insert(model);
      if (id != null) {
        this.incrTabVersion(tabNameSuffix);
      }

      if (logger.isDebugEnabled()) {
        logger
            .debug(
                "insert(T model={}, String tabNameSuffix={}) - end - return value={}", model, tabNameSuffix, id); //$NON-NLS-1$
      }
      return model.getId();
    } catch (Exception t) {
      logger.error("insert(T, String)", t); //$NON-NLS-1$
      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }

  @Cacheable(value = "defaultCache", key = CacheKeyPrefixExpress, unless = "#result == null", condition = "#root.target.cacheable()")
  @Override
  public CacheVersion queryById(String id, String tabNameSuffix) {
    return super.queryById(id, tabNameSuffix);
  }

  @Cacheable(value = "defaultCache", key = CacheKeyPrefixExpress + "", unless = "#result == null", condition = "!#master and #root.target.cacheable()")
  @Override
  public CacheVersion queryById(String id, Boolean master, String tabNameSuffix) {
    return super.queryById(id, master, tabNameSuffix);
  }

  @CacheEvict(value = "defaultCache", key = CacheKeyPrefixExpress, condition = "#root.target.cacheable()")
  public int incrObjVersion(String id, String tabNameSuffix) {
    validate(id);
    CacheVersion model = new CacheVersion();
    model.setId(id);
    model.setTKjtTabName(this.get$TKjtTabName(tabNameSuffix));
    SqlSession session = SqlmapUtils.openSession(getMasterDataSource());
    try {
      CacheVersionMapper mapper = session.getMapper(getMapperClass());
      Integer eft = mapper.incrVersion(model);

      return eft;
    } catch (Exception t) {
      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }

  @CacheEvict(value = "defaultCache", key = CacheKeyPrefixExpress, condition = "#root.target.cacheable()")
  public int incrObjRecVersion(String id, String tabNameSuffix) {
    validate(id);

    CacheVersion model = new CacheVersion();
    model.setId(id);
    model.setTKjtTabName(this.get$TKjtTabName(tabNameSuffix));

    SqlSession session = SqlmapUtils.openSession(getMasterDataSource());
    try {
      CacheVersionMapper mapper = session.getMapper(getMapperClass());
      Integer eft = mapper.incrRecVersion(model);

      return eft;
    } catch (Exception t) {
      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }

  @CacheEvict(value = "defaultCache", key = CacheKeyPrefixExpress, condition = "#root.target.cacheable()")
  public int incrObjTabVersion(String id, String tabNameSuffix) {
    validate(id);

    CacheVersion model = new CacheVersion();
    model.setId(id);
    model.setTKjtTabName(this.get$TKjtTabName(tabNameSuffix));

    SqlSession session = SqlmapUtils.openSession(getMasterDataSource());
    try {
      CacheVersionMapper mapper = session.getMapper(getMapperClass());
      Integer eft = mapper.incrTabVersion(model);

      return eft;
    } catch (Exception t) {
      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
    } finally {
      session.commit();
      session.close();
    }
  }

  protected void validate(String id) {
    if (id == null || id.trim().length() == 0) {
      throw new DataAccessException(IBatisDAOException.MSG_1_0004);
    }
  }
}
