Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11401FD99
	for <e@80x24.org>; Sat, 13 Aug 2016 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcHMKWU (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 06:22:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:64077 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbcHMKWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 06:22:19 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MV1wf-1bia8r1wdh-00YNyj; Sat, 13 Aug 2016 12:14:16
 +0200
Date:	Sat, 13 Aug 2016 12:14:15 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: [ANNOUNCE] Git for Windows 2.9.3
Message-ID: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-703494712-1471083256=:4924"
X-Provags-ID: V03:K0:jXb0eIMaDvAY6cSHblrC6opZh3JKioiWVCaj5AZXMbVAyN1Gzwb
 HOoVUzzAxTpeQTNB/b1A1BbtGYoY5ATpY0RV6LBG+POhqDkzxwxQYU6J1tn7IuxNKsbtelq
 2n83XZRHlAWXi3PClDKJsCnawbyI0ZOgGvw8ABwm2nDT/RVk9lAoG6K4i8WEy2nivAqnASr
 RidP5B9jWOwjAh31sozOw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/O1FkYCKY3c=:p+UeAGLM647yZbHskQID12
 XXztIn+B3Htn8R0ucRCIUKtBR3D2aVbgsvmRTZqra+8YhmqGrDvzSukDPe7LAsW6JckVcmAl8
 nO82n4v7A29XywoOF0TzAzHSzEbVL/Yfylb1+1xAiJal/5WmYPfk4SO29L6nEWk1tBhmkKhBU
 OqcB7d6/tSJaLGCHPA5pY3ZhU1WxWqh1HLQGJ4+1TWK9MkdTLnZnh2+Q6g8uYbhdt7rpOaeeF
 +ZklbxceOP6fDsptbHXFy3Zqfp5l1IEy9Ba9UoOT9vNPWMOcCtlPfgppm9UxX3DJcq/thl6Nk
 IrtB1bv7a18+Ohm6chtNW+4hDA0km/BUeDm8uw7I8nVBkxUnhIJ9mW7ndMRpMWlz4XxFsm+qN
 HwM8gkZ+xmQX7wcqJhSwtmJUIMnJtc0lXb4lDwyinYnuqYt00/dHUweqzcy9fbeoqM8PPCDMW
 j5xUGurJeRrivCJjZJ/6gVOiC29OgJ4hoLnLai6estUcLxMzGLlBd5z9DVnZTnlB072Xz054c
 yvzGgIj+yhYMLvQDS6tFlr+2AJweMk5sI8kwVpOUmoQUvdx4Q+Ue+cfF24Hk6P8eRxDtFuDmk
 SRM9Zk2Qx+FmrMxdIylZM6T6FAm2n6/uvH0ecD7I2Pelut07Xe9BI21uD6C/oxBieWXGSd7Wc
 JPLRiWVTNgfLnzky8fCz4VRCarRxEJ+YMsgtAVNmJOjMlM7+5E6mM9i3B5FB85wGBpGzf1nR+
 CpH0XNpy/BePlmIQhaS7YIX7DXxm+IC35YRMHPnhi8oWQy9x1FMH0i5jc97X6kQQ1M3OZV/iw
 VYe34rS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-703494712-1471083256=:4924
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.9.3 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.9.2 (July 16th 2016)

New Features

  =E2=80=A2 Comes with Git 2.9.3.
  =E2=80=A2 Updated Git Credential Manager to version 1.6.0.
  =E2=80=A2 Includes support for git status --porcelain=3Dv2.
  =E2=80=A2 Avoids evaluating unnecessary patch IDs when determining which
    commits do not need to be rebased because they are already
    upstream.
  =E2=80=A2 Sports a new --smudge option for git cat-file that lets it pass
    blob contents through smudge filters configured for the specified
    path.

Bug Fixes

  =E2=80=A2 When offering to Launch Git Bash after the installation, it now
    launches in the home directory, consistent with the Git Bash Start
    Menu entry.
  =E2=80=A2 When ~/.gitconfig sets core.hideDotFiles=3Dfalse, git init resp=
ects
    that again.

Filename | SHA-256
-------- | -------
Git-2.9.3-64-bit.exe | 1a642cf2914e18fa868b1ed2c6d1df4a46ba8ef30355fd196585=
0895a658e024
Git-2.9.3-32-bit.exe | d6b4a19536ad408018688f1242ab0d1f5dc5544109662bfddf91=
5f685eba58a9
PortableGit-2.9.3-64-bit.7z.exe | 3423ea5c7e025a67903e05d1493680d6d5d666642=
9a9c400cc9e33beea5adb1b
PortableGit-2.9.3-32-bit.7z.exe | cd142cbb124d7c3e3c3bf144785e57573afd2fc9c=
043447b7f5111ec044e6ced
MinGit-2.9.3-64-bit.zip | 17e40cb149ce6a348c8e8bbe7f1c1fff00f82882f0e57f32d=
60ea5c26feeef98
MinGit-2.9.3-32-bit.zip | 3c6515c09ccb7d1aa6620db51245c87f9836fbde5ee9af6c8=
49b4cbd506f60e8
Git-2.9.3-64-bit.tar.bz2 | 7b165d400c2bcc427881d502dd46cd442e512053d92cba8b=
3e46173c5028e427
Git-2.9.3-32-bit.tar.bz2 | 00f265ddbbfedd25a8a0c38a33a6cb12761101a019f0c7f6=
189f07e771a522b7

Ciao,
Johannes
--8323329-703494712-1471083256=:4924--
