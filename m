Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C36A20370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbdJEUCp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:02:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:60801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbdJEUCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:02:44 -0400
Received: from localhost.localdomain ([37.201.193.73]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MAkkB-1eAweX0zwh-00BxX9; Thu, 05 Oct 2017 22:02:42 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.14.2(2)
Date:   Thu,  5 Oct 2017 22:02:27 +0200
Message-Id: <20171005200227.8028-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.14.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BgV79hqlSoHPOem5lP+kSZmSTqPrbNttFL7KrUV1hPWqpoXYL+J
 AJveJMLEnVrkYUCy+++SM+5FKeGcB7AoZtw/RuIGaS4JXxZxzOldRrOwlGqcB1X7BIwEhCa
 YB/6OZk8BR/7rA6MnRNGjsLP7cMGcWD/6pivfxb9m1LwBpf0StIYlCc4Q8w9F0hztFTZL+X
 nFTGDIfNPthqsvspFK0yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FWEe59bwtG4=:McUXwjgBo0JYacKer1XGQs
 GnYlhaFTVMQyfvISQhVRHURjG+Ytp7F0QfvanPRPkL2S1PB9CzgolWrgzTmO/2Oh3o/xNa6hU
 DRM0Y6CwM7EsPhKbY9NcwMBesSraWGQNOXyfOpAJsvV5uoKlEZlTLqN8DdYKXCScAnQUUjxm7
 COQgtMNVnHgBzOOoNeoGkrLdjZIOua6sBc3DMGtBT6mTPpLYx+FjRMVK2QXSjHdZdSXitHaJH
 LFpP5n1vJWv7WHCw2A6XeHvGwEOMtpGY9+dE9lJmehmUpOj/3roZCWTrg3qXJoNVesb277Jhs
 vs6ZhJ2G/+TEAxOfh3nPwsdBrPmH8Q5hWW5SNQJYZrWsIOwPMdz1pTrHog411AcEr7adjJ1Tg
 S5MHGk2hjZEpwhpyfpo3q1MwCoMuWpw4qO1YhTzqXsJw/QAT980K1HoUi3Aeipg52Bio4YnWp
 0ADf6ScQvOcNXaR0TDtyXQxcI8+U/imPqVDi7XG4JRfVUG9HSQCOvx5AfHQdyWFUGdSgl71AO
 cROv5Z1c0RItRHPuMBBr8dA2Iey0FW4iHv28YnQD3eFhNXiwODjNVhDC3ZjY6vrQLVr/XQOAm
 OTiYHr5/CSPFiajSXynusZdly3y41b6fdaqjS9wtbUHJVGhJ9Tjfhv2gzIqzj//4yU6wmt6Am
 p8uuBf5bBWwyHMKXVgPVpX9U+xy7VSms/rQFOElGMoOmu+lGofjr8QWbs23vVtrgcAkPgl9Y6
 62LaIdP79pQlnmaMitsXKhLsn/hvkCmZ/h1Gh7/N3EG75jiaI8PNGYo31VpAZPfZkGUTDavdI
 tSRKDWCqE6iXC8PSZMnMKtnpkFHI/YLyp1J+ZaFjnnPfxgdIcg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.14.2(2) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.14.2 (September 26th 2017)

New Features

  * Comes with BusyBox v1.28.0pre.16467.b4c390e17.
  * Comes with Git LFS v2.3.2.
  * Comes with cURL v7.56.0.
  * Comes with OpenSSH v7.6p1.
  * Comes with patch level 4 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 2.9.0.

Bug Fixes

  * A bug which caused the console window to be closed when executing
    certain Bash scripts was fixed.
  * A crash when calling kill <pid> for a non-existing process was
    fixed.

Filename | SHA-256
-------- | -------
Git-2.14.2.2-64-bit.exe | 6939928e9400f3b28aeb8fff4ae6f05a89604166b9a273e295143aebdc8ffdf3
Git-2.14.2.2-32-bit.exe | 18d1d5b56d6ffefb5b45061a8d1a30d5ca6c60bbabeba8ec4264cd7a1ee969dd
PortableGit-2.14.2.2-64-bit.7z.exe | d4abd9dcf951fe8e5f4b6880cf7ceb7441ad528ba022802c5d88f89625f0f423
PortableGit-2.14.2.2-32-bit.7z.exe | 5f8a574e403aacf502a836e8750cbc2a2ecf1bd296d507353343ad11488d0be4
MinGit-2.14.2.2-64-bit.zip | a9750b26113c4196c9be13301c619c410cccf65352fc21431fd0cffdb8dd05ab
MinGit-2.14.2.2-32-bit.zip | 36c770e7a6b51ffe179d5d81d3350d9ff6ca6ab883a3df150f9c0a563ca4192e
MinGit-2.14.2.2-busybox-64-bit.zip | f4a59438140380323a99801f251805aeb6ded0f08d5c3e2c40c0bd70745cc330
MinGit-2.14.2.2-busybox-32-bit.zip | a1f956bc387ea60b39e120174b4527d50ac27c050cd42a510a1d364f900de0c0
Git-2.14.2.2-64-bit.tar.bz2 | 72ae229220e303770c8e3c30f081a82e78485fce9c038a6a195eb1ceae395cbb
Git-2.14.2.2-32-bit.tar.bz2 | 58bb03c7dbf8d17021eddc842cdddc78cf50680ff69e7759fe7f066047e33bf8

Ciao,
Johannes
