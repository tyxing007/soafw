package com.kjt.service.common.log;

import java.io.Serializable;

import com.kjt.service.common.util.RequestID;

/**
 * The Slf4jLogger implementation of Logger.
 */
public class Slf4jLogger implements Logger, Serializable {

    /**
	 * 
	 */
    private static final long serialVersionUID = 1L;

    Slf4jLogger(org.slf4j.Logger impl) {
        _impl = impl;
    }

    @Override
    public String getName() {
        return _impl.getName();
    }

    @Override
    public void trace(String message) {
        _impl.trace(RequestID.get() + message);
    }

    @Override
    public void trace(String format, Object... args) {
        _impl.trace(RequestID.get() + String.format(format, args));
    }

    @Override
    public boolean isTraceEnabled() {
        return _impl.isTraceEnabled();
    }

    @Override
    public void debug(String message) {
        _impl.debug(RequestID.get() + message);
    }

    @Override
    public void debug(String format, Object... args) {
        _impl.debug(RequestID.get() + String.format(format, args));
    }

    @Override
    public boolean isDebugEnabled() {
        return _impl.isDebugEnabled();
    }

    @Override
    public void info(String message) {
        _impl.info(RequestID.get() + message);
    }

    @Override
    public void info(String format, Object... args) {
        _impl.info(RequestID.get() + String.format(format, args));
    }

    @Override
    public boolean isInfoEnabled() {
        return _impl.isInfoEnabled();
    }

    @Override
    public void warn(String message) {
        _impl.warn(RequestID.get() + message);
    }

    @Override
    public void warn(String format, Object... args) {
        _impl.warn(RequestID.get() + String.format(format, args));
    }

    @Override
    public boolean isWarnEnabled() {
        return _impl.isWarnEnabled();
    }

    @Override
    public void error(String message) {
        _impl.error(RequestID.get() + message);
    }

    @Override
    public void error(String format, Object... args) {
        _impl.error(RequestID.get() + String.format(format, args));
    }

    @Override
    public boolean isErrorEnabled() {
        return _impl.isErrorEnabled();
    }


    //
    // private fields
    //

    private org.slf4j.Logger _impl;
}
