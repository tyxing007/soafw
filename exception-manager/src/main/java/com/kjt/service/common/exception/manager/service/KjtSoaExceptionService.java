package com.kjt.service.common.exception.manager.service;

import com.kjt.service.common.exception.manager.dao.KjtExceptionDao;
import com.kjt.service.common.exception.manager.dao.KjtSoaSpDao;
import com.kjt.service.common.exception.manager.model.KjtException;

import java.util.List;

/**
 * Created by kevin on 15/1/13.
 */
public class KjtSoaExceptionService {

    private KjtExceptionDao ajkExceptionDao = new KjtExceptionDao();
    private KjtSoaSpDao ajkSoaSpDao =new KjtSoaSpDao();
    public List<KjtException> list(int code){
        List<KjtException> list =ajkExceptionDao.list(code);
        for(KjtException ajkException:list){
            ajkException.setAjkSoaSp(ajkSoaSpDao.get(ajkException.getSpid()));
        }
        return list;
    }
}
