Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F551F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbcICNRv (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 09:17:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:65487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753910AbcICNRu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 09:17:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MKpQ4-1bgAp739KS-0004wr; Sat, 03 Sep 2016 15:17:29
 +0200
Date:   Sat, 3 Sep 2016 15:17:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: [ANNOUNCE] Git for Windows 2.10.0
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-993968711-1472908649=:129229"
Message-ID: <0MZD0K-1bNOQ13s6O-00Ku7h@mail.gmx.com>
X-Provags-ID: V03:K0:UITREIGZnyiS/aVGoDLKpDzyCQSygbRdj+PtBiPrmd2OhrGlv3L
 es5pys3xKX72ik5UbmBk84fq1jVJOXZrvgrpcymq1Q4huAOyeOSOi8Qdw5wEUEhvzF6x5Cv
 cw3aMLrZAQBlHDyzhrUdv2QQ/pqfPBjcu9Q5DrRVTVu51ojfHk1D4SZQXNBMqIEwsNNhCYc
 4ufhQNdC5B4UXAgc+gdWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JOYoSzF/tMM=:SQTEwatVKm3sFoirbED31u
 Yw75uvQlQ4/wsqM0/jkOm+kJ63xOyVst0uPixGaDXzOJkEDtkzNXxTo2TxagZDbvGYTGO6dd9
 dnKiK4dAbp9q3xV4EJXwzBHcnCUr2yf8W0ECpnaJ7x0XCcuVNjX+DRe00gDSry9qh94vU1H5x
 lcIJQmgk0rNgJ6/XLD3FO3lceEXDXwrHDwNWVWnxxlFID7Zgh/RjGUPAA5idS8zuN1H6OTqA4
 6+aR0dgXtsjGx1NQga9WyCd5yGXHhtSYzuEmtw9mghU5SOE9Eq6QEZHEPDb8q2B8ODmA1c3pJ
 yaXoQduWLTn6F9bAkGNhZU1jlBvtuol1c/vObAcXkwg246tWGlGuhaOR5iqLajmnZ0v9u4UJy
 hU0AwLh4CYpB8C4HVf9JoNWGjBXhu3/SXh9LmC3H9XMe6t+cVjyLrqsgcdxRPmN6KsKWsucUV
 t70IR0YoUJUBgKLLCnU/ceArOtMuYQ0SHAQCr9aKvQ803q/7UW15GVQH/1CvJ1G6/sPIJZ0Gf
 Gj9SAahswXzfbZKtm85gGuBwSo2b+37Pzc/agRTG/QRAKsh2adsnT3G1goRw0Raas6YWI7GDj
 F4MzL2zuWed1xbK3gXZ/ySOu9ZuNLECGy1c5IPHOl7KWQV8yu+INWixnKEn8xpffY6cVO3qi8
 JjbP8jD24SoqAlUbinlrNvQdQoEXlzU8VHR6Q4NymOJq5XlH8xvpM/bSInKzIniXgjSJF3oaD
 GnHvAG4Oz3dp1y6J12btETtHGXXxI549gxlWl31tdL3zOsBULx3eAU9vkTHcTxPAaQzKBwhiV
 vMzoZJt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-993968711-1472908649=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.10.0 is available.
This time, I even blogged about it, primarily because I am so excited
about the speed improvements of rebase -i:

https://blogs.msdn.microsoft.com/visualstudioalm/2016/09/03/whats-new-in-gi=
t-for-windows-2-10/

As always, you can download it from: https://git-for-windows.github.io/

Changes since Git for Windows v2.9.3(2) (August 25th 2016)

New Features

  =E2=80=A2 Comes with Git v2.10.0.
  =E2=80=A2 The git rebase -i command was made faster by reimplementing lar=
ge
    parts in C.
  =E2=80=A2 After helping the end-users to use the new defaults for PATH an=
d
    FSCache, the installer now respects the saved settings again.
  =E2=80=A2 git version --build-options now also reports the architecture.

Bug Fixes

  =E2=80=A2 When upgrading Git for Windows, the installer no longer opens a
    second window while uninstalling the previous version.
  =E2=80=A2 Git for Windows' SDK can build an installer out of the box agai=
n,
    without requiring an extra package to be installed.

Filename | SHA-256
-------- | -------
Git-2.10.0-64-bit.exe | d624e08991a7a28b7156e384503228273e2da4c74c20b21152a=
97f4a304886da
Git-2.10.0-32-bit.exe | 5d565da086a0b7aca46face8439146826ddd51ffeb286845be8=
9fe4c2713d63c
PortableGit-2.10.0-64-bit.7z.exe | d23b81e88949042d34e97bfd1e5b579d4b6aadec=
085c6ff6b05c4579da1d49e4
PortableGit-2.10.0-32-bit.7z.exe | 89940cca2a8e1b18b5ed6e3d46c97ea4fcfe1628=
cda3ae452cd2a8984a3c25c8
MinGit-2.10.0-64-bit.zip | 2e1101ec57da526728704c04792293613f3c5aa18e65f13a=
4129d00b54de2087
MinGit-2.10.0-32-bit.zip | 36f890870126dcf840d87eaec7e55b8a483bc336ebf8970d=
e2f9d549a3cfc195
Git-2.10.0-64-bit.tar.bz2 | 4c98383ed38ba6000cad9d80c1819f686692d90e0042077=
26085e823f6928ebc
Git-2.10.0-32-bit.tar.bz2 | 0b132212b858743934d47f40f38e29eef0c1a06c735b0e9=
889ab6e0d9c195d81

Ciao,
Johannes
--8323329-993968711-1472908649=:129229--
