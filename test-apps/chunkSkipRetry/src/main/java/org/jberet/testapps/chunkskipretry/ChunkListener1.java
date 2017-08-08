/*
 * Copyright (c) 2017 Red Hat, Inc. and/or its affiliates.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 * Cheng Fang - Initial API and implementation
 */

package org.jberet.testapps.chunkskipretry;

import javax.batch.api.chunk.listener.ChunkListener;
import javax.batch.runtime.context.JobContext;
import javax.inject.Inject;
import javax.inject.Named;

/**
 * Impl of {@code javax.batch.api.chunk.listener.ChunkListener} to verify
 * chunk listener methods, especially its {@code onError} is correctly called
 * before transaction rollback upon chunk error.
 *
 * @since 1.3.0.Beta7, 1.2.5.Final
 */
@Named
public class ChunkListener1 implements ChunkListener {
    static final String before = "(";
    static final String after = ")";
    static final String error = "x";

    @Inject
    private JobContext jobContext;

    @Override
    public void beforeChunk() throws Exception {
        appendJobExitStatus(before);
    }

    @Override
    public void onError(final Exception ex) throws Exception {
        appendJobExitStatus(error);
    }

    @Override
    public void afterChunk() throws Exception {
        appendJobExitStatus(after);
    }

    private void appendJobExitStatus(final String toAdd) {
        final String exitStatus = jobContext.getExitStatus();
        if (exitStatus == null) {
            jobContext.setExitStatus(toAdd);
        } else {
            jobContext.setExitStatus(exitStatus + toAdd);
        }
    }
}
