Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1289720372
	for <e@80x24.org>; Thu, 12 Oct 2017 22:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757677AbdJLWxz (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 18:53:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:54202 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757644AbdJLWxx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 18:53:53 -0400
Received: from localhost.localdomain ([37.201.193.73]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MPUZ7-1dy5Wg06Sn-004ljp; Fri, 13 Oct 2017 00:53:51 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.14.2(3)
Date:   Fri, 13 Oct 2017 00:53:39 +0200
Message-Id: <20171012225339.2808-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.14.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:TV+BWTXKyu21C3PNipmuF0cxzczY45z2eUYfDjAh4DrMMfrzGKY
 aWXwpaVoaF35KykfYDnJwLvYEiQZl19QYEWbKvVwd3gdNJgEJse4LBI4i7EKNmf8ip9UWq+
 AHnbBUvHSVX96IrrX6+Qong9KAD/a2M12l9G2ULsWCXi/B7qfznYmzXxhB3dIEcRxLrHduh
 vZzRiSQRtL2MUZDrnwaWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cWNNNTdu2S4=:QsKHC68oTOfb5iHHjKy11A
 DJSHOZyeDdjZCLZjT55xAD5O55+rLX0vYJmNccRfjuxlEjmQ5WvKX5Swg5X9UCaL47joiqXKl
 btqvjzwuCdupFCEHG/kcQYylAcCHCT2fsUeUexEhbJRJ94dJNwCs/X8OuHqgM56mEJ3QrRTR7
 R3WfW2RccrmB83J36eckbSxv6UKZtreRwZwXorpoRNG5J5f2dK79jFzaSQbJBch9bPvjvYUh/
 uyhoTewrx9oSRgp13mG76FkgNz7gzbXvhle9i6+7FNq+K8MI/ee0zcB1OD8qD4h3OiPR9vWfo
 lbo/W13f585GMS9DUWeHltxvKFl1MWHWnsYWLuonbfBnl88uMe0ntttgogafCKhyts2t+NG3w
 +DU6uPxoX66uz1ZmNWxma0wPlIkrHSFsjrVW2GMkG+DOVedfL1bOFFYCdDa+t9tkS101km4qX
 RpbIqiPixGHwWKawdtdPAIwPQclsb5RUkWae13e07tzelTgmNfzf10WNa62RxmWkN0ZN6HZkZ
 PxLIE5bFaZzXriZCoEKq+PpP36hJKjyPmSa3Z3RPU5xZZ6NTYNAKsD6zYF8KK+jrxgNSezGKc
 5ymu7ZwUcy5SjXlfLocnD3bk0Bw/q+nQ2l2JqCyK5+DCSYr+fx5KzBXX3StdA6TjntKeyvHgD
 pYfNkfOOsHSCU8Y4CHl7IZdlwNAedWfImduG+gaW3DwuH4sIrcVhGbKQ1WamUyvfP9IYWKJcd
 nReFrEeEw6KRUtYsKLzCKtdwylXjlmUD0NkBTueKmVB1y1Nkzbl33nud8pvrEcYO3GwFcMEJP
 qrS41AW+85u8OmCosqOP91kt+frkKTWp0yiPuYO75Ha6gifVik=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.14.2(3) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.14.2(2) (October 5th 2017)

New Features

  * Comes with Git LFS v2.3.3.

Bug Fixes

  * Re-enabled some SSHv1 ciphers since some sites (e.g. Visual Studio
    Team Services) rely on them for the time being.

Filename | SHA-256
-------- | -------
Git-2.14.2.3-64-bit.exe | 819120ce83b07c053f59c53e22682c14ef9ca3ac24a9a2b6a744df1c050afba1
Git-2.14.2.3-32-bit.exe | 0b07ffb89ccd20c760cd9d4229e65ce732ed66713a4c8ac7dbedc95562c8adf6
PortableGit-2.14.2.3-64-bit.7z.exe | 3525a7e7eb5775d38e65b2981c6e315dd97b93829bd322628a8bb2698ffdf63a
PortableGit-2.14.2.3-32-bit.7z.exe | c4d8829b6783ed9f725d9d112eefc31a1b103ea97e4728ab47a3636c08408155
MinGit-2.14.2.3-64-bit.zip | ac351c9dcdc2142b3b07b056c818927a41c32d7c615a2f7f8d18121881a3c6f0
MinGit-2.14.2.3-32-bit.zip | 7cc1f27e1cfe79381e1a504a5fc7bc33951ac9031cd14c3bf478769d21a26cce
MinGit-2.14.2.3-busybox-64-bit.zip | 9418629fcd1d782cda5679ccbae9df679be77660c7937ab19d1d80f742fbc763
MinGit-2.14.2.3-busybox-32-bit.zip | 2c1ea230b90081bcb268e05a0ae9660599881cdad6c8a34e02bd1aad4182ec90
Git-2.14.2.3-64-bit.tar.bz2 | 3d33a94473f8839b71f23fcdcf5f1f6aaf94b88d5efd169fb17ce3884da4e9df
Git-2.14.2.3-32-bit.tar.bz2 | 510d10e59463697255210f5deb4a42135fbff5fda8fc15e1b14bc2befb92e1c1

Ciao,
Johannes
