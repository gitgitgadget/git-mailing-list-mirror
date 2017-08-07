Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09EE20899
	for <e@80x24.org>; Mon,  7 Aug 2017 11:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbdHGLGN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 07:06:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:49361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752840AbdHGLGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 07:06:12 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0La2Xx-1dDcIp2V13-00lqDV; Mon, 07 Aug 2017 13:06:10 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.14.0(2)
Date:   Mon,  7 Aug 2017 13:06:00 +0200
Message-Id: <20170807110600.1784-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BSuUhmgGT5P4GaQfuITC5Kw7bAt8NrSPjON6nSmFZXBbmIBXvMc
 7qdlXkHdVif3tm13XjZovi1MJ5OScWMunKPKkMe6WpKpNGx9u78+SmSZ+70hKvQsPYHxSV9
 1ajy90xaPoa5NNNseeTUTvnXY0oe9T60bGnW5iCzxtUGJ+Ryv09xqAz7XXUb3JRZNjPMHq7
 NP+khwgGrGhWPYc2fHqtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AmSrLjAdVLQ=:gNPfZrAQWgQQ2Lgq8i7YIl
 yjVCsoW92SH6FNHgBtX2O8wIWlJ9xKD2keCenveYrDVtkj+qZap0SusrQe2ZVCcXt4W4bIlkf
 8BCur/mhl1BS/KbkZd0GRshTVWN7VBju3ysOgV8S4lTorSuNxaE7UHlCQVT0pe26/WvfSKKOG
 2dkYBBN9eA9JrpUd29V3cLC02ioF3RI3fXvjR1EwxLFWkzuhNP4o/v3w38MgE+YL3ZhppPf36
 mRWqGi94znAQn0z02Gb1y1hqxKc8TDjNXq78Tz+2dV52S46RPn+4s8MIRmGlsxvKiZauthtqb
 I5STuyyZkt8QyoyxTiP5p11BU+Li532WiOR4Mi3qE6bCr4uqnMHoAu+SqtfE0HJeMDO64Mx45
 KgGmSkvRki1UzW8L5y2mD4shsVexpaE+nE40D9DBqecWL6C2HGr4PdiDMFxLeNNRqPVjm4o9l
 8SyDySS4CvTjBD/pazz3hdLB8b2Ne7hi5ExtC17go1ZcPBUhZU12KjCSW4rPXrwrzk+Kraj5m
 2iG+BytqmKcPuq94O8wT2R6xpmmk8GhF2UEF5B0+O8ItHO1XWpmGMVON4MZDPxUFa3vtpHmk7
 5KQEU0nVCsFQuH3QJHwVHxtzW6aw3DQhHIbg48gYwTIEy2UFUw5veQtvYr+5h/br3xqLCgzih
 sX+DNbcowPUJJjI6B8H3ZLUWGUdPqHV9HOchNOJBeO4CAzMJpw/Pp8ybXez+wryFph3+7EETF
 Ac1diEaOPopzYw5qXDfqFOS0588WxKI4jLwCxJpyP7Ko0Fh9yxoaOWj8Jc0ur4piExM60/sgi
 2lA6To7zE0AH/8CbQgoPVT7bgFFsbngYYOp2CCbXT9h/7eNJ34=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.14.0(2) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.14.0 (August 6th 2017)

Bug Fixes

  * A regression introduced in v2.14.0 that prevented fetching via SSH
    was fixed.

Filename | SHA-256
-------- | -------
Git-2.14.0.2-64-bit.exe | cf3118ccd537f83323cdf589b272273b1580c46ea2c56453f5c20c613f07136b
Git-2.14.0.2-32-bit.exe | 9d51f4da25b6bd980cfdf0862fb3264c233aefd31cc5e89b03ceca69d21d160c
PortableGit-2.14.0.2-64-bit.7z.exe | 5236c21de3cdf52b538322de0b0444f6cd49a5bae6006ea89f0683598cbda7ac
PortableGit-2.14.0.2-32-bit.7z.exe | 77705be651d7d1f3e2c536677fc7a8b88c6f3bc16005a1c7da6346e8d80cc005
MinGit-2.14.0.2-64-bit.zip | 93560f8bd3e12d12ae92e66150907663a9716c67c5108311f9fb1e0401d928f2
MinGit-2.14.0.2-32-bit.zip | 7367b99a6a95e1b6e9722cdbed25aa63082a06f370ce4b989c2fd9c9ac88573d
MinGit-2.14.0.2-busybox-64-bit.zip | 7d3dce5f40953354091e49704ed271a52370734b01815a8617d982003665f000
MinGit-2.14.0.2-busybox-32-bit.zip | e0bfda60f1b60159b18fb05b9f7f56f9de29054e85dbd3eb6a3478a9f05e089f
Git-2.14.0.2-64-bit.tar.bz2 | 99edf5a4244121de2a5e5c0de76307ef808b5cea8a80e720cc41bc8b69cd6fca
Git-2.14.0.2-32-bit.tar.bz2 | 1d98da0b7b86e36919427e4756ba14925967ef3f05064caee917bac0deab5898

Ciao,
Johannes
