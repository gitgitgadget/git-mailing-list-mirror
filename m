Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7081F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeJFASN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 20:18:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:37605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJFASN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 20:18:13 -0400
Received: from localhost.localdomain ([65.55.188.218]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MLunc-1g59IS0TqG-007p7w; Fri, 05 Oct 2018 19:18:32 +0200
Received: from localhost.localdomain ([65.55.188.218]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MLunc-1g59IS0TqG-007p7w; Fri, 05 Oct 2018 19:18:32 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.19.1
Date:   Fri,  5 Oct 2018 17:18:25 +0000
Message-Id: <20181005171825.3936-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.19.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CvM2xN02SdZNVPihX07xDH1BZD7k/jcaSPCwvtV929ak6F2Kw+A
 s0iW1/SlM1cbbLk/E/lSsAJgrhUGvD3bh36IpkAQN2GZsehG+UEMtlWd8gKNonPigdcs3PN
 S9rSpcYPwutJifa0LkkyDvZUV6PD45n/htjHvuudU+NdIj3+BX5AnqMajywiKTu+MJvW5ff
 XXAfOnRzaj3+cra7lXRvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dXwr2zpPvq0=:/dip89alzgbYj4zajE+U8D
 zupeRwF3vx15d5Z935Zet9F8S8gTY2uHvLf/p6ylpAKoXlB2tFFefZnjmYzrX7IMd61tBAA33
 VWUBYof2JLixl0N23iELyGvpYxT5QgijAwRLIfQUS0MNvMrCMjWrQOlCWz0jZ9mpqOJJjVu2h
 tKjkaHsTdhYjGgXDHCIdT7TKOFoE3LtcM7IJix4gWqrblmgezGTfCeYYg/uBbkJ+22iMTevCK
 wa9gUlW4g4N+C1E1RtMqxfP710bFRBYUt8rXBwsVqKrq/m9rX3idGNaXUBakzy4n0Gqg4NgSW
 8QnVRspFDNAouYCuq/O7d3y6rGfMkgwPH9+9KXt/gExVu/GFB5qxW1Dnx7rriKGi9rAJOB5AP
 Ji7Qg5Rvq6IotsjqbA9k0kMJlz6H1ZsUkF1tCZRG5NeVjKa6SG/W/I0y/JNDU4wP6EDpp74nz
 IzNEPwAfyDYtLnr+ROX8F/+7y0lAsmQiH8vNCDOBHONqZTepCSVDehY3Cr9ruqI8B7a4gac38
 OBR8WE4nJo73SC+dsQCDcgzFR3xujzOR42E2nHQ4Mw1gtbzZQDqQ532EFXEHusxLZ/V05yrcn
 f16h5SP9qPrWraeaUFM8Y77jnNUBTf5rkK4pjD9sMB1GYm2r6q5VKPr7gks675sP30Wo7hiUA
 dIt0ps6EcE9f+O+alspwYtd83zy+UCraoNiYnCQJTMt/kxtXvt5GzJvcqUsMYILn0lfCtc7a2
 4jWD4KAkEzH+0qCG761CJp8v/dDjIqijgB+giW+evHwwqOchitEySGCgE0UZtwM/ZG237C6Ml
 Y1COjKwukA5lfcqfXXKmJw4h3ZWcJpXDZFC5r0hr8QVqDAsCQI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.19.1 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.19.0 (September 11th 2018)

New Features

  * Comes with Git v2.19.1.
  * Comes with Git LFS v2.5.2.
  * Comes with Git Credential Manager v1.17.2.
  * When FSCache is enabled, commands such as add, commit, and reset
    are now much faster.
  * Sublime Text, Atom, and even the new user-specific VS Code
    installations can now by used as Git's default editor.
  * Comes with Git Credential Manager v1.18.0.

Bug Fixes

  * Several corner case bugs were fixed in the built-in rebase/stash
    commands.
  * An occasional crash in git gc (which had been introduced into
    v2.19.0) has been fixed.

Filename | SHA-256
-------- | -------
Git-2.19.1-64-bit.exe | 5e11205840937dd4dfa4a2a7943d08da7443faa41d92ccc5dafbb4f82e724793
Git-2.19.1-32-bit.exe | a94ab28c2a9c20cf1ef061a2acce5b2de572773e5efed0e994d89380f458d52a
PortableGit-2.19.1-64-bit.7z.exe | 419fc2141b5d17c5ad73d9b2306cd3b2f5114c50bd67558cdc538da2c8e67b66
PortableGit-2.19.1-32-bit.7z.exe | 03b993c9aa336259c293eaf3f123f6591a9c8f2939d2129810332d5f64d553a6
MinGit-2.19.1-64-bit.zip | f89e103a41bda8e12efeaab198a8c20bb4a84804683862da518ee2cb66a5a5b3
MinGit-2.19.1-32-bit.zip | 9bde728fe03f66a022b3e41408902ccfceb56a34067db1f35d6509375b9be922
MinGit-2.19.1-busybox-64-bit.zip | aa2c0dd240c9db66a85d8633fb9f90cbcc10cb00c86cc37880bdde691c1362de
MinGit-2.19.1-busybox-32-bit.zip | 179c7810e6f388e37a6b4073e9cfc2d109598061787dc913b3813b78fecafa97
Git-2.19.1-64-bit.tar.bz2 | 7b4de9b248dcec6f28210f14af2cf1eb31e1400e3c4f139a277fcdd7691486d2
Git-2.19.1-32-bit.tar.bz2 | 4ae9ce6fe7a5fe4b149dc8e24f1a7db3dff5285225e10aa6c0e39284ad0548bd
pdbs-for-git-64-bit-2.19.1.1.11a3092e18-1.zip | 856c9fb0eb8b2ffb6b6b4b3c2f5ffb37add31c60aed1662b0784114d57444d5e
pdbs-for-git-32-bit-2.19.1.1.11a3092e18-1.zip | 83191c41776fc3c4d16e2abd686d881d36f5c5e9320a34826fcee33dd74f8a0d

Ciao,
Johannes
