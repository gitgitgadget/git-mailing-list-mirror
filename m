Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_MIXED_ES shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C7F1F405
	for <e@80x24.org>; Sat, 15 Dec 2018 17:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeLORAA (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 12:00:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:52767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLORAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 12:00:00 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaW7Z-1groVb30MD-00K6rW; Sat, 15
 Dec 2018 17:59:58 +0100
Date:   Sat, 15 Dec 2018 17:59:42 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.20.1
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <0LkTSx-1hA1sj3Kkl-00cSlA@mail.gmx.com>
X-Provags-ID: V03:K1:El6xSncD9G5s6mcq0yG/GQsdTOKaDNaoxy5l5infR8HFWz+WXov
 0QGNboLcbCNgK6ZHtWKeyGI1DVmoTxpeu6/M+b0AoVMkpjsquUTQWoqjLACuUzWf/rL9RXH
 c9D3+S+4gpzJEGKfNTaH37Lb2og1u1hfzOf4xSQLAquUFE6NTNwAJ9LeGKpU9sYM7KO9ndM
 68GdXyAdgzliJkZKsAhnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fJZiOyHanZo=:/oE0X5/mTDka3mzyH/yq0j
 YkgNf1ldVh8/+mvawxahiYc245FIAIlOX00mMP96NQcxc9TmI0FBsX7YiteeS1uNe6/FPIM/I
 FsSolKZTVLSdFCeFaOQ2k2XhTzwET5q/jzGXHxpWqa7S0PZp0ph92majKFR7XlzvcXVmjYEPj
 2Q51vntoLVNiIMkGOZ51BxpoBrH6hTK8l0rRnRPDSraVdoItiLJOpUrURPxlgwpUQcxu+4j2c
 jok7ncffshmjLlhDCWqV+xhTIEPh+bRZ67ZwTqzb7P8t9Y8uKE/2QNM/aH1B1vHquss15en2u
 PqrxJ0fMxSUL9bzZ9oyaL5y47Wgg1jFS3uslYoO3H48hOL9ecZW02QxziCIyVId0cf8OJU7n6
 C9GLGUaFmKxFka09BdCkPbDOsglPavj0nTuCorkZWq/IE7sxwoSRf52jSg0sTl/6xXScFUokg
 ySpB3yVnnpXi2y30Pf6qaVZ78tO6KLZImV827yIQG+WH/mKntZ5Zu0H/U+NfRTkplf6MReZU9
 KJsJYaXDbFKABB/MsDDZbJQTJYDeSuhbEtNpXtfJjxZ15AL+2zPljLHtguCa9Ibff9Yh9t5qG
 hf5eddNqJ4Z8vgL2Lg5ZQNbxqf7qfwRgCSvmuujQVCT1yUkkqIXbRW+efcd8vxrC0elHhoxro
 kedT0NiXd718qILnkICzVxKD675QaLzSYhJzlJwdPTVAlMGWObgcSVJCteh3XoukJYDiS15a9
 wH9jmqqVw0+HxaUgylIArQgKBZL48IfKgI439j2cikqvz7SljiSHEA4BDK2guze5jNDy+ch9o
 agHoXgdk4l9Yspi4bBjbQbewZfZEVSwYu+4vfGfSxT5/tKYOVzC+Sz5+tQgZELdF5QAlQiN1i
 GBsSbsBoyW7ePspeHp6qT1IYUlINBODjIcF9rOpxnLr8a3KN+JWpNTYVW0TdlyhGE162vGPY4
 Non0tTdrUxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.20.1 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.20.0 (December 10th 2018)

New Features

  * Comes with Git v2.20.1.
  * Comes with cURL v7.63.0.

Bug Fixes

  * Fixes a speed regression in the built-in rebase.

Filename | SHA-256
-------- | -------
Git-2.20.1-64-bit.exe | 0dce453188d4aed938e3fd1919393a3600dd3dfe100f3fc92f54f80e372e031f
Git-2.20.1-32-bit.exe | f9ee8d72bed562e01e41ca335f4d1db6ec1b3ac5ffe4494bf8bce0a38bb527bd
PortableGit-2.20.1-64-bit.7z.exe | 4c0fc0c77d577f8dbb3d7711283458ba1d0ce1781cfe0d49c940abbcdf18faa0
PortableGit-2.20.1-32-bit.7z.exe | 64e9b5cfb9b6381f9791225287d80a3705341ca93e7483af9ded54bfff731dbe
MinGit-2.20.1-64-bit.zip | 02328f37eeefe8d8f5396553ac8f91c98d09e533d49d93c617a4643915a76552
MinGit-2.20.1-32-bit.zip | a51b66795c45e3cd1a6041fa6bcc606175870bb2c777f4cfc3dc12c7973ae634
MinGit-2.20.1-busybox-64-bit.zip | 9817ab455d9cbd0b09d8664b4afbe4bbf78d18b556b3541d09238501a749486c
MinGit-2.20.1-busybox-32-bit.zip | da0c03e3b6e77004efafd7c244dc62e92b4f78642d83234b0c62367c6ab2ad95
Git-2.20.1-64-bit.tar.bz2 | 8a35be30f2a5de01b173d81de6355bff9090cc069e265f7e996116acbf21fd78
Git-2.20.1-32-bit.tar.bz2 | 3bace612f3e0c8fd0a470bc4f0a7af88b3fcf051550102b399997e75eb1d887e
pdbs-for-git-64-bit-2.20.1.1.7c9fbc07db-1.zip | 6f0178fcf26a6eaaf9a0d2aea3504e828d3b92735967bacefe9bc743608a9471
pdbs-for-git-32-bit-2.20.1.1.7c9fbc07db-1.zip | e1f601c22e3e7142b96d468ff949db741d38200ca77d0d27e4e0b839261f0cd6

Ciao,
Johannes
