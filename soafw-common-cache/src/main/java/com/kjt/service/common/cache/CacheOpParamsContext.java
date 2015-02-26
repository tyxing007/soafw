package com.kjt.service.common.cache;

import com.kjt.service.common.cache.annotation.CacheOpParams;

public class CacheOpParamsContext {
    private static final ThreadLocal<CacheOpParams> expires =
            new InheritableThreadLocal<CacheOpParams>();

    public static void setOpParams(CacheOpParams expire) {
        expires.set(expire);
    }

    public static CacheOpParams getOpParams() {
        return expires.get();
    }
}
