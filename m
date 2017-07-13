Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB3F202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdGMMrd (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 08:47:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:56318 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbdGMMrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 08:47:32 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LslCb-1dgNuS2l57-012Fj9; Thu, 13 Jul 2017 14:47:29 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.13.3
Date:   Thu, 13 Jul 2017 14:47:13 +0200
Message-Id: <20170713124713.2672-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:AlylykSWpXn5ogzK/nYrZD0L+uH8eEW7Uq6+e2/AwR624zU95jf
 elmjvuEUJaBR62un9IYvbrZ9999YgmkMoSsB09a+Nq6TOgW2DhmFN7Nr3EEgfKC2ZCN+9xi
 kvX7wTqDTx31otEa0pWxkMGawjAA/c+6BnI4Tvgym7QvcqPADFV4YQVsPYYDjytRzhBGvFG
 mNvXRZHRFYNmc3A0YGJSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fpjhGlnbLvc=:pH4n1jr+wbPXee8UTpkR0J
 lnhQPr+gjLk2MC+UFxAp/1n+JCOzSKv4C0CEdx8YVmEQXYThCxYLW9/frONjTUQrHzlipfYEu
 Z8CPzvDXfvVwAlgnJGQo2FKfGqXZE7N7t5PVZZPw5B4jq9Q/LLLgUSr1rQKtneUGURHvwegpR
 zWTyfF/JTGgKVnribwcA9XFiMUT/N5GRXPEgeZCUuR7F1X4tUDj5pR4OQ7up+y/sDY2wUID7C
 3jYocZ3EH+S7iBNUXH0K+vNro0Gk5KXQfb1YS6rw+qLVIzgcf1aSGQ0swdAPpTyFjCbSXKCJb
 vkHfsfRWIQ8kJ4SAkidb+hCMCwp7FbSRR/gjoymixPx7gviZI2lmAAy0SB2zrgWZRiDdjcK0B
 4aZo+EIIklDqiJaHryJEAD+RtYgDL7nF3GRNZanCeeXMBxGNUPGr+LxdGKzpNqHTILAMxMBf4
 9hAKvWNPg6f/fh1QiRNMscz1/LLNMbucT2SRHIDCzMeD4zjP2ZIyymox/If5qmIbK++xwo5lp
 FyAHdR7bNt1ZCe/+kl/wbiCTB/f19S2wUEXeot5AMEH91gCkZBGfAT3txUaZf9YflA6l3UioD
 dypuSNvblOTXwnOLGrQdFGcy5p3iQ1bSIHdlld6j+uVuZA1HG3au68wGIdWRYSsugP5Re6EBT
 e7GZQpgyhDV82DA0GngJWUZYGlPmAvljcUgY2FJ7LXCZSF6wGXwgyA6XAkdtW2QEaHi+1n2Z5
 5TyxxCjMw5u7yblPB7goo6FxDkpfpfprSSnlQ5xexS6P4Xp9ooLb6YN6b2fxctSXv5VsLI6JH
 TAkmvvCUlmrud9QIjU64PblP23g3eGfWLBz3Y1xDToSo1vH7R0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.13.3 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.13.2 (June 26th 2017)

New Features

  * Comes with Git v2.13.3.
  * Comes with Git LFS v2.2.1.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    2.8.2.

Bug Fixes

  * Git Bash no longer tries to use the getent tool which was never
    shipped with Git for Windows.

Filename | SHA-256
-------- | -------
Git-2.13.3-64-bit.exe | 015403bd098ab2876ec5f6392ed7a64c8d18d2dbbe23afae095424655653026a
Git-2.13.3-32-bit.exe | 94ec459292ddb00652a02f8c441d155323312b17935c74daca3d7acc63f5919e
PortableGit-2.13.3-64-bit.7z.exe | 2e6f5ee5b118805f45b19aee57f4e138886714a2162bca229640111635efb4b7
PortableGit-2.13.3-32-bit.7z.exe | a0951eb732808689f9ea78a93e87e1437eee34f7d0657c3d4895820f436ec9ce
MinGit-2.13.3-64-bit.zip | 97063e2139cac40f3c8f547b85f031765062581101d69ad468188c9de0b1dca3
MinGit-2.13.3-32-bit.zip | d1549ceb8169d3f414d8f86671db60f302895a785c21c438d061d7d599bae83a
Git-2.13.3-64-bit.tar.bz2 | 741da847e4d8ee7c21eebf4d9ac6bbe6766cf50d388a4ac269751ec1bb2e051d
Git-2.13.3-32-bit.tar.bz2 | 47cf427cb1b868b7f633e97ec54c1f271f7799b4450c02df22bc967d966d9c80

Ciao,
Johannes
