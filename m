Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63594207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 14:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdFZOB4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 10:01:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:65135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdFZOBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 10:01:54 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MXVr0-1dE1zF3aGU-00WX2Q; Mon, 26 Jun 2017 16:01:51 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.13.2
Date:   Mon, 26 Jun 2017 16:01:22 +0200
Message-Id: <20170626140123.5720-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:fvswElyD+uBsoH2lXRu8oDkFK1maU87sMeBfGsHbibPEN/Il98D
 9xs0zm7ZDpTcgpsRiVvuQGJBsAp8fW9GrSDEDU3Xh2+lEwdawk7PInVCVaG+VPRzm821Hhf
 BlJMjG/3tG0wtZeH52985zSZdNfsKOqq+UbLeJodTMYIqERETpQX7TYpNJfIR7pvRWwjh1A
 h1Q0ZmKzc4nbuWUwG3UYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nqy8FHTxNd0=:R+M0JhnQ7MNzS00bchKLUP
 /A1NuQRoa7ypZgocHEcnpGkK7bNh+V702jl8sXkm0vOPbmko2nVc1yYNHdmOwhmaDt8M6ukkW
 87DV7rmRP4t49evFOllVcbAl1BIXQP5agUMubwH7VtdeEI2o2Kur2V2H3nL2btD0inr78mW8o
 In34oQlWqLkMU4Vzoi88JziECCkGOkYo8ZpK48HrgRxafofv8Bu5c+VoLLLUiT6A90AsypRjt
 cojoW7OIngmWoNsSrwCwiahkXA5OhnFc8frhw6wGd/5MonwUADxkNG3E4Ssjb68qaeVoaMfVe
 q7EYKaF5lHV4sp3spn6nVqYTPhbtTIUUX1c7ZtYdwfRko1KJPCMzf9qQ+Q/FySb3KWF1bsr7h
 lfKJvzcuGQPDmsC3cMez1Kh2Tg3OYm/etQ/qQUCxbqNOmVfEZ+1AfNnrpZy69Ywj91lyqaGic
 AgxYo3KUTQgDcAU/oAusEXuqqRCJLiHV/VgzlMymb0IFT5IHOz2LXZM4oI0HGlYRibM7cX3Di
 ED4MFQfGuZW09A9OAhsFkNYche80Wl+jd6Wggprte3I6mBixPS1qs7j+jR9sitX1dgGk7recK
 gfJIQUgtv3OCTqa8zVK+aof/fyHnt0wCQkwnwJmJntOatyjcTPOt9DQNLOnBp7wjYIKr4aSLs
 a3k1MgnplM/BCe9Cc1i/s/1UJf59xeC4y7qvkofYJRR2qNJiQCocYjgQwHAbGZgkMMzju+O//
 Aqj9jhTdaxBpNbshTstBgXX6tKc9x1VwxfZTYlLfNHX1MXOyj1z38Emn8fQS6IAt4vylKwbvx
 tsszuOn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.13.2 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.13.1(2) (June 15th 2017)

New Features

  * Comes with Git v2.13.2.
  * Comes with Git Credential Manager v1.10.1.
  * The Git Bash prompt can now be overridden by creating the file
    .config\git\git-prompt.sh.
  * Comes with cURL v7.54.1.

Filename | SHA-256
-------- | -------
Git-2.13.2-64-bit.exe | 7ac1e1c3b8ed1ee557055047ca03b1562de70c66f8fd1a90393a5405e1f1967b
Git-2.13.2-32-bit.exe | a6f828b701a65e436181e8017e4ae55129b4f680d7e95f445d1e43f26c061cb7
PortableGit-2.13.2-64-bit.7z.exe | 7cdb0234bffdd6dd0cd441da97e87b233d344790e4d957059ff09217fe48765d
PortableGit-2.13.2-32-bit.7z.exe | 125c3402971849f478bcdc6904babfc235fdea4e731e31f9a5339cf0e422685a
MinGit-2.13.2-64-bit.zip | 302a72d72c5c881f8d34183485f0e86721b7a89f2090977f3795ab89670d9c1d
MinGit-2.13.2-32-bit.zip | e7e12f2dec9361cdf496fc0378a891fcc9f6f4ffac60b1b06675e64e0bdbcdac
Git-2.13.2-64-bit.tar.bz2 | cb77390c523d466a01ef72c9678e56429fa8c112a4b75990368f7a6ff6038e9d
Git-2.13.2-32-bit.tar.bz2 | 6682457881341ac2fc581d5bad169beb5c9245c4957fc76254ef2e14806691c6

Ciao,
Johannes
