Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8612202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 01:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdJXBra (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 21:47:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:56543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdJXBr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 21:47:29 -0400
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MPm54-1eAdno1TAw-004zyb; Tue, 24 Oct 2017 03:47:26 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.14.3
Date:   Tue, 24 Oct 2017 01:47:18 +0000
Message-Id: <20171024014718.16476-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.14.3.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ddokFDevZK69yUlMs+tY8mGBK534TcpnIPKkd+sKjGvipjDJOo8
 IZkV0mQ+r1av2UWwYkp3RIE7KFqRLA7hjFyl6l4wroVxZ83Iwd9520/UU3f7phZVgAtPrpp
 ppDFuxaxKm+UIYDLd8unX3ldZPb4cULmTiiPaEPCVTbG5eBLQwjbt17vqk5hlnzKBJ1hzq8
 Y1H1jg3B6YUI/RYJRUiew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XZu8+ztyoYM=:uSP9y11ioRlq3cwnWXjpR6
 Bz/TXbeGwjr0NthcjSt9C+v5fixdXEstvUR0kUrsL4oXtPJgQ9Jtye/J32znC1NvpXNWy6p+4
 6xReWzPEolz5mQFfogNXpLYT6TP/s4LJ5IuC6ksX5phgw4lY0xEi4FpF1XJGVxZIsQ170vjyH
 ulvSmDUyIf7B9ib3IPDRkZQEzj4i+NKabRTF2kqh6x8Xu8UehoVUqgTrHlDiYmosCHLDhmjsQ
 a/AvG9eVSPvAdBxHKOwutMapeJb+EG13IhNZKmCIYXa/Q0kq8Xa8mI2bvQgvLb6lFMvpkWBUl
 MYMisxS9dWMnQdGGDGGi+tD4cdPk+uo9PQZbDj+t0UJll7Tr1j8bqLNio3njFoocyI3sF+Pvi
 x11DoAeOubBBqK58Zv2W9uC+FgfFBsCBocRQb13HPbZrrabvbcZWIl+KWD4eXFzFNX4fzWgmj
 tMD5RBlvWkjAGkhm0JiK6r8qeEeUuIY7mnh/lC8uod6qlSfUKAJYrDBlnqaPtH9mVKdDk9fcL
 s5drgytCbR2FHBTzPdiCPmDwq02RjSbRYNXdePpPnNINJ3R+3gIIc4R45gVdHYSD43ZyUtHdL
 JzLY3ai+bf08hpOALtVwh7+O8CsXAi/pUaNDZ8yafoKZq600gAlqVmNjHosA+IPz4Dxz0Szru
 nxjZ74DEw4xe76sf3yPjg+Omf8fqe9HxN2trw5foEORFkfy6Wn7BYXSRJ/PTFAuQ94KhO5xHG
 tjmCT9fvP0e8N4vvBypXw4EhqDEC5OjXP6tdi81ijIDkf26trvEqKsFUdwI0smWodCB+5I6xj
 fd1Uoa9BZQuPvjH4GbgG0rGbgJ19A6kJbwsZWyWhQueS5ih3D8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.14.3 is available from:

	https://git-for-windows.github.io/



Filename | SHA-256
-------- | -------
Git-2.14.3-64-bit.exe | 9610e082b823beb7f0da91a98d9f73e1f3f2430c21b2c4e15517dea4f981be3f
Git-2.14.3-32-bit.exe | 6e5a8a939f3014b396f58622954ab394d7982d036c84571394118f2360bdca96
PortableGit-2.14.3-64-bit.7z.exe | 2b1d952078795117a8c4549f6384275e047ebd75c10bea77e675f8b672e6d87a
PortableGit-2.14.3-32-bit.7z.exe | f2dcb32c3133188d0b7a2c3683adcbebcc10b054467e1754d1b8b7e534a34494
MinGit-2.14.3-64-bit.zip | 538294d2b1472e561493b67855f92380d8139011c74be6bf3cdc5b5d321b1345
MinGit-2.14.3-32-bit.zip | a91385acb1da220612790807c41d0f304b41093c474b9d7342230ec194a3398e
MinGit-2.14.3-busybox-64-bit.zip | b7710c7668d7ad3f1f5f7530b601d9bafbe66fcef5563c8ab74d442ac9478d8e
MinGit-2.14.3-busybox-32-bit.zip | 8982fd12c60a9edd1b6f5f8465354534920bae351d38c867a2f4034a807d8231
Git-2.14.3-64-bit.tar.bz2 | a5f09850334d5069afa0013249cc6678a7cde52c673823e5386d5cad9df41f10
Git-2.14.3-32-bit.tar.bz2 | 644b7d7593e675f68a5a011d19a0a917430b79fb815f6260b807c00651696fa2

Ciao,
Johannes
